DROP DATABASE IF EXISTS superhero;
CREATE DATABASE superhero;
\c superhero

DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS superpower;
DROP TABLE IF EXISTS superhero;
DROP TABLE IF EXISTS superhero_powers;

CREATE TABLE city (
    city_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE superpower (
    power_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE superhero (
    hero_id SERIAL PRIMARY KEY,
    hero_name VARCHAR(50) NOT NULL UNIQUE,
    real_name VARCHAR(50) NOT NULL,
    creation_year INT,
    city_id INTEGER REFERENCES city(city_id)
);

CREATE TABLE superhero_powers (
    hero_id INTEGER REFERENCES superhero(hero_id),
    power_id INTEGER REFERENCES superpower(power_id),
    level VARCHAR(10) CHECK (level IN ('low', 'medium', 'high')),
    PRIMARY KEY (hero_id, power_id)
);