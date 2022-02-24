import sqlite3
import pprint
from flask import jsonify

def get_item_by_id(itemid, data_base):
    with sqlite3.connect(data_base) as connection:
        connection.row_factory = sqlite3.Row
        cursor = connection.cursor()
        query = f"""
        SELECT *
        FROM animal_normal 
        WHERE "id" = {itemid}
        """
        result = dict(cursor.execute(query).fetchone())
        return result
