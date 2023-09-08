from datetime import datetime

import logging
from flask import Flask
import os
from threading import Thread

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("log-output-reader")

app = Flask(__name__)
port = int(os.environ.get("PORT"))
FILE_PATH = "/usr/src/app/files/log-output.log"


@app.route("/", methods=["GET"])
def log():
    with open(FILE_PATH, "r") as f:
        logs = f.read()
    return logs


if __name__ == "__main__":
    logger.info(f"\nServer started on port {port}\n")
    app.run(host="0.0.0.0", port=port)
