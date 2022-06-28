# Tarefas

## 1. Municipio utiliza CRS personalizado. Precisamos atribuir SRID ao CRS.

{{#layers}}

# Extração
Abaixo os passos para extração por tipo de dado relevante.

{{#geoaddress}}
## Geoendereco
SRID: personalizado. Ver outros.
1. Abrir `NUMERACAO.zip`.
2. Selecionar arquivos `NUMERACAO.shp`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `NUMERACAO.shp`:
* `ENDEREÇO`: via_name;
* `NUMERACAO`: house_number.
{{/geoaddress}}

{{#via}}
## Eixos
SRID: personalizado. Ver outros.
1. Abrir `LOGRADOUROS.zip`.
2. Selecionar arquivos `LOGRADOUROS.shp`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `LOGRADOUROS.shp`:
* `TIPO` + `LOGRADOURO`: name.
{{/via}}

{{#building}}
## Edificacoes
SRID: personalizado. Ver outros.
1. Abrir `EDIFICACOES.zip`.
2. Selecionar arquivos `EDIFICACOES.shp`.
3. Copiar arquivos selecionados para diretório alvo.
{{/building}}

{{#parcel}}
## Lotes
SRID: personalizado. Ver outros.
1. Abrir `Lotes.zip`.
2. Selecionar arquivos `Lotes.shp`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `Lotes.shp`:
* `LOG_TIPO` + `LOG_NOME`: via_name;
* `IMO_NUMERO`: house_number.
{{/parcel}}

{{#nsvia}}
## Bairros
SRID: personalizado. Ver outros.
1. Abrir `BAIRROS.zip`.
2. Selecionar arquivos `BAIRROS.shp`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `BAIRROS.shp`:
* `NOME_BAIRR`: name.
{{/nsvia}}

{{#block}}
## Quadras
SRID: personalizado. Ver outros.
1. Abrir `QUADRAS.zip`.
2. Selecionar arquivos `QUADRAS.shp`.
3. Copiar arquivos selecionados para diretório alvo.
{{/block}}

{{/layers}}

## Outros
Para outros projetos, há também dados sobre:
* `TEATROS`: 8 pontos com endereco
* `PRACAS_PARQUES`: 8 pontos com endereco
* `MUSEUS`: 7 pontos com endereco
* `MUNICIPIO_MANAUS`: 1 poligono
* `CENTROS_CULTURAIS`: 8 pontos com endereco
* `BIBLIOTECAS`: 8 pontos com endereco

Comentario do Igor sobre o dado:
> Lotes contém endereços, mas faltam alguma de dezenas de lotes urbanos.

WKT SRID:

> Coordinate Reference System:
  User input: semef_SIR2000 
  wkt:
PROJCRS["semef_SIR2000",
    BASEGEOGCRS["SIRGAS 2000",
        DATUM["Sistema de Referencia Geocentrico para las AmericaS 2000",
            ELLIPSOID["GRS 1980",6378137,298.257222101,
                LENGTHUNIT["metre",1]],
            ID["EPSG",6674]],
        PRIMEM["Greenwich",0,
            ANGLEUNIT["Degree",0.0174532925199433]]],
    CONVERSION["unnamed",
        METHOD["Transverse Mercator",
            ID["EPSG",9807]],
        PARAMETER["Latitude of natural origin",0,
            ANGLEUNIT["Degree",0.0174532925199433],
            ID["EPSG",8801]],
        PARAMETER["Longitude of natural origin",-60,
            ANGLEUNIT["Degree",0.0174532925199433],
            ID["EPSG",8802]],
        PARAMETER["Scale factor at natural origin",0.999995,
            SCALEUNIT["unity",1],
            ID["EPSG",8805]],
        PARAMETER["False easting",400000,
            LENGTHUNIT["metre",1],
            ID["EPSG",8806]],
        PARAMETER["False northing",5000000,
            LENGTHUNIT["metre",1],
            ID["EPSG",8807]]],
    CS[Cartesian,2],
        AXIS["(E)",east,
            ORDER[1],
            LENGTHUNIT["metre",1,
                ID["EPSG",9001]]],
        AXIS["(N)",north,
            ORDER[2],
            LENGTHUNIT["metre",1,
                ID["EPSG",9001]]]]

