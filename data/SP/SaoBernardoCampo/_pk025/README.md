# Extração
Abaixo os passos para extração por tipo de dado relevante.

## Pontos de endereço
Codificação: ISO-8859-1
SRID: 31983
1. Abrir `Q_Endereco_SBC.zip`.
2. Selecionar arquivos `Q_Endereco_SBC.*`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `Q_Endereco_SBC`:
* `NOME_COMPL` (string): tipo via e nome do logradouro em caixa alta, por extenso e com acentuação.
* `Numero` (int): número predial. Sem número é representado como 0.

## Lotes
SRID: 31983
1. Abrir `lotes_SBC.zip`.
2. Selecionar arquivos `LOTE.*`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `LOTE`:
* `ZONA` (int): número de zona fiscal.
* `QUADRA` (int): número de quadra.
* `UNIDADE` (int): número de unidade/lote.

## Eixos
Codificação: ISO-8859-1
SRID: 31983
1. Abrir `logradouro_SBC.zip`.
2. Selecionar arquivos `LOGRADOURO.*`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `LOGRADOURO`:
* `NOME` (string): tipo via e nome do logradouro em caixa alta, por extenso e com acentuação.
* `DENOMINADA` (string): se o nome é de origem popular, de interesse social ou oficial. Valores: "CONHECIDA", "SOCIAL" e "OFICIAL".
* `ORIGEM` (string): se a via é oficial ou não. Valores: "OFICIAL" e "NÃO OFICIAL".

**Notas:**
1. Em `NOME`, há casos em que o nome contém o código de rota rodoviária. Ex.: "RODOVIA ANCHIETA (SP-150)".
2. Ruas em áreas de aglomeração subnormais e loteamentos irregulares costumam ter o nome do assentamento incluído no nome. Ex.: "RUA JOSÉ DIAS DONADELLI (NÚCLEO BELITA / NAZARETH)".

## Bairros
Codificação: ISO-8859-1
SRID: 31982
1. Abrir `bairro_SBC.zip`.
2. Selecionar arquivos shapefile `BAIRRO.*`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `BAIRRO`:
* `NOME` (string): nome do bairro em caixa alta, por extenso e com acentuação.
* `ZONA` (string): se o bairro está na zona urbana ou rural (área de mananciais).

# Outros
Outros dados:
* Equipamentos e Serviços Públicos: em `equipamento_SBC.zip`.
* Limite Municipal: em `limite_municipal_SBC.zip`.
* Represa: em `limite_represa_SBC.zip`.
* Praças Públicas, não usado para endereçamento: em `praca_SBC.zip`.

(!!! Havendo outros projetos, esta seção será detalhada !!!)

# Evidências de teste
Teste no QGIS:
![](qgis.png)
