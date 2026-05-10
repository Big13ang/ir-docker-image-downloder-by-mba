#!/usr/bin/env bash
set -euo pipefail

IMAGE="${1:-}"
OUTPUT_NAME="${2:-}"
COMPRESSION="${COMPRESSION:-zstd}"
ZSTD_LEVEL="${ZSTD_LEVEL:-10}"
SPLIT_SIZE_MB="${SPLIT_SIZE_MB:-1900}"
OUTPUT_DIR="${OUTPUT_DIR:-docker-images}"

if [ -z "$IMAGE" ]; then
  echo "Usage: $0 <docker-image> [output-name]"
  echo "Example: $0 nginx:alpine nginx-alpine"
  exit 1
fi

command -v docker >/dev/null 2>&1 || { echo "docker is required"; exit 1; }

safe_name() {
  printf '%s' "$1" \
    | tr '/:@' '---' \
    | tr -cs 'A-Za-z0-9._-' '-' \
    | sed 's/^-//; s/-$//'
}

if [ -z "$OUTPUT_NAME" ]; then
  OUTPUT_NAME="$(safe_name "$IMAGE")"
else
  OUTPUT_NAME="$(safe_name "$OUTPUT_NAME")"
fi

mkdir -p "$OUTPUT_DIR" .tmp

RAW_TAR=".tmp/${OUTPUT_NAME}.tar"
BASE="${OUTPUT_DIR}/${OUTPUT_NAME}"
START_TIME="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

echo "Pulling image: $IMAGE"
docker pull "$IMAGE"

echo "Saving Docker image to tar"
docker save "$IMAGE" -o "$RAW_TAR"

RAW_SIZE="$(wc -c < "$RAW_TAR" | tr -d ' ')"

case "$COMPRESSION" in
  zstd)
    command -v zstd >/dev/null 2>&1 || { echo "zstd is required"; exit 1; }
    OUT_FILE="${BASE}.tar.zst"
    echo "Compressing with zstd level ${ZSTD_LEVEL}"
    zstd -T0 -"${ZSTD_LEVEL}" -f "$RAW_TAR" -o "$OUT_FILE"
    ;;
  gzip)
    OUT_FILE="${BASE}.tar.gz"
    if command -v pigz >/dev/null 2>&1; then
      echo "Compressing with pigz"
      pigz -c "$RAW_TAR" > "$OUT_FILE"
    else
      echo "Compressing with gzip"
      gzip -c "$RAW_TAR" > "$OUT_FILE"
    fi
    ;;
  xz)
    command -v xz >/dev/null 2>&1 || { echo "xz is required"; exit 1; }
    OUT_FILE="${BASE}.tar.xz"
    echo "Compressing with xz"
    xz -T0 -c "$RAW_TAR" > "$OUT_FILE"
    ;;
  none)
    OUT_FILE="${BASE}.tar"
    echo "Keeping uncompressed tar"
    mv "$RAW_TAR" "$OUT_FILE"
    ;;
  *)
    echo "Unsupported compression: $COMPRESSION"
    exit 1
    ;;
esac

if [ -f "$RAW_TAR" ]; then
  rm -f "$RAW_TAR"
fi

COMPRESSED_SIZE="$(wc -c < "$OUT_FILE" | tr -d ' ')"
SPLIT_SIZE_BYTES=$((SPLIT_SIZE_MB * 1024 * 1024))
SPLIT=false
PART_COUNT=0

if [ "$COMPRESSED_SIZE" -gt "$SPLIT_SIZE_BYTES" ]; then
  echo "Splitting into ${SPLIT_SIZE_MB}MB parts"
  split -b "${SPLIT_SIZE_MB}M" -d -a 3 "$OUT_FILE" "${BASE}.part-"
  rm -f "$OUT_FILE"
  SPLIT=true
  PART_COUNT="$(find "$OUTPUT_DIR" -maxdepth 1 -type f -name "${OUTPUT_NAME}.part-*" | wc -l | tr -d ' ')"
fi

SHA_FILE="${BASE}.sha256"
if [ "$SPLIT" = true ]; then
  (cd "$OUTPUT_DIR" && sha256sum "${OUTPUT_NAME}".part-* > "${OUTPUT_NAME}.sha256")
else
  (cd "$OUTPUT_DIR" && sha256sum "$(basename "$OUT_FILE")" > "${OUTPUT_NAME}.sha256")
fi

END_TIME="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
INFO_FILE="${BASE}.info.txt"
MANIFEST_FILE="${BASE}.manifest.json"

cat > "$INFO_FILE" <<EOF
Image: $IMAGE
Output name: $OUTPUT_NAME
Compression: $COMPRESSION
Raw tar size: $RAW_SIZE bytes
Stored size: $COMPRESSED_SIZE bytes
Split: $SPLIT
Part count: $PART_COUNT
Started: $START_TIME
Finished: $END_TIME
EOF

cat > "$MANIFEST_FILE" <<EOF
{
  "image": "$IMAGE",
  "output_name": "$OUTPUT_NAME",
  "compression": "$COMPRESSION",
  "raw_tar_size_bytes": $RAW_SIZE,
  "stored_size_bytes": $COMPRESSED_SIZE,
  "split": $SPLIT,
  "split_size_mb": $SPLIT_SIZE_MB,
  "part_count": $PART_COUNT,
  "created_at": "$END_TIME",
  "checksum_file": "$(basename "$SHA_FILE")"
}
EOF

echo "Done."
echo "Manifest: $MANIFEST_FILE"
echo "Info: $INFO_FILE"
