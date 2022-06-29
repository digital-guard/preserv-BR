# Tarefas

## 1. Atribuir nome do logradouro ao lote (no futuro).

{{#layers}}

# Extração
Abaixo os passos para extração por tipo de dado relevante.

{{#via}}
## Eixos
SRID: 31985
1. Abrir `via.zip`.
2. Selecionar arquivos `Logradouro_gerais.shp`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `Logradouro_gerais.shp`:
* `NOME_LOGR`: name.
{{/via}}

{{#parcel}}
## Lotes
SRID: 31985
1. Abrir `parcel.zip`.
2. Selecionar arquivos `Lotes.shp`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `Lotes.shp`:
* `Nume_Imov`: house_number.
{{/parcel}}

{{#nsvia}}
## Bairros
SRID: 31985
1. Abrir `nsvia.zip`.
2. Selecionar arquivos `Bairros.shp`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `Bairros.shp`:
* `N_BAIRRO`: name.
{{/nsvia}}

{{#block}}
## Quadras
SRID: 31985
1. Abrir `block.zip`.
2. Selecionar arquivos `quadras_gerais.shp`.
3. Copiar arquivos selecionados para diretório alvo.
{{/block}}

{{/layers}}

## Outros
Para outros projetos, há também dados sobre:
* Pracas
