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

/* Se hace una exploración para determinar las columnas que contienen caracteres distintos de letras y números:) */

    -- iso3_code
    SELECT iso3_code
        FROM cleaning.homicides
        WHERE iso3_code ~* '[^{a-z_}]';

    UPDATE cleaning.homicides
    SET iso3_code = CASE
        WHEN LEFT(iso3_code, 3) = 'GBR' THEN LEFT(iso3_code, 3)
        WHEN LEFT(iso3_code, 3) = 'IRQ' THEN LEFT(iso3_code, 3)
        WHEN iso3_code = 'M49_MELAN' THEN replace(iso3_code, 'M49_MELAN', 'MEL')
        WHEN iso3_code = 'M49_AUS_NZL' THEN replace(iso3_code, 'M49_AUS_NZL', 'AUS_NZL')
        ELSE iso3_code
    END
    WHERE LEFT(iso3_code, 3) = 'GBR' OR LEFT(iso3_code, 3) = 'IRQ' OR iso3_code = 'M49_MELAN'
        OR iso3_code = 'M49_AUS_NZL';



    SELECT *
        FROM cleaning.homicides
    WHERE LEFT(iso3_code, 3) = 'M49';

SELECT iso3_code
        FROM cleaning.homicides
    WHERE country ILIKE 'POLYNESIA';

SELECT *
    from cleaning.homicides;

    DELETE FROM cleaning.homicides WHERE LEFT(iso3_code, 4) = 'BIG5';
    DELETE FROM cleaning.homicides WHERE LEFT(iso3_code, 3) = 'M49';

    -- country
    SELECT country, COUNT (*)
        FROM cleaning.homicides
    GROUP BY country ;

    SELECT country
        FROM cleaning.homicides
        WHERE country LIKE '%^{A-Z}%';-- AND country NOT LIKE '%AND%' AND country NOT LIKE '%OF%'

    SELECT country
        FROM cleaning.homicides
        WHERE country ~* '[^{a-z_,()}]' AND country NOT LIKE '%AND%' AND country NOT LIKE '%OF%'
            AND country NOT LIKE '%-%';

    UPDATE cleaning.homicides
    SET country = CASE
        WHEN LEFT (country, 3) = 'BOL' THEN replace (country, 'BOLIVIA (PLURINATIONAL STATE OF)', 'BOLIVIA')
        WHEN country = 'CURAÃ§AO' THEN replace (country, 'CURAÃ§AO', 'CURAZAO')
        WHEN LEFT (country, 4) = 'IRAN' THEN replace (country, 'IRAN (ISLAMIC REPUBLIC OF)', 'IRAN')
        WHEN country = 'M49_AUS_NZL' THEN replace (country, 'AMERICAN SAMOA', 'AMERICAN SAMOA')
        ELSE country
    END
    WHERE LEFT (country,3) = 'BOL' OR country = 'CURAÃ§AO' OR LEFT (country, 4) = 'IRAN'
        --OR country = 'M49_AUS_NZL';

                                     AMERICAN SAMOA
                                     AMERICAN



AMERICAN SAMOA
AMERICAN SAMOA
BRUNEI DARUSSALAM

AMERICAN
SRI

    -- region
    SELECT region, COUNT(*)
        FROM cleaning.homicides
    GROUP BY region ;

-- BORRAR WORLD
      --WHERE region ~* '%A-Z%';-- AND country NOT LIKE '%AND%' AND country NOT LIKE '%OF%'
            --AND country NOT LIKE '%-%';