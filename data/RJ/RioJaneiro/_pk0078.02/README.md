# Geral

## geoaddress

Abrir NUMERO_DE_PORTA.shp

Copiar para o diretório alvo

SRID: 31983

row_number(): gid

NP: hnum

geom: geom

**Obs:**

COMPLETO: via (Obs: buscar no dataset via, através de join do campo COD_TRECHO)



## via

Abrir Logradouros.geojson

Copiar para o diretório alvo

SRID: 4326

row_number(): gid

COMPLETO: via

COD_TRECHO: ref

jgeom: geom



## parcel

Abrir Lotes_(2013).geojson

Copiar para o diretório alvo

SRID: 4326

row_number(): gid

cod_trecho: via

cod_np: hnum

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

NOME: nsvia

jgeom: geom



## Outros arquivos:

- Edificacoes.geojson
