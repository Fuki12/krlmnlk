# ============================================================
# Stage 1: сборка фронтенда (Vite + Vue)
# ============================================================
FROM node:20-alpine AS frontend
WORKDIR /app

COPY package.json package-lock.json* ./
RUN npm ci
COPY . .
RUN cp .env.example .env 2>/dev/null || true
RUN npm run build

# ============================================================
# Stage 2: PHP-приложение (nginx + php-fpm)
# ============================================================
FROM richarvey/nginx-php-fpm:3.1.6

COPY . /var/www/html/
COPY --from=frontend /app/public/build /var/www/html/public/build

ENV WEBROOT=/var/www/html/public
ENV PHP_ERRORS_STDERR=1
ENV RUN_SCRIPTS=1
ENV REAL_IP_HEADER=1
ENV APP_ENV=production
ENV APP_DEBUG=0
ENV LOG_CHANNEL=stderr
ENV COMPOSER_ALLOW_SUPERUSER=1

# При старте: composer, кэш Laravel, миграции, затем штатный запуск nginx/php-fpm
CMD ["/bin/sh", "-c", "cd /var/www/html && composer install --no-dev --optimize-autoloader && php artisan config:cache && php artisan route:cache && php artisan view:cache && php artisan migrate --force && exec /start.sh"]
