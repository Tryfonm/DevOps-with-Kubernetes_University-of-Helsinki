import os
import json
import logging
import requests
from datetime import datetime

from flask import Flask, render_template, request, send_file, redirect

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("todo-frontend")
SAVE_FOLDER = "/usr/src/todo-app/files/"

app = Flask(__name__)
port = int(os.environ.get("PORT", 3000))


@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "GET":
        current_date = datetime.now().strftime("%Y-%m-%d")
        todos = requests.get("http://todo-backend-svc:2345/todos").content

        return render_template(
            "index.html",
            port=port,
            todos=json.loads(todos),
            image_path=SAVE_FOLDER + current_date + ".jpg",
        )

    elif request.method == "POST":
        try:
            value = request.form.get("value")
            requests.post("http://todo-backend-svc:2345/todos", json={"todo": value})
            logger.info(
                f"Succesful backend POST request: {value} | length: {len(value)}"
            )
        except Exception as e:
            logger.info(
                f"Failed backed POST request: {value} | length: {len(value)} with error {e}"
            )
        return redirect("/")


@app.route("/files/<filename>")
def get_image(filename):
    return send_file(SAVE_FOLDER + filename)


@app.route("/healthz", methods=["GET"])
def healthz():
    try:
        requests.get("http://todo-backend-svc:2345/healthz")
        return "", 200
    except:
        return "Internal Error", 500



if __name__ == "__main__":
    app.run(host="0.0.0.0", port=port, debug=True)
