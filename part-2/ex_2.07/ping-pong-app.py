import os
import logging

import psycopg2
from flask import Flask, render_template, request

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("app")


db_params = {
    "host": "postgres-svc.ping-pong-ns",  # the .namespace is optional
    "port": 5432,
    "database": "postgres",
    "user": os.environ.get("POSTGRES_USER"),
    "password": os.environ.get("POSTGRES_PASSWORD"),
}


app = Flask(__name__)
port = int(os.environ.get("PORT"))
COUNTER = 0


def insert_into_postgres(data):
    try:
        connection = psycopg2.connect(**db_params)
        cursor = connection.cursor()
        cursor.execute("INSERT INTO counter_table (counter) VALUES (%s)", (data,))
        connection.commit()
        cursor.close()
        connection.close()
    except Exception as e:
        logging.info(f"Error: {e}")


@app.route("/pingpong", methods=["GET"])
def index():
    global COUNTER
    COUNTER += 1
    output = f"Pong: {COUNTER}"
    insert_into_postgres(data=COUNTER)
    return output


if __name__ == "__main__":
    logger.info(f"\nServer started on port {port}\n")
    app.run(host="0.0.0.0", port=port, debug=True)
