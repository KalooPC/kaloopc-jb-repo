# KalooPC JB repo (Zen — TikTok mod)

APT-репозиторий для Sileo / Zebra.

## Подключение (на iPhone)

1. Включи GitHub Pages для этого репозитория: Settings → Pages → Deploy from a branch → `main` → `/ (root)` → Save.
2. В Sileo: Sources → + → введи URL:

```
https://kaloopc.github.io/KalooPC-s-JB-repo/
```

3. Подтверди добавление (репозиторий без GPG-подписи — Sileo предупредит, это нормально).
4. Найди пакет **Zen** (`com.zen.tiktok`) → Install.

## Обновление пакета

1. Положи новый `.deb` в `debs/` (старый удали/замени).
2. Пересобери индекс из WSL:
   ```bash
   cd /mnt/c/Users/KalooPC/Documents/GitHub/KalooPC-s-JB-repo
   bash update.sh
   ```
   Скрипт сам проверит содержимое пакета, пересоберет `Packages*` и `Release`.
3. Закоммить и запушь — Sileo подтянет обновление при следующем refresh.

## Состав

- `debs/` — пакеты (Zen).
- `Packages`, `Packages.gz`, `Packages.bz2`, `Packages.xz`, `Packages.zst` — индекс.
- `Release` — метаданные репозитория (без подписи).
- `update.sh` — пересборка индекса.
