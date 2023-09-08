from flask import Flask, render_template, request
import os
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("app")

app = Flask(__name__)
port = int(os.environ.get("PORT"))
COUNTER = 0


@app.route("/pingpong", methods=["GET"])
def index():
    global COUNTER
    COUNTER += 1
    output = f"Pong: {COUNTER}"
    logger.info(output)
    return output


if __name__ == "__main__":
    logger.info(f"\nServer started on port {port}\n")
    app.run(host="0.0.0.0", port=port, debug=True)
