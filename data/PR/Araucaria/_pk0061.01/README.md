# Geral
Não foram fornecidos dados com endereços.

# Extração
Abaixo os passos para extração por tipo de dado relevante.

## Lotes
Não há.

## Eixos
SRID: 29192
1. Abrir `Araucaria-PR.zip`.
2. Selecionar arquivos `Sistema Viário.*`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `Sistema Viário`:
* `denominaca` (string): tipo de via em caixa alta, com acentuação.
* `nome_compl` (string): nome de logradouro sem o tipo em caixa alta, com acentuação.
* `endereço` (string): tipo e nome de logradouro em caixa alta, com acentuação, usado para endereçamento.

**Notas:**
1. Em `endereço`: os nomes das rodovias são iniciados pelo código da rota rodoviária. Ex.:  "RODOVIA BR 476 - RODOVIA DO XISTO"; e há casos de repetir a palavra "RODOVIA": "PR 423 - RODOVIA RODOVIA ENGENHEIRO ADOLAR SCHULTZE".

## Bairros
SRID: 29192
1. Abrir `Araucaria-PR.zip`.
2. Selecionar arquivos shapefile `Bairros.*`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `Bairros`:
* `nome` (string): nome do bairro em caixa alta, com acentuação.

## Bairros (rurais)
SRID: 29192
1. Abrir `Araucaria-PR.zip`.
2. Selecionar arquivos shapefile `Localidades Rurais.*`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `Localidades Rurais`:
* `nomes` (string): nome do bairro em caixa alta, com acentuação.

# Evidências de teste
Teste no QGIS:
![](qgis.png)
