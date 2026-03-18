FROM python:3.11-slim

WORKDIR /app

# Обновляем pip
RUN pip install --upgrade pip

# Копируем список зависимостей и устанавливаем их
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем исходный код бота
COPY bot.py .

# Запускаем скрипт
CMD ["python", "bot.py"]