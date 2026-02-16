# Подготовка к заливке на хостинг (запускать из корня проекта)
Write-Host "=== Сборка фронтенда ===" -ForegroundColor Cyan
npm ci
if ($LASTEXITCODE -ne 0) { exit 1 }
npm run build
if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "`n=== Готово ===" -ForegroundColor Green
Write-Host "Папка public/build создана. Заливайте проект на хостинг."
Write-Host "На сервере выполните: php artisan key:generate, migrate --force, storage:link"
Write-Host "Подробности: DEPLOY.md"
