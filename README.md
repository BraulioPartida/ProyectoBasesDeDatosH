# Proyecto bases de datos: Homicidios Intencionales
- Braulio César Partida Meneses
- Alexa Morales Pérez Vargas
- Alejandra Ortiz Montes de Oca

## ÍNDICE:
* [Conjunto de datos](#conjunto-de-datos)
* [Problema a estudiar](#problema-a-estudiar)
* [Limpieza de datos](#limpieza-de-datos)
* [Normalización de datos](#normalización-de-datos)
* [Análisis de datos](#análisis-de-datos)

## Conjunto de datos:
- Explicación: Las tablas sobre homicidio intencional incluyen cifras de víctimas de homicidio intencional a nivel de ciudad, nacional, regional y global, y cifras de personas arrestadas/sospechosas o condenadas por homicidio intencional.
- Link: https://dataunodc.un.org/dp-intentional-homicide-victims
- Archivo: data_cts_intentional_homicide.csv
- Atributos:
  - indicator: víctimas o arrestas.
  - sex: división por sexo (mujer, hombre) y el total.
  - age: grupos de edades de las personas que fueron asesinadas y el total.
  - year: año en el que se llevó a cabo el homicidio.
  - value: las veces que se llevó a cabo el tipo de homicidio, es un estimado.
  - source: códigos que representan de dónde se consiguió es información.
  - iso_code: código que representa el nombre de los países.
  - country: nombre del país.
  - region: contienente al que pertenece el país.
  - subregion: sub-división del continente al que pertenece el país.
  - development: desarrollo que tiene el país (desarrollado o subdesarrollado).
  - category: la forma en la que se llevó a cabo el homicidio.
  - dimension: contexto en el que se llevó a cabo el homicidio.

## Problema a estudiar:
- Analizar la cantidad de homicidios por país, subregión y región, así como la eficacia del poder judicial de cada uno y ver si está relacionada con su nivel de desarrollo.
- Ver la diferencia entre perpetuadores (tipo de arma y relación con la víctima) y víctimas dividos por edad y sexo, y cómo ha cambiado a través de los años.

## Limpieza de datos:
- Se creo un esquema, cleaning, dedicado a la limpieza de datos para no afectar los datos originales.

- Hicimos una exploración en cada columna para determinar aquellas que contenían caracteres distintos de letras y números
  - Ejemplo: CURAÃ§AO = CURAZAO

- Filtramos la información necesaria para nuestro proyecto
  - Ejemplo: ALTER TABLE cleaning.homicides DROP COLUMN unit_of_measurement;

- Archivos:
  - cleaning_data&schema.sql
  - country.csv

## Normalización de los datos:
- Ya que teníamos total conocimiento sobre la base de datos y los atributos que poseía planteamos las siguientes dependencias funcionales:
  - {iso} --> {country, region,subregion, development}.
  - {category} --> {dimension, indicato}.
- Se normalizó la base de datos para quedar en cuarta forma normal y resultaron las siguientes relaciones con los encabezados:
  - R1: iso_code, name (country), region, subregion,  development.
  - R2: name (category), dimension.
  - R3: category, country, indicator, sex, age, year, value, source.
- El modelo relacional resultante:
![Captura de pantalla 2024-05-12 134207](https://github.com/BraulioPartida/ProyectoBasesDeDatosH/assets/124923797/f4b49707-d9f3-44fe-ae50-5444218816e1)
- Archivo: final_tablas.sql

## Consulta de datos:
(preliminar: raw)
- Archivos:
  - raw_schema.sql
  - raw_exploration.sql

## Análisis de datos:
limpia
- Archivos:
  - final_analytics.sql
  - powerBL_intentional_homicide.pbix
