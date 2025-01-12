import sentry_sdk
from sentry_sdk import capture_exception, capture_message
import random
import time

# Инициализация Sentry
sentry_sdk.init(dsn="https://your-dsn",)

# Функция, имитирующая обработку транзакции
def process_transaction(user_id, amount):
    try:
        print(f"Обработка транзакции для пользователя {user_id} на сумму {amount}...")

        # Моделируем случайные ошибки для тестирования
        error_type = random.choice(["api_error", "validation_error", "server_error", "success"])

        if error_type == "api_error":
            raise ConnectionError("Ошибка подключения к серверу API.")
        
        if error_type == "validation_error":
            raise ValueError("Неверная сумма транзакции.")
        
        if error_type == "server_error":
            raise Exception("Ошибка на сервере при обработке транзакции.")

        # Если ошибок нет
        print(f"Транзакция для пользователя {user_id} успешно обработана.")
        capture_message(f"Транзакция успешно выполнена для пользователя {user_id} на сумму {amount}")

    except ConnectionError as e:
        # Отправляем информацию об ошибке в Sentry
        print(f"Ошибка: {e}")
        capture_exception(e)
        capture_message(f"Ошибка подключения для пользователя {user_id} на сумму {amount}")

    except ValueError as e:
        # Отправляем информацию об ошибке в Sentry
        print(f"Ошибка: {e}")
        capture_exception(e)
        capture_message(f"Ошибка валидации для пользователя {user_id} на сумму {amount}")

    except Exception as e:
        # Общая ошибка
        print(f"Неизвестная ошибка: {e}")
        capture_exception(e)
        capture_message(f"Неизвестная ошибка для пользователя {user_id} на сумму {amount}")

# Пример с несколькими транзакциями
def simulate_transactions():
    users = [{"id": 1, "name": "Иван"}, {"id": 2, "name": "Мария"}]
    for user in users:
        # Моделируем несколько транзакций для разных пользователей
        for amount in [1000, 2000, 3000]:
            time.sleep(1)  # Подождем 1 секунду между транзакциями
            process_transaction(user["id"], amount)

# Запуск тестирования
simulate_transactions()
