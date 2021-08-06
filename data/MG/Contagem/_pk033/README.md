# Sobre
O material foi fornecido no formato GDB (Geodatabase) e não funciona como arquivos shapefile. É um conjunto de databases onde os dados e geometrias são distribuídos em vários arquivos.

Ver [Extração: Antes de tudo](#Antes de tudo) para instalação.

# Extração
Abaixo os passos para extração por tipo de dado relevante.

## Antes de tudo
Instalação do diretório GDB:
1. Copiar `OpenStreetMap.gdb.rar` para diretório alvo.
2. Descompactar o rar para o obter o diretório `OpenStreetMap.gdb` com todo o conteúdo. **É requerido que este diretório tenha a extensão `.gdb`!**.

Os passos seguintes são feitos no QGIS.

## Bairros
SRID: 3857
1. No QGIS, pelo navegador, abrir `OpenStreetMap.gdb` no diretório alvo.
2. Selecionar camada `Bairros`.
3. Adicionar camada selecionada no projeto.

### Dados relevantes
Colunas:
* `Teste2_P_1` (string): nome do bairro em caixa alta.

## Eixos
SRID: 31983
1. No QGIS, pelo navegador, abrir `OpenStreetMap.gdb` no diretório alvo.
2. Selecionar camada `Logradouros`.
3. Adicionar camada selecionada no projeto.

### Dados relevantes
Colunas:
* `TIPO_LOGRA` (string): tipo de logradouro.
* `NOME_LOGRA` (string): nome do logradouro em caixa alta.
* `BAIRRO` (string): nome do bairro.

### Expressões
Para obter o nome do logradouro completo, usar:

`"TIPO_LOGRA" + ' ' + "NOME_LOGRA"`

## Pontos de endereço
SRID: 31983
1. No QGIS, pelo navegador, abrir `OpenStreetMap.gdb` no diretório alvo.
2. Selecionar camada `Endereco`.
3. Adicionar camada selecionada no projeto.

### Dados relevantes
Colunas:
* `Nome_logra` (string): nome do logradouro em caixa alta e baixa.
* `Num_imovel` (int): número predial.

## Lotes
SRID: 31983
1. No QGIS, pelo navegador, abrir `OpenStreetMap.gdb` no diretório alvo.
2. Selecionar camada `Lotes`.
3. Adicionar camada selecionada no projeto.

Os lotes não possuem endereços. Ver Pontos de endereço.

### Dados relevantes
Colunas:
* `BAIRRO` (string): nome do bairro em caixa alta.

## Praças
SRID: 31983
1. No QGIS, pelo navegador, abrir `OpenStreetMap.gdb` no diretório alvo.
2. Selecionar camada `Pracas`.
3. Adicionar camada selecionada no projeto.

### Dados relevantes
Colunas:
* `NOME` (string): nome da praça em caixa alta.

## Quadras
SRID: 31983
1. No QGIS, pelo navegador, abrir `OpenStreetMap.gdb` no diretório alvo.
2. Selecionar camada `Quadras`.
3. Adicionar camada selecionada no projeto.

### Dados relevantes
Colunas:
* `QUADRA` (int): número de quadra.

# Evidências de teste
Teste no QGIS:
![](qgis.png)
