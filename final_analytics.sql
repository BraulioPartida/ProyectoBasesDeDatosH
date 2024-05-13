
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

/*
    Ver la diferencia entre perpetuadores (tipo de arma y relación con la víctima) y víctimas dividos por edad y sexo,
    y cómo ha cambiado a través de los años
*/

