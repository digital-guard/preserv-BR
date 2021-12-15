# Tarefas

## 1. Gerar ponto de endereço na testada do lote
Procedimento usando PostGIS com script desenvolvido pelo A4A.

Cada ponto terá os dados:
* Nome do logradouro
* Número predial

# Extração
Abaixo os passos para extração por tipo de dado relevante.

## Lotes
SRID: 4326
Codificação: ISO-8859-1
1. Abrir `Cadastro_de_Imoveis.zip`.
2. Selecionar arquivos `Cadastro de Imoveis.*`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `Cadastro de Imoveis`:
* `bairro_imo` (string): nome do bairro.
* `cep_imovel` (string): CEP.
* `logradouro` (string): tipo e nome do logradouro em caixa alta.
* `numero_imo` (string): número predial.
* `unidades` (string): número de unidades dentro do lote (e.g. apartamentos).

## Quadras
SRID: 4326
Codificação: ISO-8859-1
1. Abrir `Quadras.zip`.
2. Selecionar arquivos `Quadras.*`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `Quadras`:
* `chave_qd` (string): número de identificação da quadras.

## Bairros
SRID: 4326
Codificação: ISO-8859-1
1. Abrir `Bairros.zip`.
2. Selecionar arquivos `Bairros.*`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `Bairros`:
* `bairro` (string): nome do bairro.

# Outras notas
Para baixar mapas shapefile do site de geo de Piracicaba
* http://geo.piracicaba.sp.gov.br/app/glue-piracicaba/map.html
* Usar projeção 4326 no menu à esquerda, do contrário não baixa.

# Evidências de teste
Teste no QGIS:
![](qgis.png)
