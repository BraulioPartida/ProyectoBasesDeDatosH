----Creacion de schema e inserción de datos----
    DROP SCHEMA IF EXISTS cleaning CASCADE;
    CREATE SCHEMA IF NOT EXISTS cleaning;

    /*Se copía la tabla que esta en raw*/
    CREATE TABLE cleaning.homicides (
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

    /*Se insertan los datos*/
    INSERT INTO cleaning.homicides
        (id, iso3_code, country, region, subregion, indicator, dimension,
         category, sex, age, year, unit_of_measurement, value, source)
        SELECT id, TRIM(upper(iso3_code)), TRIM(upper(country)), TRIM(upper(region)),
               TRIM(upper(subregion)), TRIM(upper(indicator)), TRIM(upper(dimension)),
               TRIM(upper(category)), TRIM(upper(sex)), TRIM(upper(age)),
               year, TRIM(upper(unit_of_measurement)), value,
               TRIM(upper(source))
            FROM raw.homicides;

----Limpieza de datos----
