
 -- Análisis
/*
    Analizar la cantidad de homicidios por país, subregión y región, así como la eficacia del poder judicial de cada
    uno y ver si está relacionada con su nivel de desarrollo
*/

    SELECT country.name, country.development, sum(homicides.value)
        FROM country
        JOIN public.homicides on country.iso_code = country_id
        WHERE indicator NOT LIKE '%CONVICTED%'
        GROUP BY country.name, country.development;

    SELECT country.subregion, sum(homicides.value)
        FROM country
        JOIN public.homicides on country.iso_code = country_id
        WHERE indicator NOT LIKE '%CONVICTED%'
        GROUP BY country.subregion;

    SELECT country.region, sum(homicides.value)
        FROM country
        JOIN public.homicides on country.iso_code = country_id
        WHERE indicator NOT LIKE '%CONVICTED%'
        GROUP BY country.region;

    SELECT country.name, country.development, sum(homicides.value)
        FROM country
        JOIN public.homicides on country.iso_code = country_id
        WHERE indicator LIKE '%CONVICTED%'
        GROUP BY country.name, country.development;

    SELECT country.subregion, sum(homicides.value)
        FROM country
        JOIN public.homicides on country.iso_code = country_id
        WHERE indicator LIKE '%CONVICTED%'
        GROUP BY country.subregion;

    SELECT country.region, sum(homicides.value)
        FROM country
        JOIN public.homicides on country.iso_code = country_id
        WHERE indicator LIKE '%CONVICTED%'
        GROUP BY country.region;

    SELECT DISTINCT category_id, MAX(homicides.value) OVER w AS max_eficacia_judicial
        FROM country
        JOIN public.homicides ON country.iso_code = homicides.country_id
        WHERE indicator ILIKE '%DEATH%' OR indicator ILIKE '%VICTIMS%'
        WINDOW w AS(
            PARTITION BY category_id
            ORDER BY category_id
                );

    SELECT DISTINCT category_id, AVG(homicides.value) OVER w AS avg_eficacia_judicial
        FROM country
        JOIN public.homicides ON country.iso_code = homicides.country_id
        WHERE indicator ILIKE '%DEATH%' OR indicator ILIKE '%VICTIMS%'
        WINDOW w AS(
            PARTITION BY category_id
            ORDER BY category_id
                );

/*
    Ver la diferencia entre perpetuadores (tipo de arma y relación con la víctima) y víctimas dividos por edad y sexo,
    y cómo ha cambiado a través de los años
*/

    SELECT year, sex, age, SUM(value) AS num_homicides
        FROM homicides
        WHERE age NOT LIKE 'TOTAL' AND sex NOT LIKE 'TOTAL'
          AND indicator NOT LIKE '%CONVICTED%' AND year >= 2010
        GROUP BY year, sex, age, category_id
        ORDER BY year;

    SELECT  year,homicides.category_id, SUM(value) AS num_homicides
        FROM homicides
        WHERE category_id ILIKE 'FIREARMS' OR category_id ILIKE 'WITHOUT A WEAPON/OTHER MECHANISM'
           OR category_id ILIKE 'ANOTHER WEAPON' OR category_id ILIKE 'FIREARMS'
           OR category_id ILIKE 'EXPLOSIVES' OR category_id ILIKE 'SHARP OBJECT'
        GROUP BY homicides.category_id, year
        ORDER BY year;

    SELECT  year,homicides.category_id, SUM(value) AS num_homicides
        FROM homicides
        GROUP BY homicides.category_id, year
        ORDER BY year;