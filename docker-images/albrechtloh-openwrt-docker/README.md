# Docker image backup: `albrechtloh/openwrt-docker`

این فولدر برای این ساخته شده که بازیابی این Docker image تا جای ممکن ساده و بی‌دردسر باشد؛ مخصوصا وقتی سیستم مقصد به Docker Hub یا registry اصلی دسترسی راحتی ندارد.

## لینک فایل‌ها

- [albrechtloh-openwrt-docker.tar.part-000](https://github.com/Big13ang/ir-docker-image-downloder-by-mba/blob/master/docker-images/albrechtloh-openwrt-docker/albrechtloh-openwrt-docker.tar.part-000)
- [albrechtloh-openwrt-docker.tar.part-001](https://github.com/Big13ang/ir-docker-image-downloder-by-mba/blob/master/docker-images/albrechtloh-openwrt-docker/albrechtloh-openwrt-docker.tar.part-001)
- [albrechtloh-openwrt-docker.tar.part-002](https://github.com/Big13ang/ir-docker-image-downloder-by-mba/blob/master/docker-images/albrechtloh-openwrt-docker/albrechtloh-openwrt-docker.tar.part-002)
- [albrechtloh-openwrt-docker.manifest.json](https://github.com/Big13ang/ir-docker-image-downloder-by-mba/blob/master/docker-images/albrechtloh-openwrt-docker/albrechtloh-openwrt-docker.manifest.json)
- [albrechtloh-openwrt-docker.sha256](https://github.com/Big13ang/ir-docker-image-downloder-by-mba/blob/master/docker-images/albrechtloh-openwrt-docker/albrechtloh-openwrt-docker.sha256)
- [albrechtloh-openwrt-docker.info.txt](https://github.com/Big13ang/ir-docker-image-downloder-by-mba/blob/master/docker-images/albrechtloh-openwrt-docker/albrechtloh-openwrt-docker.info.txt)
- [VERSION.txt](https://github.com/Big13ang/ir-docker-image-downloder-by-mba/blob/master/docker-images/albrechtloh-openwrt-docker/VERSION.txt)


Folder page: [https://github.com/Big13ang/ir-docker-image-downloder-by-mba/tree/master/docker-images/albrechtloh-openwrt-docker](https://github.com/Big13ang/ir-docker-image-downloder-by-mba/tree/master/docker-images/albrechtloh-openwrt-docker)

## فهرست مطالب

- [مشخصات image](#مشخصات-image)
- [لینک فایل‌ها](#لینک-فایلها)
- [ابزارهای مورد نیاز](#ابزارهای-مورد-نیاز)
- [Linux / macOS](#linux--macos)
- [Windows PowerShell](#windows-powershell)
- [SHA256 یعنی چه؟](#sha256-یعنی-چه)
- [حمایت از پروژه](#حمایت-از-پروژه)

## مشخصات image

| مورد | مقدار |
| --- | --- |
| Docker image | `albrechtloh/openwrt-docker` |
| Repository | `albrechtloh/openwrt-docker` |
| Version type | `tag` |
| Version | `latest` |
| Platform | `linux/arm64` |
| Output folder | `docker-images/albrechtloh-openwrt-docker` |
| Archive file | `albrechtloh-openwrt-docker.tar` |
| Compression | `none` |
| Split | `true` |
| Part count | `3` |

نسخه و جزئیات image داخل فایل [VERSION.txt](https://github.com/Big13ang/ir-docker-image-downloder-by-mba/blob/master/docker-images/albrechtloh-openwrt-docker/VERSION.txt) هم ذخیره شده است.

## ابزارهای مورد نیاز

همیشه Docker لازم است:

- Docker Desktop: https://www.docker.com/products/docker-desktop/
- Docker install docs: https://docs.docker.com/engine/install/

برای این backup ابزار زیر هم لازم است:

- Required compression tool: `none`
- Download page: Not needed

اگر با خطایی مثل `zstd: command not found` یا `xz: command not found` روبه‌رو شدید، یعنی ابزار مربوطه نصب نیست.

## Linux / macOS

### 1. نصب ابزارها

Ubuntu/Debian:

```bash
sudo apt update && sudo apt install -y docker.io
```

macOS:

```bash
# Only Docker is required
```

### 2. دانلود فایل‌ها

```bash
mkdir -p albrechtloh-openwrt-docker
cd albrechtloh-openwrt-docker
curl -L -o albrechtloh-openwrt-docker.tar.part-000 https://raw.githubusercontent.com/Big13ang/ir-docker-image-downloder-by-mba/master/docker-images/albrechtloh-openwrt-docker/albrechtloh-openwrt-docker.tar.part-000
curl -L -o albrechtloh-openwrt-docker.tar.part-001 https://raw.githubusercontent.com/Big13ang/ir-docker-image-downloder-by-mba/master/docker-images/albrechtloh-openwrt-docker/albrechtloh-openwrt-docker.tar.part-001
curl -L -o albrechtloh-openwrt-docker.tar.part-002 https://raw.githubusercontent.com/Big13ang/ir-docker-image-downloder-by-mba/master/docker-images/albrechtloh-openwrt-docker/albrechtloh-openwrt-docker.tar.part-002

curl -L -o albrechtloh-openwrt-docker.sha256 https://raw.githubusercontent.com/Big13ang/ir-docker-image-downloder-by-mba/master/docker-images/albrechtloh-openwrt-docker/albrechtloh-openwrt-docker.sha256
```

### 3. بررسی سالم بودن دانلود

```bash
sha256sum -c albrechtloh-openwrt-docker.sha256
```

### 4. ساخت archive اصلی از قطعه‌ها

```bash
cat albrechtloh-openwrt-docker.tar.part-* > albrechtloh-openwrt-docker.tar
```

### 5. Load داخل Docker

```bash
docker load -i albrechtloh-openwrt-docker.tar
```

### 6. بررسی نتیجه

```bash
docker images
```

## Windows PowerShell

### 1. نصب ابزارها

Docker Desktop:

https://www.docker.com/products/docker-desktop/

Compression tool:

Not needed

اگر Chocolatey دارید:

```powershell
# Only Docker is required
```

### 2. دانلود فایل‌ها

```powershell
New-Item -ItemType Directory -Force albrechtloh-openwrt-docker
Set-Location albrechtloh-openwrt-docker
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Big13ang/ir-docker-image-downloder-by-mba/master/docker-images/albrechtloh-openwrt-docker/albrechtloh-openwrt-docker.tar.part-000" -OutFile "albrechtloh-openwrt-docker.tar.part-000"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Big13ang/ir-docker-image-downloder-by-mba/master/docker-images/albrechtloh-openwrt-docker/albrechtloh-openwrt-docker.tar.part-001" -OutFile "albrechtloh-openwrt-docker.tar.part-001"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Big13ang/ir-docker-image-downloder-by-mba/master/docker-images/albrechtloh-openwrt-docker/albrechtloh-openwrt-docker.tar.part-002" -OutFile "albrechtloh-openwrt-docker.tar.part-002"

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Big13ang/ir-docker-image-downloder-by-mba/master/docker-images/albrechtloh-openwrt-docker/albrechtloh-openwrt-docker.sha256" -OutFile "albrechtloh-openwrt-docker.sha256"
```

### 3. بررسی SHA256

PowerShell روی Windows به صورت پیش‌فرض فایل sha256sum لینوکسی را مستقیم نمی‌خواند. برای بررسی دستی، hash هر فایل را با مقدار داخل `albrechtloh-openwrt-docker.sha256` مقایسه کنید:

```powershell
Get-FileHash -Algorithm SHA256 albrechtloh-openwrt-docker.tar.part-*
```

### 4. ساخت archive اصلی از قطعه‌ها

```powershell
$out = [System.IO.File]::Create("albrechtloh-openwrt-docker.tar")
Get-ChildItem -Filter "albrechtloh-openwrt-docker.tar.part-*" | Sort-Object Name | ForEach-Object {
    $in = [System.IO.File]::OpenRead($_.FullName)
    try { $in.CopyTo($out) } finally { $in.Close() }
}
$out.Close()
```

### 5. Load داخل Docker

```powershell
docker load -i albrechtloh-openwrt-docker.tar
```

### 6. بررسی نتیجه

```powershell
docker images
```

## SHA256 یعنی چه؟

فایل `albrechtloh-openwrt-docker.sha256` برای این است که مطمئن شوید فایل‌هایی که دانلود کرده‌اید سالم، کامل و همان فایل‌هایی هستند که GitHub Action ساخته است.

این checksum نشان می‌دهد قطعه‌های archive بعد از ساخته شدن تغییری نکرده‌اند و دانلود شما ناقص یا خراب نیست.

نکته مهم: SHA256 اینجا برای فایل‌های backup داخل repo است، نه تایید امنیتی جداگانه درباره source image در Docker Hub.

## حمایت از پروژه

بزرگ‌ترین حمایت از ما معرفی و منتشر کردن این پروژه است. اگر این backup به شما کمک کرد، لطفا Docker Image Saver را به یک برنامه‌نویس، تیم یا شرکتی که با محدودیت Docker Hub یا registryها مشکل دارد معرفی کنید.

ما این ابزار را برای کم کردن فشار از روی تیم‌های فنی ساختیم. Star دادن، Fork کردن، ثبت Issue، ارسال Pull Request، معرفی پروژه و حمایت مالی، همه برای بهتر شدنش ارزشمندند.

### Donate

آدرس‌ها به ترتیب پیشنهادی قرار گرفته‌اند: اول شبکه‌های کم‌هزینه‌تر، و بین گزینه‌ها اولویت با USDT است.

#### USDT TRC20 (Tron) - پیشنهادی

```text
TRNfUz3zXsJYDQMYG5zxDseX3MSFxx8bxr
```

#### USDT SPL (Solana)

```text
FcCT54fD8A3VQ7nqNNf4kZprgCjdEFrJ7BSQBDb7i13i
```

#### USDT BEP20 (BNB Smart Chain)

```text
0x1126A4023F4EC18CfeF036C71e94F5D7D6D0902B
```

#### TON

```text
UQCvY7I4ROxsYOldjfRR-QnjiwdMlCsMA6Jw2tu2lRLDx6BC
```

#### TRX / Tron

```text
TRNfUz3zXsJYDQMYG5zxDseX3MSFxx8bxr
```

#### BNB

```text
0x1126A4023F4EC18CfeF036C71e94F5D7D6D0902B
```

#### BTC

```text
bc1qnhjk9zqmpg3wytw47luy8qsu2jhwpz83ll265k
```

ساخته شده با `Docker Image Saver` از تیم `اپ ساز`.

ارادتمند، `بهشت آئین` از تیم `اپ ساز`

وب‌سایت اپ ساز: https://appsaz.ir

Generated at: `2026-05-14T18:41:46Z`
