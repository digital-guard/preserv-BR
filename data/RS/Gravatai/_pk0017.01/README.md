# Tarefas
## 1. Atribuir nome de logradouro nos lotes
Os lotes possuem somente o número predial.

Para atribuir o nome de logradouro, poderá usar um dos métodos:

1. Atribuir o nome de logradouro dos eixos de vias próximos. Nos casos de esquina, deverá usar dedução pelo entorno: lado par ou lado ímpar, número mais próximo etc.  
2. Atribuir através de planilha relacionando o número de inscrição aos respectivos endereços. **Note que a prefeitura não forneceu a planilha**.

N.B.: Caso precisar da planilha, solicitar com call center A4A.

Ver [Extração](#Extração) para dados.

## 2. Gerar ponto de endereço na testada do lote
Procedimento usando PostGIS com script desenvolvido pelo A4A.

Cada ponto terá os dados:
* Nome do logradouro
* Número predial

# Extração
Abaixo os passos para extração por tipo de dado relevante.

## Lotes
SRID: 31982
1. Abrir `SHP.rar`.
2. Selecionar todos os arquivos `lote_numero_predial.*`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `lote_numero_predial`:
* `Cadastro` (real): número de cadastro.
* `Número` (string): número de lote.

## Eixos
SRID: 31982
1. Abrir `SHP.rar`.
2. Selecionar todos os arquivos `sistema_viario.*`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `sistema_viario`:
* `NOME` (string): tipo de logradouro caixa alta.
* `TIPO` (string): nome de logradouro sem tipo.
* `LEI` (string): número da lei da denominação.

### Expressões
Para obter o nome do logradouro completo, usar:

`"NOME" + ' ' + "TIPO"`

## Loteamentos
SRID: 31982
1. Abrir `OPENSTREETMAP.rar`.
2. Selecionar todos os arquivos `PS_LOTEAMENTOS_SIRGAS 2000.*`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Bairros/loteamentos estão sem nome.

# Evidências de teste
Teste no QGIS:
![](qgis.png)
