# Geral

Recebemos os dados por e-mail em 2022-03-15. Os dados também estão disponíveis para download no portal [Guarugeo](https://guarugeo.guarulhos.sp.gov.br/). Todas as camadas estão no formato `shapefile`.

SRID: 31983



## nsvia

Abrir pg_cartografia_bairros.zip

Selecionar todos os arquivos

Copiar para o diretório alvo

gid: gid

bairro: nsvia_name

geom: geom



## via

Abrir pg_cartografia_logradouros.zip

Selecionar todos os arquivos

Copiar para o diretório alvo

gid: gid

Logradouro: via_name

geom: geom



## geoaddress

Abrir pg_renumeracoes.zip

Selecionar todos os arquivos

Copiar para o diretório alvo

gid: gid

numnovo: house_number

geom: geom

**Obs:**

Logradouro: via_name (necessario buscar no arquivo via atraves de join com o campo cod_log)



## Outros arquivos:

- pg_div_municipio.zip

- pg_cartografia_ct_vias.zip

