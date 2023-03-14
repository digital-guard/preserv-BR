## Tarefas

### 1. Os enderecos de Brasilia nao seguem o tradicional [nome de logradouro] [numero de porta]. Dessa forma, "endereco de cartorio" pode ser equivalente ao numero de porta e os arquivos nao possuem "nome de logradouro".

### 2. Os enderecos estao em dois arquivos: um possui o "endereco de cartorio" e outro apenas a geometria. Se formos fazer o upload do arquivo apenas com a geometria, precisamos excluir as geometrias ja contempladas no primeiro arquivo.

### 3. nsvia esta dividido em dois arquivos (com geometrias que podem coincidir): Regioes Administrativas seria equivalente aos bairros e Setor uma subdivisao das Regioes Administrativas (apenas para algumas porcoes do territorio).


### Licenca
Nome do zip: license.zip
Nome do arquivo: BR-DF-Brasilia-license-2021-05-06.eml
Tipo do arquivo: eml (email)
{{/license}}

### Outros
Para outros projetos, há também dados sobre:
* Logradouros: divididos em 8 arquivos (por tipo). Como a maioria das vias nao possui nome de logradouro, optei por nao indicar para upload. OSM e melhor.
* Lotes ocupados: geometria redundante. Adiciona apenas a condicao (ocupado, vazio ou subutilizado).
* Conjunto: apenas geometria. Delimitacao de conjuntos habitacionais.
* Localidades: centroide dos bairros? Nao tenho certeza.

O arquivo Edificacao tambem possui nome do estabelecimento comercial (nao fizemos upload desse campo).

O arquivo Quadras possui geometrias multiplas. Quadra pode ser definida como a area edificada ao redor do logradouro (confirmar). O nome da quadra e utilizado na construcao do "numero de porta". Exemplo de nome/id da quadra: RUA 4 Q 19E

Comentario sobre a base de dados:
> Enderecos apenas de lotes regularizados
