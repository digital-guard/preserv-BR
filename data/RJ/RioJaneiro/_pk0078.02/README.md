# Geral

## geoaddress

Abrir NUMERO_DE_PORTA.shp

Copiar para o diretório alvo

SRID: 31983

row_number(): gid

NP: house_number

geom: geom

**Obs:**

COMPLETO: via_name (Obs: buscar no dataset via, através de join do campo COD_TRECHO)



## via

Abrir Logradouros.geojson

Copiar para o diretório alvo

SRID: 4326

row_number(): gid

COMPLETO: via_name

COD_TRECHO: ref

jgeom: geom



## parcel

Abrir Lotes_(2013).geojson

Copiar para o diretório alvo

SRID: 4326

row_number(): gid

cod_trecho: via_name

cod_np: house_number

geometry: geom



## block

Abrir Quadras_(2013).geojson

Copiar para o diretório alvo

SRID: 4326

row_number(): gid

jgeom: geom



## nsvia

Abrir Limite_de_Bairros.geojson

Copiar para o diretório alvo

SRID: 4326

CODBAIRRO_LONG: gid

NOME: nsvia_name

jgeom: geom



## Outros arquivos:

- Edificacoes.geojson
