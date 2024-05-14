SELECT COUNT(*)
    FROM raw.homicides;

SELECT DISTINCT country
    FROM raw.homicides;

SELECT DISTINCT dimension
    FROM raw.homicides;

SELECT DISTINCT category
    FROM raw.homicides;

SELECT DISTINCT indicator
    FROM raw.homicides;

SELECT country, avg(value) AS promedio_homicidios
    FROM raw.homicides
    WHERE dimension ILIKE 'by mechanisms'
      AND dimension NOT ILIKE 'total'
    GROUP BY country
    ORDER BY country;

SELECT country, year,count(*)
    FROM raw.homicides
    WHERE category ILIKE 'Intimate partner or family member: Intimate partner'
    GROUP BY country, year
    ORDER BY country;

SELECT MAX(value) AS max_valor, MIN(value) AS min_valor
    FROM raw.homicides;

SELECT region, subregion, COUNT(*) AS cantRegistro
    FROM raw.homicides
    GROUP BY region, subregion;

SELECT MIN(year) AS año_mínimo, MAX(year) AS año_máximo
    FROM raw.homicides;

SELECT category, sex, COUNT(*) AS cantRegistro
    FROM raw.homicides
    WHERE sex NOT ILIKE 'total' AND category NOT ILIKE 'total'
    GROUP BY category, sex
    ORDER BY cantRegistro;

SELECT value, count(*)
    FROM raw.homicides
    GROUP BY value
    HAVING count(*)>1;

SELECT *
    FROM raw.homicides
    WHERE value = 4.994131895;

SELECT value, country, year, sex, age
    FROM raw.homicides
    ORDER BY year;

SELECT *
    FROM raw.homicides
    WHERE iso3_code ILIKE '%BIG5%';

SELECT indicator, *
    FROM raw.homicides
    WHERE dimension NOT ILIKE 'total'
    ORDER BY indicator;

SELECT *
    FROM raw.homicides
    ORDER BY year, iso3_code, sex, age, unit_of_measurement;

SELECT id,source,iso3_code, value
    FROM raw.homicides
    ORDER BY source, value;

SELECT source,iso3_code,year, age,sex, category, value
    FROM raw.homicides
    WHERE source ILIKE 'cts' AND iso3_code ILIKE 'arm'
    ORDER BY year;

SELECT unit_of_measurement, value, country, id
    FROM raw.homicides
    ORDER BY country;

SELECT year, country, value
    FROM raw.homicides;