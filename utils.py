import sqlite3
from flask import jsonify


def get_item_by_id(itemid, data_base):
    with sqlite3.connect(data_base) as connection:
        connection.row_factory = sqlite3.Row
        cursor = connection.cursor()
        query = f"""
        SELECT animal_normal.id,
               animal_normal.age_upon,
               animal_normal.animal_id,
               animal_type.name,
               name.name,
               breeds.name,
               color1.name,
               color2.name,
               animal_normal.date_of_birth,
               subtype.name,
               type.name,
               month.name,
               year.name
        FROM animal_normal
        LEFT JOIN animal_type ON animal_normal.animal_type_id = animal_type.id
        LEFT JOIN name ON animal_normal.name_id = name.id
        JOIN animal_breed ON animal_breed.id = animal_normal.id
        LEFT JOIN breeds ON breeds.id = animal_breed.breed_id
        JOIN animal_color ON animal_color.id = animal_normal.id
        LEFT JOIN colors color1 on color1.id=animal_color.color1_id
        LEFT JOIN colors color2 on color2.id=animal_color.color2_id
        LEFT JOIN subtype ON animal_normal.subtype_id = subtype.id
        LEFT JOIN type ON animal_normal.type_id = type.id
        LEFT JOIN month ON animal_normal.month_id = month.id
        LEFT JOIN year ON animal_normal.year_id = year.id
        WHERE animal_normal.id = {itemid}
        """
        result = dict(cursor.execute(query).fetchone())
        return result
