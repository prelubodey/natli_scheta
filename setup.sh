#!/bin/bash
set -e

REPO_URL="https://github.com/prelubodey/natli_scheta.git"
INSTALL_DIR="/root/projects/natli_scheta"

echo "=== Установка бота Платежного Календаря ==="

# 1. Если папки еще нет, создаем и клонируем репозиторий
if [ ! -d "$INSTALL_DIR" ]; then
    echo "Создаем директорию и скачиваем файлы..."
    mkdir -p /root/projects
    cd /root/projects
    # Проверяем установлен ли git
    if ! command -v git &> /dev/null; then
        apt-get update && apt-get install -y git
    fi
    git clone $REPO_URL
fi

# 2. Переходим в папку проекта
cd $INSTALL_DIR

# 3. Запрашиваем токены (используем /dev/tty для корректной работы через curl | bash)
read -p "Введите ваш TELEGRAM_BOT_TOKEN: " TELEGRAM_BOT_TOKEN < /dev/tty
read -p "Введите ваш GEMINI_API_KEY: " GEMINI_API_KEY < /dev/tty

# 4. Сохраняем токены в .env файл
echo "TELEGRAM_BOT_TOKEN=$TELEGRAM_BOT_TOKEN" > .env
echo "GEMINI_API_KEY=$GEMINI_API_KEY" >> .env
echo "Токены успешно сохранены в .env"

# 5. Запускаем Docker Compose
echo "Запускаем сборку и контейнер Docker..."
if command -v docker-compose &> /dev/null; then
    docker-compose up -d --build
else
    docker compose up -d --build
fi

echo "=== Готово! Бот успешно установлен и запущен в фоне. ==="