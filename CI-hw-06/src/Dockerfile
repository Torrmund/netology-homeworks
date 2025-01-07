# Указываем базовый образ
FROM python:3.10-alpine3.21

# Устанавливаем рабочую директорию
WORKDIR /python_api

# Копируем файл зависимостей, устанавливаем зависимости и удаляем файл зависимостей
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN rm requirements.txt

# Копируем код приложения в контейнер
COPY python-api.py .

# Открываем порт для приложения
EXPOSE 5290

# Указываем команду для запуска приложения
CMD ["python", "python-api.py"]