# Sobre

Material tratado a ser usado no PostGIS.

Caso precisar, o material original como recebido está em `BR-PR-PatoBranco/_pk041/_preservation`.

## Conteúdo

Dentro deste diretório temos:

### Shapefiles

* `lotes.zip`: geometria de lotes. Sem atributos relevantes.

* `lotes_num.zip`: pontos com número de lote localizado no centroide do lote.

* `lotes_chacaras.zip`: geometria de lotes classificados como chácaras. Sem atributos relevantes.

Note que a maioria são lotes dentro da cidade com área variando de 150 a 250 m2. Há alguns que estão na periferia que são grandes e faltando pedaços, já vieram assim. Acredito que estes últimos podem ser descartados.

* `lotes_chacaras_num.zip`: ponto com número de lote localizado +/- entre o centróide e a testada do lote. Os números de lote seguem outro padrão de numeração formando cluster de numeração, algo como 263-A, 263-B, 263-C, 263-D, concentrados num local, sugerindo que foram originados de desmembramento. Quando isolados, são numerados como CH-1, CH-2, CH-3 etc.

* `quadras_num.zip`: pontos com número de quadra localizado no centroide. O número está no atributo `text`.

Note que um quarteirão poderá ter mais de uma 'quadra'. A prefeitura não forneceu contorno de quadras numeradas.

* `meio_fio.zip`: polígono do leito carroçável, que pode servir como auxílio de polígono de quadra.

### Planilhas

* `Relatorio_de_numeracao_predial.csv`: planilha que foi obtida convertendo o original em PDF. Relaciona número de lote e quadra aos endereços.

### QGIS
O arquivo `PR-PatoBranco-tratamento.qgz` é o workspace do QGIS para visualização rápida.

# Tarefas
## 1. Atribuir numeração de lote e quadra nos lotes

### Número de lote

No centro de cada lote há um ponto com o número de lote. Os lotes estão no shapefile `lotes.zip` e os pontos de numeração de lote estão no shapefile `lotes_num.zip`.

Precisa obter o número do lote deste ponto (coluna `text` de `lotes.zip`) e atribuir no contorno do lote.

### Número de quadra

No centro de cada quarteirão há um ponto com o número de quadra. Os pontos de numeração de quadra estão no shapefile `quadras_num.zip`.

Precisa obter o número de quadra deste ponto (coluna `text` de `quadras_num.zip`) e atribuir no contorno do lote.

Veja imagem da amostra de lotes e quadras:
![](quadra.png)

O doador não forneceu mapa de numeração de quadras. Pode-se usar os meio-fios em `meio_fio.zip` como alternativa.

### Chácaras

No caso dos lotes de chácaras, o procedimento é o mesmo do acima descrito, apenas que serão usados os shapefiles em:
* `lotes_chacaras.zip` para contorno de lotes.
* `lotes_chacaras_num.zip` para ponto de numeração de lotes.

## 2. Atribuir endereços nos lotes

Uma vez que todos os lotes tiverem número de lote e número de quadra pela **tarefa 1**, deve-se usar a planilha `Relatorio_de_numeracao_predial.csv` para atribuir os endereços nos lotes.

A planilha `Relatorio_de_numeracao_predial.csv` possui as seguintes colunas, pela ordem:
* Número de Quadra
* Número do Lote
* Nome de Logradouro
* Número do Imóvel

## 3. Gerar ponto de endereço na testada do lote

Procedimento usando PostGIS com script desenvolvido pelo A4A.

Cada ponto terá os dados:
* Nome do logradouro
* Número predial

O nome do logradouro e número predial são obtidos dos dados dos lotes atribuídos na **tarefa 2**.

# GitHub
Issues:
* https://github.com/AddressForAll/digital-preservation-BR/issues/2
