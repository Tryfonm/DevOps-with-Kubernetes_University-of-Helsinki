from flask import Flask, request, jsonify
import os
import requests
import logging
from datetime import datetime
import psycopg2

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("todo-backend")

app = Flask(__name__)
port = int(os.environ.get("PORT"))
todo_list = []
todo_counter = 1
SAVE_FOLDER = "/usr/src/todo-app/files/"

DB_PARAMS = {
    "host": "postgres-svc.todo-ns",  # the .namespace is optional
    "port": 5432,
    "database": "postgres",
    "user": os.environ.get("POSTGRES_USER"),
    "password": os.environ.get("POSTGRES_PASSWORD"),
}


def insert_into_postgres(data):
    try:
        connection = psycopg2.connect(**DB_PARAMS)
        cursor = connection.cursor()
        cursor.execute("INSERT INTO todo_table (todo) VALUES (%s)", (data,))
        connection.commit()
        cursor.close()
        connection.close()
    except Exception as e:
        logger.info(f"Error: {e}")


def fetch_image(current_date, image_url="https://picsum.photos/1200"):
    try:
        existing_file_date = os.listdir(SAVE_FOLDER)[0].strip(".jpg")
    except IndexError as e:
        existing_file_date = None

    if current_date != existing_file_date:
        response = requests.get(image_url)
        with open(SAVE_FOLDER + current_date + ".jpg", "wb") as f:
            f.write(response.content)


@app.route("/todos", methods=["GET", "POST"])
def todos():
    global todo_counter
    if request.method == "GET":
        fetch_image(current_date=datetime.now().strftime("%Y-%m-%d"))
        return jsonify(todo_list)

    if request.method == "POST":
        received_json = request.get_json()
        received_data = received_json["todo"]

        if len(received_data) <= 140:
            todo_list.append({f"TODO {todo_counter}": received_data})
            insert_into_postgres(received_data)
            todo_counter += 1
            logger.info(f"Received data <= 140 | Injecting data: {received_data}")
        else:
            logger.info(f"Received data > 140 | Ignoring data: {received_data}")
        return "Successful", 201


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=port, debug=True)
