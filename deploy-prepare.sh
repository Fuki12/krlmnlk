#!/bin/sh
# Подготовка к заливке на хостинг (запускать из корня проекта)
set -e
echo "=== Сборка фронтенда ==="
npm ci
npm run build
echo ""
echo "=== Готово ==="
echo "Папка public/build создана. Заливайте проект на хостинг."
echo "На сервере: php artisan key:generate && php artisan migrate --force && php artisan storage:link"
echo "Подробности: DEPLOY.md"
