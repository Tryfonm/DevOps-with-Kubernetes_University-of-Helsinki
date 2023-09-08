from flask import Flask
import os
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("simple-server")


app = Flask(__name__)

# Use PORT environment variable or default to 3000
port = int(os.environ.get("PORT", 5000))


@app.route("/")
def hello():
    return f"Server started in port {port}\n"


if __name__ == "__main__":
    logger.info(f"Server started in port {port}\n")
    app.run(host="0.0.0.0", port=port)
