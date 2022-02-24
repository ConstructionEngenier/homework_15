CREATE TABLE animal_type
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE name
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULl
);

CREATE TABLE breed
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE color1
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE color2
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE subtype
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE type
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE month
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name INTEGER NOT NULL
);

CREATE TABLE year
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name INTEGER NOT NULL
);

CREATE TABLE animal_normal
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    age_upon VARCHAR(100),
    animal_id VARCHAR(100),
    animal_type_id INTEGER,
    name_id INTEGER,
    breed_id INTEGER,
    color1_id INTEGER,
    color2_id INTEGER,
    date_of_birth DATETIME,
    subtype_id INTEGER,
    type_id INTEGER,
    month_id INTEGER,
    year_id INTEGER,
    FOREIGN KEY(animal_type_id) REFERENCES animal_type(id),
    FOREIGN KEY(name_id) REFERENCES name(id),
    FOREIGN KEY(breed_id) REFERENCES breed(id),
    FOREIGN KEY(color1_id) REFERENCES color1(id),
    FOREIGN KEY(color2_id) REFERENCES color2(id),
    FOREIGN KEY(subtype_id) REFERENCES subtype(id),
    FOREIGN KEY(type_id) REFERENCES type(id),
    FOREIGN KEY(month_id) REFERENCES month(id),
    FOREIGN KEY(year_id) REFERENCES year(id)
);

INSERT INTO animal_normal(age_upon, animal_id, date_of_birth)
SELECT animals.age_upon_outcome,
       animals.animal_id,
       animals.date_of_birth
FROM animals;

INSERT INTO animal_type(name)
SELECT DISTINCT animal_type
FROM animals
ORDER BY animal_type;

CREATE TABLE animals_to_animalType
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    animal_index INTEGER,
    animal_type_id INTEGER
);

INSERT INTO animals_to_animalType(animal_index, animal_type_id)
SELECT DISTINCT animals."index", animal_type.id
FROM animals
LEFT JOIN animal_type on animals.animal_type = animal_type.name;

UPDATE animal_normal
SET animal_type_id = (
    SELECT animals_to_animalType.animal_type_id
    FROM animals_to_animalType
    WHERE animals_to_animalType.id = animal_normal.id
    );

DROP TABLE animals_to_animalType;

INSERT INTO name(name)
SELECT DISTINCT name
FROM animals
WHERE name NOT NULL
ORDER BY name;

CREATE TABLE animals_to_name
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    animal_index INTEGER,
    name_id INTEGER
);

INSERT INTO animals_to_name(animal_index, name_id)
SELECT DISTINCT animals."index", name.id
FROM animals
LEFT JOIN name on animals.name = name.name;

UPDATE animal_normal
SET name_id = (
    SELECT animals_to_name.name_id
    FROM animals_to_name
    WHERE animals_to_name.id = animal_normal.id
    );

DROP TABLE animals_to_name;

INSERT INTO breed(name)
SELECT DISTINCT breed
FROM animals
WHERE breed NOT NULL
ORDER BY breed;

CREATE TABLE animals_to_breed
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    animal_index INTEGER,
    breed_id INTEGER
);

INSERT INTO animals_to_breed(animal_index, breed_id)
SELECT DISTINCT animals."index", breed.id
FROM animals
LEFT JOIN breed on animals.breed = breed.name;

UPDATE animal_normal
SET breed_id = (
    SELECT animals_to_breed.breed_id
    FROM animals_to_breed
    WHERE animals_to_breed.id = animal_normal.id
    );

DROP TABLE animals_to_breed;

INSERT INTO color1(name)
SELECT DISTINCT color1
FROM animals
WHERE color1 NOT NULL
ORDER BY color1;

CREATE TABLE animals_to_color1
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    animal_index INTEGER,
    color1_id INTEGER
);

INSERT INTO animals_to_color1(animal_index, color1_id)
SELECT DISTINCT animals."index", color1.id
FROM animals
LEFT JOIN color1 on animals.color1 = color1.name;

UPDATE animal_normal
SET color1_id = (
    SELECT animals_to_color1.color1_id
    FROM animals_to_color1
    WHERE animals_to_color1.id = animal_normal.id
    );

DROP TABLE animals_to_color1;

INSERT INTO color2(name)
SELECT DISTINCT color2
FROM animals
WHERE color2 NOT NULL
ORDER BY color2;

CREATE TABLE animals_to_color2
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    animal_index INTEGER,
    color2_id INTEGER
);

INSERT INTO animals_to_color2(animal_index, color2_id)
SELECT DISTINCT animals."index", color2.id
FROM animals
LEFT JOIN color2 on animals.color2 = color2.name;

UPDATE animal_normal
SET color2_id = (
    SELECT animals_to_color2.color2_id
    FROM animals_to_color2
    WHERE animals_to_color2.id = animal_normal.id
    );

DROP TABLE animals_to_color2;

INSERT INTO subtype(name)
SELECT DISTINCT outcome_subtype
FROM animals
WHERE outcome_subtype NOT NULL
ORDER BY outcome_subtype;

CREATE TABLE animals_to_subtype
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    animal_index INTEGER,
    subtype_id INTEGER
);

INSERT INTO animals_to_subtype(animal_index, subtype_id)
SELECT DISTINCT animals."index", subtype.id
FROM animals
LEFT JOIN subtype on animals.outcome_subtype = subtype.name;

UPDATE animal_normal
SET subtype_id = (
    SELECT animals_to_subtype.subtype_id
    FROM animals_to_subtype
    WHERE animals_to_subtype.id = animal_normal.id
    );

DROP TABLE animals_to_subtype;

INSERT INTO type(name)
SELECT DISTINCT outcome_type
FROM animals
WHERE outcome_type NOT NULL
ORDER BY outcome_type;

CREATE TABLE animals_to_type
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    animal_index INTEGER,
    type_id INTEGER
);

INSERT INTO animals_to_type(animal_index, type_id)
SELECT DISTINCT animals."index", type.id
FROM animals
LEFT JOIN type on animals.outcome_type = type.name;

UPDATE animal_normal
SET type_id = (
    SELECT animals_to_type.type_id
    FROM animals_to_type
    WHERE animals_to_type.id = animal_normal.id
    );

DROP TABLE animals_to_type;

INSERT INTO month(name)
SELECT DISTINCT outcome_month
FROM animals
WHERE outcome_month NOT NULL
ORDER BY outcome_month;

CREATE TABLE animals_to_month
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    animal_index INTEGER,
    month_id INTEGER
);

INSERT INTO animals_to_month(animal_index, month_id)
SELECT DISTINCT animals."index", month.id
FROM animals
LEFT JOIN month on animals.outcome_month = month.name;

UPDATE animal_normal
SET month_id = (
    SELECT animals_to_month.month_id
    FROM animals_to_month
    WHERE animals_to_month.id = animal_normal.id
    );

DROP TABLE animals_to_month;

INSERT INTO year(name)
SELECT DISTINCT outcome_year
FROM animals
WHERE outcome_year NOT NULL
ORDER BY outcome_year;

CREATE TABLE animals_to_year
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    animal_index INTEGER,
    year_id INTEGER
);

INSERT INTO animals_to_year(animal_index, year_id)
SELECT DISTINCT animals."index", year.id
FROM animals
LEFT JOIN year on animals.outcome_year = year.name;

UPDATE animal_normal
SET year_id = (
    SELECT animals_to_year.year_id
    FROM animals_to_year
    WHERE animals_to_year.id = animal_normal.id
    );

DROP TABLE animals_to_year;
