# Развёртывание проекта на хостинге

## Требования

- **PHP** 8.1 или выше (расширения: BCMath, Ctype, Fileinfo, JSON, Mbstring, OpenSSL, PDO, Tokenizer, XML)
- **Composer**
- **Node.js** 18+ и **npm** (для сборки фронтенда)
- **MySQL** или **MariaDB** (или другая БД из конфига)

## Подготовка к заливке (перед заливкой на хостинг)

### Вариант 1: скрипт (рекомендуется)

**Windows (PowerShell):**
```powershell
.\deploy-prepare.ps1
```

**Linux / macOS:**
```bash
chmod +x deploy-prepare.sh
./deploy-prepare.sh
```

### Вариант 2: вручную

**1. Сборка фронтенда (обязательно):**

```bash
npm ci
npm run build
```

В каталоге `public/build` появятся собранные CSS и JS. Без этой папки сайт будет без стилей и скриптов. Если на хостинге нет Node.js — собирайте локально и загружайте `public/build` вместе с проектом.

### 2. Оптимизация для production (локально или на сервере)

```bash
composer install --no-dev --optimize-autoloader
php artisan config:cache
php artisan route:cache
php artisan view:cache
```

## Настройка на хостинге

### 1. Какие файлы заливать

- Залить **все файлы и папки** проекта, кроме:
  - `node_modules` (не нужны на хостинге после сборки)
  - `.env` (не заливать! На сервере создать из `.env.example`)
  - `.git` (если не деплоите через git)
- Обязательно должны быть: `public/build` (после `npm run build`), папки `app`, `config`, `database`, `resources`, `routes`, `storage`, `vendor` (или установить `vendor` на сервере через `composer install --no-dev`).
- **Корень сайта (Document Root)** в настройках хоста должен указывать на папку **`public`**.  
  Пример: проект в `/home/user/krlmnlk` → Document Root = `/home/user/krlmnlk/public`.

### 2. Файл .env

- Скопировать `.env.example` в `.env`.
- Заполнить переменные:

```env
APP_NAME="Crazy Burger"
APP_ENV=production
APP_KEY=           # сгенерировать: php artisan key:generate
APP_DEBUG=false
APP_URL=https://ваш-домен.ru
```

- **База данных:** указать хост, имя БД, пользователя и пароль от хостинга.
- Остальные переменные (логи, кэш, сессии, почта) — по необходимости.

### 3. Права на каталоги

Папки должны быть доступны для записи веб-серверу:

```bash
chmod -R 775 storage bootstrap/cache
chown -R www-data:www-data storage bootstrap/cache
```

(Пользователь `www-data` может отличаться на хостинге — уточните в панели.)

### 4. Команды после заливки (один раз)

Выполнить на сервере (по SSH или через «Выполнить команду» в панели):

```bash
cd /путь/к/проекту
php artisan key:generate    # если APP_KEY пустой
php artisan storage:link   # симлинк public/storage -> storage/app/public
php artisan migrate --force # миграции БД
```

При необходимости повторить сборку и кэш:

```bash
composer install --no-dev --optimize-autoloader
npm ci && npm run build
php artisan config:cache
php artisan route:cache
php artisan view:cache
```

## Чек-лист перед открытием сайта

- [ ] Document Root = папка `public`
- [ ] В `.env`: `APP_ENV=production`, `APP_DEBUG=false`, верный `APP_URL`
- [ ] Задан `APP_KEY`
- [ ] Настроены доступ к БД в `.env`
- [ ] Выполнены миграции (`php artisan migrate --force`)
- [ ] Собран фронтенд (`public/build` существует)
- [ ] Права 775 на `storage` и `bootstrap/cache`
- [ ] Создан симлинк `php artisan storage:link` (если нужны загрузки)

## Render.com (Docker)

Проект готов к деплою на [Render.com](https://render.com) через **Docker**: фронтенд собирается в образе, Composer и миграции выполняются при старте контейнера.

### 1. Репозиторий

Закоммитьте в Git (включая `Dockerfile` и `.dockerignore`) и подключите репозиторий к Render.

### 2. Сервис в Render

- **New → Web Service**
- Подключите репозиторий (GitHub/GitLab).
- **Environment:** Docker.
- **Build Command:** не нужен (сборка по `Dockerfile`).
- **Start Command:** не нужен (в образе задан `CMD`).

### 3. Переменные окружения (Environment)

Задайте в панели Render (Environment):

| Переменная      | Описание |
|-----------------|----------|
| `APP_KEY`       | Ключ приложения: `php artisan key:generate --show` (без `base64:`). В Render укажите полное значение, например `base64:xxx...`. |
| `APP_ENV`       | `production` |
| `APP_DEBUG`     | `false` |
| `APP_URL`       | URL вашего сервиса, например `https://ваш-сервис.onrender.com` |
| `LOG_CHANNEL`   | `stderr` (уже задано в Dockerfile, можно переопределить) |

**База данных:** при использовании **Render PostgreSQL** в настройках сервиса привяжите базу (Add PostgreSQL); Render создаст переменную **`DATABASE_URL`**. В Environment добавьте `DB_CONNECTION=pgsql`, чтобы Laravel использовал Postgres (при наличии `DATABASE_URL` конфиг подхватит хост, порт, имя БД и учётные данные из неё).

Если подключаете внешнюю БД вручную:

- `DB_CONNECTION=pgsql` (или `mysql`)
- `DB_HOST`, `DB_PORT`, `DB_DATABASE`, `DB_USERNAME`, `DB_PASSWORD` — по данным хоста.

### 4. Что делает контейнер при старте

При каждом запуске контейнера выполняются:

- `composer install --no-dev --optimize-autoloader`
- `php artisan config:cache`
- `php artisan route:cache`
- `php artisan view:cache`
- `php artisan migrate --force`
- затем запуск nginx и php-fpm.

Фронтенд (Vite) уже собран в образ на этапе `docker build`, отдельно собирать его на Render не нужно.

### 5. Чек-лист для Render

- [ ] Репозиторий подключён, выбран тип сервиса **Docker**
- [ ] В Environment заданы `APP_KEY`, `APP_ENV=production`, `APP_DEBUG=false`, `APP_URL`
- [ ] При использовании Render PostgreSQL добавлена переменная `DATABASE_URL` (или вручную заданы `DB_*`)
- [ ] После первого деплоя сайт открывается по ссылке вида `https://xxx.onrender.com`

---

## Типичные хостинги

- **Beget, Timeweb, REG.RU и др.:** Document Root указывает на `public`, остальное — как в разделе «Настройка на хостинге».
- **Shared-хостинг без SSH:** залить уже собранный проект (с `public/build`), `.env` создать вручную; миграции и `key:generate` — через панель (если есть «PHP» или «Artisan») или по инструкции хостинга.

После этого проект готов к работе на хостинге.
