import sqlite3
from flask import Flask
from utils import *

app = Flask(__name__)

data_base = "animal.db"


@app.get("/<itemid>")
def get_item(itemid):
    result = get_item_by_id(itemid, data_base)
    return jsonify(result)


app.run(debug=True, port=5002)