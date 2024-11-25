from flask import Flask, render_template_string
import os

app = Flask(__name__)

@app.route("/")
def home():
    name = os.getenv("NAME", "World")
    html = f"<h1>Hello, {name}!</h1>"
    return render_template_string(html)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
