from flask import Flask, jsonify, Response
import pymysql
from flask_cors import CORS
import os

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

@app.route('/', methods=['GET'])
def hello():
    return jsonify({"message": "Hello, world!"})

@app.route('/data', methods=['GET'])
def get_data():
    # Check if environment variables are set
    required_env_vars = ['DB_HOST', 'DB_USER', 'DB_PASSWORD', 'DB_NAME', 'PORT']
    for var in required_env_vars:
        if var not in os.environ:
            return jsonify({"error": f"Missing environment variable: {var}"}), 500

    try:
        # Connect to the database
        connection = pymysql.connect(
            host=os.environ['DB_HOST'],
            user=os.environ['DB_USER'],
            password=os.environ['DB_PASSWORD'],
            database=os.environ['DB_NAME']
        )

        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM test_table")
            rows = cursor.fetchall()

        # Close the connection after use
        connection.close()

        # Return data as JSON response
        return jsonify(rows)

    except pymysql.MySQLError as e:
        # Handle MySQL connection or query errors
        return jsonify({"error": f"MySQL error: {str(e)}"}), 500
    except Exception as e:
        # Handle any other errors
        return jsonify({"error": f"An error occurred: {str(e)}"}), 500

if __name__ == '__main__':
    # Ensure the PORT environment variable is set
    port = os.environ.get('PORT', 5000)  # Default to 5000 if PORT is not set
    app.run(host='0.0.0.0', port=int(port))
