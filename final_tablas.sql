DROP SCHEMA IF EXISTS final CASCADE;
CREATE SCHEMA IF NOT EXISTS final;

-- Creación de tablas a partir de la normalización en forma Boyce-Codd:

CREATE TABLE final.category (
	id SERIAL PRIMARY KEY,
	category TEXT NOT NULL,
	dimension TEXT NOT NULL,
	development TEXT);
CREATE TABLE final.country(
	id SERIAL PRIMARY KEY,
	iso_code TEXT NOT NULL,
	name TEXT NOT NULL,
	region TEXT NOT NULL,
	subregion TEXT NOT NULL);
CREATE TABLE final.homicides (
	id SERIAL PRIMARY KEY,
	category_id SERIAL REFERENCES final.category (id),
	country_id SERIAL REFERENCES final.country (id),
	indicator TEXT NOT NULL,
	sex TEXT NOT NULL,
	age TEXT NOT NULL,
	year TEXT NOT NULL,
	unit_of_measurement TEXT NOT NULL,
	value NUMERIC NOT NULL,
	source TEXT NOT NULL);
	
-- Inserción de los datos limpios en las tablas.
INSERT INTO final.category (category, dimension) 
	SELECT category, dimension FROM cleaning.homicides;
INSERT INTO final.country (iso_code, name, region, subregion) 
	SELECT iso3_code, country, region, subregion FROM cleaning.homicides;
INSERT INTO final.homicides (indicator, sex, age, year, unit_of_measurement, value, source)
	SELECT indicator, sex, age, year, unit_of_measurement, value, source FROM cleaning.homicides;
SELECT * FROM final.homicides;