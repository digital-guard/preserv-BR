# Tarefas

## 1. A rua esta abreviada, em caixa alta e sem acentuacao, mas como segue o mesmo padrao nos dois arquivos (via e building) nao tem problema.

{{#layers}}

# Extração
Abaixo os passos para extração por tipo de dado relevante.

{{#parcel}}
## Lotes
SRID: 31985
1. Abrir `parcel.zip`.
2. Selecionar arquivos `Natal_Lotes.shp`.
3. Copiar arquivos selecionados para diretório alvo.
{{/parcel}}

{{#via}}
## Vias
SRID: 31985
1. Abrir `via.zip`.
2. Selecionar arquivos `Logradouros_2019_SIRGAS2000.shp`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `Logradouros_2019_SIRGAS2000.shp`:
* `TIPO` + `NOME_1`: name.
{{/via}}

{{#block}}
## Quadras
SRID: 31985
1. Abrir `block.zip`.
2. Selecionar arquivos `QUADRAS.shp`.
3. Copiar arquivos selecionados para diretório alvo.
{{/block}}

{{#building}}
## Edificacoes
SRID: 31985
1. Abrir `building.zip`.
2. Selecionar arquivos `Natal_Edif.shp`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `Natal_Edif.shp`:
* `Tipo` + `Nome`: via;
* `Nº`: hnum.
{{/building}}

{{#nsvia}}
## Bairros
SRID: 31985
1. Abrir `nsvia.zip`.
2. Selecionar arquivos `Limite_de_Bairros.shp`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `Limite_de_Bairros.shp`:
* `N_`: gid;
* `BAIRRO`: name.
{{/nsvia}}

{{/layers}}

## Outros

* Educacao
* Equipamentos Desportivos
* Feiras Livres
* Pracas
* Saude
* Seguranca Publica
