--Se crea el schema
    CREATE SCHEMA IF NOT EXISTS raw;

--Se crea la tabla para la raw data
    CREATE TABLE raw.homicides (
        id SERIAL PRIMARY KEY,
        iso3_code TEXT,
        country TEXT,
        region TEXT,
        subregion TEXT,
        indicator TEXT,
        dimension TEXT,
        category TEXT,
        sex TEXT,
        age TEXT,
        year INT,
        unit_of_measurement TEXT,
        value NUMERIC,
        source TEXT
    );

