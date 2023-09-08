import time
from datetime import datetime
import random
import string
import logging
from flask import Flask
import os
from threading import Thread

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("log-output")

app = Flask(__name__)
port = int(os.environ.get("PORT"))
FILE_PATH = "/usr/src/app/files/ping-pong-counter"

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


@app.route("/", methods=["GET"])
def log():
    formatted_time = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    with open(FILE_PATH, "r") as f:
        ping_pong_counter = f.read()
    return f"{formatted_time} : {random_str}<br>Ping / Pong: {ping_pong_counter}"


if __name__ == "__main__":
    logger.info(f"\nServer started in port {port}\n")
    custom_thread = Thread(target=generate_string)
    custom_thread.start()

    with open(FILE_PATH, "w") as f:
        f.write("0")

    app.run(host="0.0.0.0", port=port)
