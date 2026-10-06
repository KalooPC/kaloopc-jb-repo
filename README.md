# KalooPC's JB repo

APT-репозиторий для Sileo / Zebra. APT repository for Sileo / Zebra.

---

## 🇷🇺 Русский

### Установка репозитория

Добавить в источники (Sileo → Sources → +):
```
https://kaloopc.github.io/KalooPC-s-JB-repo/
```
Репозиторий без GPG-подписи — Sileo покажет предупреждение, это нормально.

### Что внутри

- **Zen** (`com.zen.tiktok`) — мод TikTok для iPhone (jailbreak-твик): смена региона (SIM + store + локаль + ID устройства), чистка ссылок, скачивание видео/фото/музыки, FLEX-инспектор. Работает в РФ.

### Обновление пакета (для мейнтейнера)

1. Положить новый `.deb` в `debs/` (старый удалить).
2. Пересобрать индекс из WSL:
   ```bash
   cd /mnt/c/Users/KalooPC/Documents/GitHub/KalooPC-s-JB-repo
   bash update.sh
   ```
   Скрипт проверит содержимое пакета и пересоберет `Packages*` + `Release`.
3. Закоммитить и запушить — Sileo подтянет обновление при следующем обновлении источников.

---

## 🇬🇧 English

### Adding the repo

Add to sources (Sileo → Sources → +):
```
https://kaloopc.github.io/KalooPC-s-JB-repo/
```
The repo is unsigned — Sileo will show a warning, that's expected.

### What's inside

- **Zen** (`com.zen.tiktok`) — TikTok mod for iPhone (jailbreak tweak): region switch (SIM + store + locale + device ID), link cleaner, video/photo/music downloads, FLEX inspector. Works in RU.

### Updating the package (maintainer)

1. Put the new `.deb` into `debs/` (remove the old one).
2. Rebuild the index from WSL:
   ```bash
   cd /mnt/c/Users/KalooPC/Documents/GitHub/KalooPC-s-JB-repo
   bash update.sh
   ```
   The script verifies the package contents and regenerates `Packages*` + `Release`.
3. Commit and push — Sileo will pick up the update on next sources refresh.

---

## Состав / Contents

- `debs/` — пакеты / packages (Zen).
- `Packages`, `Packages.gz`, `Packages.bz2`, `Packages.xz`, `Packages.zst` — индекс / index.
- `Release` — метаданные репозитория (без подписи / unsigned).
- `update.sh` — пересборка индекса / index rebuild.
