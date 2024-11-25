from flask import Flask, jsonify, Response
import pymysql
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  

@app.route('/data', methods=['GET'])
def get_data():
    connection = pymysql.connect(
        host='172.17.0.2',
        user='root',
        password='password',
        database='testdb'
    )
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM test_table")
    rows = cursor.fetchall()
    connection.close()

    response = jsonify(rows)
    response.headers.add('Access-Control-Allow-Origin', '*')  
    return response

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=6001)
