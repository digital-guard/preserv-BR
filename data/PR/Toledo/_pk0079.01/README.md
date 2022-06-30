# Tarefas

## 1. No futuro e possivel atribuir nome do logradouro ao geoaddress (utilizando o campo angulo desse arquivo, arquivo via e tabelas nao inseridas).

{{#layers}}

# Extração
Abaixo os passos para extração por tipo de dado relevante.

{{#geoaddress}}
## Geoenderecos
SRID: 31982
1. Abrir `geoaddress.zip`.
2. Selecionar arquivos `NUM PREDIAIS.shp`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `NUM PREDIAIS.shp`:
* `id`: gid;
* `numero_pre`: house_number.
{{/geoaddress}}

{{#via}}
## Vias
SRID: 31982
1. Abrir `via.zip`.
2. Selecionar arquivos `LOGRADOUROS.shp`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `LOGRADOUROS.shp`:
* `id`: gid;
* `nomelogr`: name.
{{/via}}

{{#nsvia}}
## Bairros
SRID: 31982
1. Abrir `nsvia.zip`.
2. Selecionar arquivos `Bairros.shp`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `Bairros.shp`:
* `cod_bairro`: gid;
* `nm_bairro`: name.
{{/nsvia}}

{{#block}}
## Quadras
SRID: 31982
1. Abrir `block.zip`.
2. Selecionar arquivos `DELIM QUADRAS.shp`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `DELIM QUADRAS.shp`:
* `id`: gid.
{{/block}}

{{/layers}}

## Outros

* `Pontos de referencia` sem endereco
* `Loteamentos` sem endereco
* `Delimitacao Toledo`
* `LISTA DE ENDEREÇOS.xls`
* `Dados mun de Toledo.xls`
