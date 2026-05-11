# Docker image backup: `bugsink/bugsink`

This folder contains everything needed to download and load this Docker image without using Docker Hub.

## Files

- [bugsink-bugsink.part-000](https://github.com/Big13ang/ir-docker-image-downloder-by-mba/blob/master/docker-images/bugsink-bugsink/bugsink-bugsink.part-000)
- [bugsink-bugsink.part-001](https://github.com/Big13ang/ir-docker-image-downloder-by-mba/blob/master/docker-images/bugsink-bugsink/bugsink-bugsink.part-001)
- [bugsink-bugsink.manifest.json](https://github.com/Big13ang/ir-docker-image-downloder-by-mba/blob/master/docker-images/bugsink-bugsink/bugsink-bugsink.manifest.json)
- [bugsink-bugsink.sha256](https://github.com/Big13ang/ir-docker-image-downloder-by-mba/blob/master/docker-images/bugsink-bugsink/bugsink-bugsink.sha256)
- [bugsink-bugsink.info.txt](https://github.com/Big13ang/ir-docker-image-downloder-by-mba/blob/master/docker-images/bugsink-bugsink/bugsink-bugsink.info.txt)


## Linux / macOS

### 1. Download the files

```bash
mkdir -p bugsink-bugsink
cd bugsink-bugsink
curl -L -o bugsink-bugsink.part-000 https://raw.githubusercontent.com/Big13ang/ir-docker-image-downloder-by-mba/master/docker-images/bugsink-bugsink/bugsink-bugsink.part-000
curl -L -o bugsink-bugsink.part-001 https://raw.githubusercontent.com/Big13ang/ir-docker-image-downloder-by-mba/master/docker-images/bugsink-bugsink/bugsink-bugsink.part-001

curl -L -o bugsink-bugsink.sha256 https://raw.githubusercontent.com/Big13ang/ir-docker-image-downloder-by-mba/master/docker-images/bugsink-bugsink/bugsink-bugsink.sha256
```

### 2. Check the download

```bash
sha256sum -c bugsink-bugsink.sha256
```

### 3. Load into Docker

```bash
cat bugsink-bugsink.part-* | zstd -d -c | docker load
```

## Windows PowerShell

### 1. Download the files

```powershell
New-Item -ItemType Directory -Force bugsink-bugsink
Set-Location bugsink-bugsink
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Big13ang/ir-docker-image-downloder-by-mba/master/docker-images/bugsink-bugsink/bugsink-bugsink.part-000" -OutFile "bugsink-bugsink.part-000"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Big13ang/ir-docker-image-downloder-by-mba/master/docker-images/bugsink-bugsink/bugsink-bugsink.part-001" -OutFile "bugsink-bugsink.part-001"

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Big13ang/ir-docker-image-downloder-by-mba/master/docker-images/bugsink-bugsink/bugsink-bugsink.sha256" -OutFile "bugsink-bugsink.sha256"
```

### 2. Extract or combine files

```powershell
$out = [System.IO.File]::Create("image.compressed")
Get-ChildItem -Filter "*.part-*" | Sort-Object Name | ForEach-Object {
    $in = [System.IO.File]::OpenRead($_.FullName)
    try { $in.CopyTo($out) } finally { $in.Close() }
}
$out.Close()
```

### 3. Load into Docker

```powershell
zstd -d -c image.compressed | docker load
```

## Requirements

- Docker must be installed and running.
- For zstd backups, install `zstd`.
- For xz backups, install `xz`.

Generated at: `2026-05-11T07:27:24Z`
