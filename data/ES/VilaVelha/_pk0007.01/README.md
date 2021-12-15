# Geral
Foi recebido o arquivo `SISTEMA_VIÁRIO.zip` que precisou ser renomeado e recompactado, por ter um diretório com nome corrompido.

# Tarefas
## 1. Adicionar eixos de vias
Não foi entregue os eixos de vias. Obter do OpenStreetMap ou aguardar mais material geoprocessável.

## 2. Atribuir endereços aos lotes
Os lotes não possuem endereços. Atribuir endereços através de uma planilha que relacione os códigos de lote (`CODGIS` em **Lotes**) aos respectivos endereços.

**A planilha não foi fornecida.**

## 3. Gerar ponto de endereço na testada do lote
Procedimento usando PostGIS com script desenvolvido pelo A4A.

Cada ponto terá os dados:
* Nome do logradouro
* Número predial.

# Extração
Abaixo os passos para extração por tipo de dado relevante.

## Lotes
Codificação: ISO-8859-1
SRID: 31984
1. Abrir `LOTES.zip`.
2. Abrir diretório `LOTES`.
3. Selecionar arquivos `LOTES.*`.
4. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `LOTES`:
* `CODGIS` (string): número composto de número de distrito, setor, quadra e lote (ver **Quadras**).
* `LOTE` (string): número de lote, que é os quatro últimos dígitos de `CODGIS`.

## Meios-fios
SRID: 31984
1. Abrir `SISTEMA_VIARIO.zip`.
2. Abrir diretório `SISTEMA_VIARIO`.
3. Selecionar arquivos `SISTVIARIO_SIRGAS2000.*`.
4. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Não há.

## Bairros
Codificação: ISO-8859-1
SRID: 31984
1. Abrir `BAIRROS.zip`.
2. Abrir diretório `BAIRROS`.
3. Selecionar arquivos shapefile `BAIRROS.*`.
4. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `BAIRROS`:
* `BAIRRO` (string): nome do bairro em caixa alta, por extenso e com acentuação.
O resto dos dados é irrelevante.

## Quadras
Codificação: ISO-8859-1
SRID: 31984
1. Abrir `QUADRAS.zip`.
2. Selecionar arquivos shapefile `BAIRRO.*`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `BAIRRO`:
* `DISTR` (string): número de distrito.
* `SETOR` (string): número de setor.
* `QUADRA` (string): número de quadra.
* `CODGIS` (string): número composto de `DISTR` + `SETOR` + `QUADRA`.

# Outros
Outros dados:
- Hidrografia, em `HIDROGRAFIA.zip`.

(!!! Havendo outros projetos, esta seção será detalhada !!!)

# Evidências de teste
Teste no QGIS:
![](qgis.png)
