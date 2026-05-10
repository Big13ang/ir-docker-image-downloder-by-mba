#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IMAGE_DIR="${IMAGE_DIR:-$ROOT_DIR/docker-images}"

command -v docker >/dev/null 2>&1 || { echo "docker is required"; exit 1; }

MANIFEST="$(find "$IMAGE_DIR" -maxdepth 1 -type f -name '*.manifest.json' | sort | head -n 1)"
if [ -z "$MANIFEST" ]; then
  echo "No manifest found in $IMAGE_DIR"
  exit 1
fi

BASE="$(basename "$MANIFEST" .manifest.json)"
COMPRESSION="$(sed -n 's/.*"compression"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "$MANIFEST" | head -n 1)"
SPLIT="$(sed -n 's/.*"split"[[:space:]]*:[[:space:]]*\([^,]*\).*/\1/p' "$MANIFEST" | head -n 1 | tr -d ' ')"

echo "Restoring $BASE with compression: $COMPRESSION"

if ls "$IMAGE_DIR/${BASE}.part-"* >/dev/null 2>&1; then
  INPUT_CMD=(cat "$IMAGE_DIR/${BASE}.part-"*)
else
  case "$COMPRESSION" in
    zstd) FILE="$IMAGE_DIR/${BASE}.tar.zst" ;;
    gzip) FILE="$IMAGE_DIR/${BASE}.tar.gz" ;;
    xz) FILE="$IMAGE_DIR/${BASE}.tar.xz" ;;
    none) FILE="$IMAGE_DIR/${BASE}.tar" ;;
    *) echo "Unsupported compression: $COMPRESSION"; exit 1 ;;
  esac
fi

if [ -f "$IMAGE_DIR/${BASE}.sha256" ] && command -v sha256sum >/dev/null 2>&1; then
  echo "Checking SHA256"
  (cd "$IMAGE_DIR" && sha256sum -c "${BASE}.sha256")
fi

case "$COMPRESSION" in
  zstd)
    command -v zstd >/dev/null 2>&1 || { echo "zstd is required"; exit 1; }
    if [ "$SPLIT" = "true" ]; then
      cat "$IMAGE_DIR/${BASE}.part-"* | zstd -d -c | docker load
    else
      zstd -d -c "$FILE" | docker load
    fi
    ;;
  gzip)
    if [ "$SPLIT" = "true" ]; then
      cat "$IMAGE_DIR/${BASE}.part-"* | gunzip -c | docker load
    else
      gunzip -c "$FILE" | docker load
    fi
    ;;
  xz)
    command -v xz >/dev/null 2>&1 || { echo "xz is required"; exit 1; }
    if [ "$SPLIT" = "true" ]; then
      cat "$IMAGE_DIR/${BASE}.part-"* | xz -d -c | docker load
    else
      xz -d -c "$FILE" | docker load
    fi
    ;;
  none)
    if [ "$SPLIT" = "true" ]; then
      cat "$IMAGE_DIR/${BASE}.part-"* | docker load
    else
      docker load -i "$FILE"
    fi
    ;;
  *)
    echo "Unsupported compression: $COMPRESSION"
    exit 1
    ;;
esac

echo "Restore completed."
