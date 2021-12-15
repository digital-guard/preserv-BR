# Tarefas

## 1. Gerar ponto de endereço na testada do lote
Procedimento usando PostGIS com script desenvolvido pelo A4A.

Cada ponto terá os dados:
* Nome do logradouro
* Número predial

# Extração
Abaixo os passos para extração por tipo de dado relevante.

## Lotes
SRID: 31982
Codificação: ISO-8859-1
1. Abrir `LOTES.rar`.
2. Selecionar todos os arquivos `LOTES.*`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `LOTES`:
* `NOME_LOGRA` (string): nome de logradouro em caixa alta.
* `TIPO_LOGRA` (string): tipo de logradouro em caixa alta abreviado.
* `NUMERO` (string): número predial.
* `NOME_BAIRR` (string): nome do bairro em caixa alta.

Lotes sem número são representados for várias formas "SN", "S/N", "s/n", "sem", "-", etc.

### Expressões
Expressão para construir a string do nome do logradouro:

`"NOME_LOGRA" + ' ' + "TIPO_LOGRA"`

## Eixos
SRID: 31982
Codificação: ISO-8859-1
1. Abrir `RUAS.rar`.
2. Selecionar todos os arquivos `RUAS.*`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `RUAS`:
* `NOME_RUA` (string): tipo e nome de logradouro em caixa alta e por extenso.

## Bairros
SRID: 31982
Codificação: ISO-8859-1
1. Abrir `BAIRROS.rar`.
2. Selecionar todos os arquivos `BAIRROS.*`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `BAIRROS`:
* `BAIRRO` (string): nome do bairro em caixa alta.

# Evidências de teste
Teste no QGIS:
![](qgis.png)
