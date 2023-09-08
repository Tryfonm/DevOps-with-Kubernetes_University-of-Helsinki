import time
from datetime import datetime
import random
import string
import logging
from flask import Flask
import os
import requests
from threading import Thread

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("log-output")

app = Flask(__name__)
port = int(os.environ.get("PORT"))


def generate_string():
    global random_str
    try:
        random_str = "".join(random.choice(string.ascii_letters) for _ in range(36))
        while True:
            current_time = datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%S.%fZ")
            logger.info(f"{current_time}: {random_str}")
            time.sleep(5)
    except KeyboardInterrupt:
        pass


def get_data(url="http://ping-pong-svc:2345/pingpong"):
    try:
        response = requests.get(url)
        return response.text
    except Exception as e:
        logging.info(e)


@app.route("/", methods=["GET"])
def log():
    formatted_time = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    shared_data = get_data()
    return f"{formatted_time} : {random_str}<br>Ping / {shared_data}"


if __name__ == "__main__":
    logger.info(f"\nServer started in port {port}\n")
    custom_thread = Thread(target=generate_string)
    custom_thread.start()

    app.run(host="0.0.0.0", port=port)
