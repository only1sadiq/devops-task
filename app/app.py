# app/app.py
import time
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def get_data():
    """Returns a JSON payload with a message and a timestamp."""
    data = {
        'message': 'Automate all the things!',
        'timestamp': int(time.time())
    }
    return jsonify(data)

if __name__ == '__main__':
    # Run the app on 0.0.0.0 to be accessible outside the container
    app.run(host='0.0.0.0', port=8080)