# Tarefas

## 1. Os enderecos de Brasilia nao seguem o tradicional [nome de logradouro] [numero de porta]. Dessa forma, "endereco de cartorio" pode ser equivalente ao numero de porta e os arquivos nao possuem "nome de logradouro".

## 2. Os enderecos estao em dois arquivos: um possui o "endereco de cartorio" e outro apenas a geometria. Se formos fazer o upload do arquivo apenas com a geometria, precisamos excluir as geometrias ja contempladas no primeiro arquivo.

## 3. nsvia esta dividido em dois arquivos (com geometrias que podem coincidir): Regioes Administrativas seria equivalente aos bairros e Setor uma subdivisao das Regioes Administrativas (apenas para algumas porcoes do territorio).

{{#layers}}

# Extração
Abaixo os passos para extração por tipo de dado relevante.

{{#building}}
## Edificacoes
SRID: 31983
1. Abrir `building.zip`.
2. Selecionar arquivos `Edificação.shp`.
3. Copiar arquivos selecionados para diretório alvo.
{{/building}}

{{#parcel}}
## Lotes
SRID: 31983
1. Abrir `parcel.zip`.
2. Selecionar arquivos `Lotes Registrados.shp`.
3. Copiar arquivos selecionados para diretório alvo.

4. Abrir `parcel2.zip`.
5. Selecionar arquivos `Lotes Implantados.shp`.
6. Deletar geometrias repetidas.
7. Copiar arquivos selecionados para diretório alvo (sem house_number).

### Dados relevantes
Colunas da camada `Lotes Registrados.shp`:
* `end_cart`: house_number.
Outras colunas:
* `lote`: numero do lote.
* `ciu`: id do lote (nao e um id unico por geometria).

Colunas da camada `Lotes Implantados.shp`:
Outras colunas:
* `ct_ciu`: id do lote (nao e um id unico por geometria).
{{/parcel}}

{{#nsvia}}
## Bairros
SRID: 31983
1. Abrir `nsvia.zip`.
2. Selecionar arquivos `Regiões Administrativas.shp`.
3. Copiar arquivos selecionados para diretório alvo.

4. Abrir `nsvia2.zip`.
5. Selecionar arquivos `Setor.shp`.
6. Copiar arquivos selecionados para diretório alvo.

### Dados relevantes
Colunas da camada `Regiões Administrativas.shp`:
* `ra_num`: gid (unico, pode utilizar);
* `ra`: name.

Colunas da camada `Setor.shp`:
* `sde_siturb`: name;
* `sde_situ_1`: name (da nsvia acima).
{{/nsvia}}

{{#block}}
## Quadras
SRID: 31983
1. Abrir `block.zip`.
2. Selecionar arquivos `Quadras.shp`.
3. Copiar arquivos selecionados para diretório alvo.

Colunas da camada `Quadras.shp`:
* `sde_siturb`: nome da quadra, equivalente ao nome do logradouro.
{{/block}}

{{/layers}}

{{#license}}
## Licenca
Nome do zip: license.zip
Nome do arquivo: BR-DF-Brasilia-license-2021-05-06.eml
Tipo do arquivo: eml (email)
{{/license}}

## Outros
Para outros projetos, há também dados sobre:
* Logradouros: divididos em 8 arquivos (por tipo). Como a maioria das vias nao possui nome de logradouro, optei por nao indicar para upload. OSM e melhor.
* Lotes ocupados: geometria redundante. Adiciona apenas a condicao (ocupado, vazio ou subutilizado).
* Conjunto: apenas geometria. Delimitacao de conjuntos habitacionais.
* Localidades: centroide dos bairros? Nao tenho certeza.

O arquivo Edificacao tambem possui nome do estabelecimento comercial (nao fizemos upload desse campo).

O arquivo Quadras possui geometrias multiplas. Quadra pode ser definida como a area edificada ao redor do logradouro (confirmar). O nome da quadra e utilizado na construcao do "numero de porta". Exemplo de nome/id da quadra: RUA 4 Q 19E

Comentario sobre a base de dados:
> Enderecos apenas de lotes regularizados
