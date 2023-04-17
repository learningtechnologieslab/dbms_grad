from markupsafe import escape
from flask import Flask
app = Flask(__name__)

@app.route("/<first_name>/<last_name>")
def hello(first_name, last_name):
    return f"Hello, {escape(first_name)}, {escape(last_name)}!"
