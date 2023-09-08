from flask import Flask, render_template, request, send_file
import os
import logging
import requests
from datetime import datetime

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("simple-server")
SAVE_FOLDER = "/usr/src/simple-server-app/files/"

app = Flask(__name__)
port = int(os.environ.get("PORT"))


def fetch_image(current_date, image_url="https://picsum.photos/1200"):
    response = requests.get(image_url)
    try:
        existing_file_date = os.listdir(SAVE_FOLDER)[0].strip(".jpg")
    except IndexError as e:
        existing_file_date = None
    print(f"Comparing {current_date} : {existing_file_date}")

    if current_date != existing_file_date:
        with open(SAVE_FOLDER + current_date + ".jpg", "wb") as f:
            f.write(response.content)


@app.route("/", methods=["GET"])
def index():
    logger.info(f"Logging a GET request")

    current_date = datetime.now().strftime("%Y-%m-%d")
    fetch_image(current_date)
    return render_template(
        "index.html", port=port, image_path=SAVE_FOLDER + current_date + ".jpg"
    )


@app.route("/files/<filename>")
def get_image(filename):
    return send_file(SAVE_FOLDER + filename)


@app.route("/submit", methods=["POST"])
def submit():
    if request.method == "POST":
        value = request.form.get("value")
        logger.info(f"Logging a POST request | value: {value}")
        return f"Received value: {value}"


if __name__ == "__main__":
    logger.info(f"Server started on port {port}\n")
    app.run(host="0.0.0.0", port=port, debug=True)
