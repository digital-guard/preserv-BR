# Tarefas
## 1. Gerar eixos de vias com nomes do OpenStreetMap
Obter eixos de vias do mapa OpenStreeMap, dentro do limite do município de Cabreúva.

Os eixos de vias são obtidos das ways com a chave `highway`, conforme filtro que exclua vias não necessárias (e.g. trilhas, passeios etc).

Etiquetas relevantes:
* `name` (string): nome do logradouro.

## 2. Distribuir pontos de endereço ao longo dos eixos
Gerar e distribuir por interpolação pontos de endereço ao longo dos eixos de vias da tarefa 1.

Cada ponto terá os dados:
* Nome do logradouro
* Número predial

O nome do logradouro e a numeração predial são obtidos da planilha `relação_.csv`.

Extração da planilha:
1. Abrir `relacao_.csv.zip`.
2. Selecionar arquivo `relação_.csv`.
3. Copiar arquivos selecionados para diretório alvo.

Dados relevantes:
* Nome do logradouro: coluna 2 `Logradouro`, texto em caixa alta.
* Número predial: coluna 6 `Nº Imóvel`.
* Número de quadra: coluna 8 `Quadra`.

Devido à inconsistência entre os nomes dos eixos de vias e os da planilha (abreviação etc), deverá haver uma planilha DE-PARA.

Os pontos serão distribuidos ao longo da via, do centro para periferia, usando o número predial como distância de interpolação.

Para limitar a interpolação em trechos menores, use a coluna `Quadra`.

O doador não forneceu mapa de numeração de quadras, então use a coluna `Quadra` como forma de agrupar numerações prediais da mesma quadra e supor os trechos.

# GitHub
Issues:
* https://github.com/AddressForAll/digital-preservation-BR/issues/4

# Evidências de teste
(vazio)
