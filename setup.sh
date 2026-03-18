#!/bin/bash

echo "Установка бота Платежного Календаря"

read -p "Введите ваш TELEGRAM_BOT_TOKEN (от BotFather): " TELEGRAM_BOT_TOKEN
read -p "Введите ваш GEMINI_API_KEY (от Google AI Studio): " GEMINI_API_KEY

cat <<EOF > .env
TELEGRAM_BOT_TOKEN=$TELEGRAM_BOT_TOKEN
GEMINI_API_KEY=$GEMINI_API_KEY
EOF

echo
echo "Файл .env успешно создан! Ваши токены сохранены и скрыты от Git."
echo

read -p "Запустить контейнер бота через Docker Compose сейчас? (Y/N): " run_docker
if [[ "$run_docker" == "y" || "$run_docker" == "Y" || "$run_docker" == "yes" || "$run_docker" == "Да" ]]; then
    echo "Запускаем docker-compose..."
    docker compose up -d --build
    echo "Бот запущен в фоновом режиме!"
else
    echo
    echo "Вы можете запустить бота позже командой: docker compose up -d --build"
    echo "Или локально командой: python bot.py"
fi