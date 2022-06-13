# Geral

Arquivos baixados do [geoportal de Vitória](https://geoweb.vitoria.es.gov.br/#/shp) em 14/05/2020.



## nsvia

Arquivo: bairros.zip

sha256sum: 307f158ccd7d9ff8f7ec9767de719595fde4ea759c14316d478da176c23303fe.zip

SRID: 31999

'BAIRRO': nsvia_name



## building

Arquivo: edificacao.zip

sha256sum: 58d1d77cd2dd760f6a57bfda746da7f2658fe8a1f23f6d371ed5a8e230ac30cf.zip

SRID: 31999



## via

Arquivo: eixo_logradouro.zip

sha256sum: 252f2228f3400be3f6fdbef5a99b3aacf1ed0232ab73675ed918f9b5f8743752.zip

SRID: 31999

'Nome': via_name



## parcel

Arquivo: lote.zip

sha256sum: 3a92899e5a7e87acb92cca7198cc0e894bac9ac96c2192b12b668d1e1d598898.zip

SRID: 31999

'numero': house_number

'logradouro': via_name

'bairro': nsvia_name





## license

sha256sum: 103333a5c4c55509af6ee0a02b50b6ba5d1894f2c9920829e41e8dce3509302e.zip



## Outros arquivos:

estrutura_viaria

Arquivo: estrutura_viaria.zip

sha256sum: 56e363e177410861a561dda1fa065f6e6cce5033b970dc5cc652ae9155c11fc1.zip

SRID: 31999

Delimitação das vias/quadras, geometria = linhas.



## SRID wkt:

PROJCRS["SIRGAS 1995 / UTM zone 24S",
    BASEGEOGCRS["SIRGAS 1995",
        DATUM["Sistema de Referencia Geocentrico para America del Sur 1995",
            ELLIPSOID["GRS 1980",6378137,298.257222101,
                LENGTHUNIT["metre",1]]],
        PRIMEM["Greenwich",0,
            ANGLEUNIT["degree",0.0174532925199433]],
        ID["EPSG",4170]],
    CONVERSION["UTM zone 24S",
        METHOD["Transverse Mercator",
            ID["EPSG",9807]],
        PARAMETER["Latitude of natural origin",0,
            ANGLEUNIT["degree",0.0174532925199433],
            ID["EPSG",8801]],
        PARAMETER["Longitude of natural origin",-39,
            ANGLEUNIT["degree",0.0174532925199433],
            ID["EPSG",8802]],
        PARAMETER["Scale factor at natural origin",0.9996,
            SCALEUNIT["unity",1],
            ID["EPSG",8805]],
        PARAMETER["False easting",500000,
            LENGTHUNIT["metre",1],
            ID["EPSG",8806]],
        PARAMETER["False northing",10000000,
            LENGTHUNIT["metre",1],
            ID["EPSG",8807]]],
    CS[Cartesian,2],
        AXIS["(E)",east,
            ORDER[1],
            LENGTHUNIT["metre",1]],
        AXIS["(N)",north,
            ORDER[2],
            LENGTHUNIT["metre",1]],
    USAGE[
        SCOPE["Engineering survey, topographic mapping."],
        AREA["South America - between 42°W and 36°W, southern hemisphere, onshore and offshore."],
        BBOX[-26.35,-42,0,-36]],
    ID["EPSG",31999]]
