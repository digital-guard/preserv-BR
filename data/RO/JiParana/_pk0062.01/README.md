# Tarefas

## 1. Parece que a acentuacao esta errada no arquivo vias: 'ex. Rua Mamor�'. Ver se da para corrigir. No arquivo lotes, nao utilizaram acentuacao 'ex: RUA MARMORE'.

## 2. O nome de logradouro no arquivo lotes esta sempre em caixa ALTA, enquanto no arquivo de vias esta em caixa alta e baixa (ex. RUA JOSEFINA G. VENTURINI e Rua Josefina G. Venturini).

{{#layers}}

# Extração
Abaixo os passos para extração por tipo de dado relevante.

{{#parcel}}
## Lotes
SRID: 32720
1. Abrir `Lotes.zip`.
2. Selecionar arquivos `Lotes basicos.shp`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `Lotes basicos.shp`:
* `LOTES_TIPO` + `LOTES_ENDE`: gid;
* `LOTES_NUME`: house_number.
{{/parcel}}

{{#via}}
## Vias
SRID: 32720
1. Abrir `Ruas.zip`.
2. Selecionar arquivos `Ruas Matriz.shp`.
3. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `Ruas Matriz.shp`:
* `Rua`: name.
{{/via}}

{{/layers}}

## Outros

---
