----Insercion de atributo----
    ALTER TABLE cleaning.homicides ADD COLUMN development TEXT;

    CREATE TABLE IF NOT EXISTS cleaning.temp_country(
        name text
    );

    --(Ejecutar primero lo anterior)
    -- COPY cleaning.temp_country(name) FROM 'C:/Users/aleom/OneDrive - INSTITUTO TECNOLOGICO AUTONOMO DE MEXICO/ITAM/Cuarto semestre/Clases/Bases de Datos/Proyecto/ProyectoBasesDeDatos/Homicidios/ProyectoBasesDeDatosH/country.csv' WITH (FORMAT CSV, HEADER true, DELIMITER ',');


    /*UPDATE cleaning.homicides
        SET development = CASE
            WHEN country IN (SELECT TRIM(upper(name)) FROM cleaning.temp_country) THEN 'DEVELOPED'
            WHEN country = 'REPUBLIC OF KOREA' THEN 'DEVELOPED'
            WHEN country = 'UNITED STATES OF AMERICA' THEN 'DEVELOPED'
            WHEN country = 'CZECHIA' THEN 'DEVELOPED'
            ELSE 'SUBDEVELOPED'
            END
        WHERE homicides.development IS NULL;

    DROP TABLE IF EXISTS cleaning.temp_country;*/

--Creación schema
    DROP SCHEMA IF EXISTS public CASCADE;
    CREATE SCHEMA IF NOT EXISTS public;

----Creación de tablas a partir de la normalización en forma Boyce-Codd:

    CREATE TABLE category (
        name TEXT PRIMARY KEY,
        dimension TEXT NOT NULL
    );

    CREATE TABLE country(
        iso_code TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        region TEXT NOT NULL,
        subregion TEXT NOT NULL,
        development TEXT NOT NULL
    );

    CREATE TABLE homicides (
        id SERIAL PRIMARY KEY,
        category_id TEXT REFERENCES category (name) ON DELETE CASCADE ON UPDATE RESTRICT,
        country_id TEXT REFERENCES country (iso_code) ON DELETE CASCADE ON UPDATE RESTRICT,
        indicator TEXT NOT NULL,
        sex TEXT NOT NULL,
        age TEXT NOT NULL,
        year INT NOT NULL,
        value NUMERIC NOT NULL,
        source TEXT NOT NULL
    );

    -- Inserción de los datos limpios en las tablas.
    INSERT INTO category (name, dimension)
        SELECT DISTINCT category, dimension
        FROM cleaning.homicides;

    INSERT INTO country (iso_code, name, region, subregion, development)
        SELECT DISTINCT iso3_code, country, region, subregion, development
        FROM cleaning.homicides;

    INSERT INTO public.homicides (category_id, country_id, indicator, sex, age, year, value, source)
        SELECT DISTINCT category, iso3_code, indicator, sex, age, year, value, source
            FROM cleaning.homicides;

    SELECT * FROM public.homicides;