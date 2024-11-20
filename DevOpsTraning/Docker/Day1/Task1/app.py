import os
from flask import Flask
app = Flask(__name__)

@app.route('/')
def index():
    # Get the server name from the environment variable
    server_name = os.getenv('SERVER_NAME', 'Not Set')
    return f"Response from : {server_name}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
