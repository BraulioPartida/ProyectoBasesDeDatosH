# Proyecto bases de datos: Homicidios Intencionales
- Braulio César Partida Meneses
- Alexa Morales Pérez Vargas
- Alejandra Ortiz Montes de Oca

##ÍNDICE:
*[Conjunto de datos] (#Conjunto de datos)
*[Problema a estudiar] (#Problema-a-estudiar)
*[Limpieza de datos] (#Limpieza-de-datos)
*[Normalización de datos] (#Normalización-de-datos)
*[Análisis de datos] (#Análisis-de-datos)

##:Conjunto de datos:
- Explicación: Las tablas sobre homicidio intencional incluyen cifras de víctimas de homicidio intencional a nivel de ciudad, nacional, regional y global, y cifras de personas arrestadas/sospechosas o condenadas por homicidio intencional.
- Link: https://dataunodc.un.org/dp-intentional-homicide-victims
- Atributos:
  - indicator: diferentes tipo de homicidios intencionales a analizar.
  - sex: división por sexo (mujer, hombre) y el total.
  - age: grupos de edades de las personas que fueron asesinadas y el total.
  - year: año en el que se llevó a cabo el homicidio.
  - value: valor que depende del indicador.
  - source: códigos que representan de dónde se consiguió es información.
  - iso_code: código que representa el nombre de los países.
  - country: nombre del país.
  - region: contienente al que pertenece el país.
  - subregion: sub-división del contienente al que pertenece el país.
  - development: desarrollo que tiene el país (primer o tercer mundo).
  - category: la forma en la que se llevó a cabo el homicidio.
  - dimension: contexto en el que se llevó a cabo el homicidio.

##:Problema a estudiar:

##:Limpieza de datos:

##:Normalización de los datos:
- Ya que teníamos total conocimiento sobre la base de datos y los atributos que poseía planteamos las siguientes dependencias funcionales:
  - {iso} --> {country, region,subregion, development}.
  - {category} --> {dimension, indicato}.
Se normalizó la base de datos para quedar en cuarta forma normal y resultaron las siguientes relaciones con los encabezados:
  - R1: iso_code, name (country), region, subregion,  development.
  - R2: name (category), dimension.
  - R3: category, country, indicator, sex, age, year, value, source.
El modelo relacional resultante:
![Captura de pantalla 2024-05-12 134207](https://github.com/BraulioPartida/ProyectoBasesDeDatosH/assets/124923797/f4b49707-d9f3-44fe-ae50-5444218816e1)

##:Consulta de datos:
