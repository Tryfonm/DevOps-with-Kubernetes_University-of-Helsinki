from flask import Flask, render_template, request
import os
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('simple-server')


app = Flask(__name__)
port = int(os.environ.get("PORT", 3000))

@app.route('/', methods=['GET'])
def index():
    logger.info(f'Logging a GET request')
    return render_template('form.html', port=port)

@app.route('/submit', methods=['POST'])
def submit():
    if request.method == 'POST':
        value = request.form.get('value')
        logger.info(f'Logging a POST request | value: {value}')
        return f'Received value: {value}'

if __name__ == '__main__':
    logger.info(f'Server started in port {port}\n')
    app.run(host='0.0.0.0', port=port, debug=True)
