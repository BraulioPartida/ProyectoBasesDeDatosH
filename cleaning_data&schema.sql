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
    SELECT DISTINCT iso3_code
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

    DELETE FROM cleaning.homicides WHERE LEFT(iso3_code, 4) = 'BIG5';
    DELETE FROM cleaning.homicides WHERE LEFT(iso3_code, 3) = 'M49';


    -- country
    SELECT DISTINCT country
        FROM cleaning.homicides
        WHERE country ~* '[^{a-z,() }]' AND country NOT LIKE '%AND%'
          AND country NOT LIKE '%OF%';

    UPDATE cleaning.homicides
    SET country = CASE
        WHEN LEFT (country, 3) = 'BOL' THEN replace (country, 'BOLIVIA (PLURINATIONAL STATE OF)', 'BOLIVIA')
        WHEN country = 'CURAÃ§AO' THEN replace (country, 'CURAÃ§AO', 'CURAZAO')
        WHEN LEFT (country, 4) = 'IRAN' THEN replace (country, 'IRAN (ISLAMIC REPUBLIC OF)', 'IRAN')
        WHEN LEFT (country, 5) = 'CHINA' THEN LEFT (country, 5)
        WHEN LEFT (country, 4) = 'IRAQ' THEN LEFT (country, 4)
        WHEN LEFT (country, 3) = 'KOS' THEN LEFT (country, 6)
        WHEN LEFT (country, 8) = 'UNITED K' THEN LEFT (country, 14)
        WHEN LEFT (country, 3) = 'VEN' THEN LEFT (country, 9)
        WHEN country LIKE '%-%' THEN replace(country, '-', ' ')
        ELSE country
    END
    WHERE LEFT (country,3) = 'BOL' OR country = 'CURAÃ§AO' OR LEFT (country, 4) = 'IRAN'
        OR LEFT (country, 5) = 'CHINA' OR LEFT (country, 4) = 'IRAQ' OR LEFT (country, 3) = 'KOS'
            OR LEFT (country, 8) = 'UNITED K' OR LEFT (country, 3) = 'VEN' OR country LIKE '%-%';

    DELETE FROM cleaning.homicides WHERE LEFT (country, 4) = 'MICR';
    DELETE FROM cleaning.homicides WHERE country LIKE '%Ã%';
    DELETE FROM cleaning.homicides WHERE country = 'AUSTRALIA AND NEW ZEALAND';
    DELETE FROM cleaning.homicides WHERE country = 'WORLD';

    -- region
    SELECT region, COUNT(*)
        FROM cleaning.homicides
        GROUP BY region ;

    -- subregion
    SELECT subregion, COUNT(*)
        FROM cleaning.homicides
        GROUP BY subregion ;

    UPDATE cleaning.homicides
        SET subregion = replace(subregion, '-', ' ')
        WHERE subregion LIKE '%-%';

    -- indicator
    SELECT indicator, COUNT(*)
        FROM cleaning.homicides
        GROUP BY indicator;

    DELETE FROM cleaning.homicides WHERE indicator = 'PERSONS ARRESTED/SUSPECTED FOR INTENTIONAL HOMICIDE';
    DELETE FROM cleaning.homicides WHERE indicator = 'VICTIMS OF INTENTIONAL HOMICIDE - REGIONAL ESTIMATE';
    DELETE FROM cleaning.homicides WHERE indicator = 'VICTIMS OF INTENTIONAL HOMICIDE Â€“ CITY-LEVEL DATA';

    SELECT indicator, COUNT(*)
        FROM cleaning.homicides
        WHERE indicator ~* '[^{a-z }]'
        GROUP BY indicator;

    -- dimension
    SELECT dimension, COUNT(*)
        FROM cleaning.homicides
        GROUP BY dimension;

    -- category
    SELECT category, COUNT(*)
        FROM cleaning.homicides
        GROUP BY category;

    UPDATE cleaning.homicides
    SET category = CASE
        WHEN category = 'ANOTHER WEAPON - SHARP OBJECT' THEN replace(category, 'ANOTHER WEAPON - SHARP OBJECT', 'SHARP OBJECT')
        WHEN category = 'FIREARMS OR EXPLOSIVES - FIREARMS' THEN replace(category, 'FIREARMS OR EXPLOSIVES - FIREARMS', 'FIREARMS')
        WHEN category = 'FIREARMS OR EXPLOSIVES' THEN replace(category, 'FIREARMS OR EXPLOSIVES', 'EXPLOSIVES')
        WHEN category = 'INTIMATE PARTNER OR FAMILY MEMBER: FAMILY MEMBER' THEN replace(category, 'INTIMATE PARTNER OR FAMILY MEMBER: FAMILY MEMBER', 'FAMILY MEMBER')
        WHEN category = 'INTIMATE PARTNER OR FAMILY MEMBER: INTIMATE PARTNER' THEN replace(category, 'INTIMATE PARTNER OR FAMILY MEMBER: INTIMATE PARTNER', 'INTIMATE PARTNER')
        WHEN category = 'SOCIO-POLITICAL HOMICIDE - TERRORIST OFFENCES' THEN replace(category, 'SOCIO-POLITICAL HOMICIDE - TERRORIST OFFENCES', 'TERRORIST OFFENCES')
        WHEN category LIKE '%-%' THEN replace(category, '-', ' ')
        WHEN category LIKE '%/ %' THEN replace(category, '/ ', '/')
        ELSE category
    END
    WHERE category = 'ANOTHER WEAPON - SHARP OBJECT' OR category = 'FIREARMS OR EXPLOSIVES - FIREARMS' OR category = 'FIREARMS OR EXPLOSIVES'
        OR category = 'INTIMATE PARTNER OR FAMILY MEMBER: FAMILY MEMBER' OR category = 'INTIMATE PARTNER OR FAMILY MEMBER: INTIMATE PARTNER'
            OR category = 'SOCIO-POLITICAL HOMICIDE - TERRORIST OFFENCES' OR category LIKE '%-%' OR category LIKE '%/ %';

    DELETE FROM cleaning.homicides WHERE category = 'INTIMATE PARTNER OR FAMILY MEMBER';

    -- sex
    SELECT sex, COUNT (*)
        FROM cleaning.homicides
        GROUP BY sex;

    -- age
    SELECT DISTINCT age
        FROM cleaning.homicides;

    UPDATE cleaning.homicides
        SET age = CASE
            WHEN age LIKE '% -%' THEN replace (age, ' -', '-')
            WHEN age = '60 AND OLDER' THEN replace(age, '60 AND OLDER', '60+')
        END
    WHERE age LIKE '% -%' OR age = '60 AND OLDER';

    DELETE FROM cleaning.homicides WHERE age = 'UNKNOWN';

    -- year
    SELECT year, COUNT (*)
        FROM cleaning.homicides
        GROUP BY year;

    -- unit_of_measurement
    SELECT unit_of_measurement, COUNT (*)
        FROM cleaning.homicides
        GROUP BY unit_of_measurement;

    DELETE FROM cleaning.homicides WHERE unit_of_measurement = 'RATE PER 100,000 POPULATION';
    ALTER TABLE cleaning.homicides DROP COLUMN unit_of_measurement;

    -- value
    SELECT value, COUNT (*)
        FROM cleaning.homicides
        GROUP BY value;

    -- source
    SELECT source, COUNT (*)
        FROM cleaning.homicides
        GROUP BY source;

    SELECT DISTINCT source
        FROM cleaning.homicides
        WHERE source ~* '[^{a-z/ 0-9}]' AND source NOT LIKE '%-%';