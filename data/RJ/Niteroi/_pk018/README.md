# Geral
## Arquivos renomeados
Foram renomeados os seguintes arquivos por simplicidade:
* `Topon%C3%ADmias-shp.zip` -> `Toponimias-shp.zip`

# Tarefas
## 1. Atribuir endere�os nos lotes
Os lotes n�o possuem endere�o, mas um n�mero de inscri��o `tx_insct`.

Os endere�os poder�o ser atribu�dos via uma planilha relacionando o `tx_insct` aos endere�os. A prefeitura n�o enviou planilha.

Ver [Extra��o](#Extra��o) para detalhes.

## 2. Gerar ponto de endere�o na testada do lote
Procedimento usando PostGIS com script desenvolvido pelo A4A.

Cada ponto ter� os dados:
* Nome do logradouro
* N�mero predial

# Extra��o
Abaixo os passos para extra��o por tipo de dado relevante.

## Lotes
SRID: 4326
1. Abrir `Lotes.zip`.
2. Selecionar todos os arquivos `Lotes.*`.
3. Copiar arquivos selecionados para diret�rio alvo.

### Dados relevantes
Colunas da camada `Lotes`:
* `tx_insct` (string): n�mero de inscri��o.

Os demais atributos possuem preenchimento incompleto (NULL).

## Eixos
SRID: 4326
1. Abrir `Logradouro.zip`.
2. Selecionar todos os arquivos `Logradouro.*`.
3. Copiar arquivos selecionados para diret�rio alvo.

### Dados relevantes
Colunas da camada `Logradouro`:
* `ST_TYPE` (string): tipo de logradouro por extenso.
* `ST_NO` (string): nome de logradouro por extenso.
* `CMTY_L` (string): nome do bairro � esquerda do eixo.
* `CMTY_R` (string): nome do bairro � direita do eixo.
* `Legislacao` (string): lei da denomina��o (para outros projetos).

## Bairros
SRID: 4326
1. Abrir `Limite_de_Bairros-shp.zip`.
2. Selecionar todos os arquivos `Limite_de_Bairros.*`.
3. Copiar arquivos selecionados para diret�rio alvo.

N�o cont�m dados relevantes.

## Outros
Para outros projetos, h� tamb�m dados/datasets sobre:
* Empresas: pontos de empresas com endere�os cobrindo cerca de 25% dos lotes.
* Topon�mia: pontos de equipamentos urbanos, como escolas, UBSs etc.

Nota: o arquivo `METADADOS_Camadas SIGEONiteroi.xlsx.zip\METADADOS_Camadas SIGEONiteroi.xlsx` � uma biblioteca descrevendo cada dataset.

(!!! Havendo outros projetos, esta se��o ser� detalhada !!!)

# Evid�ncias de teste
Teste no QGIS:
![](qgis.png)
