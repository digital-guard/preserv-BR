# Geral

Recebemos os dados por e-mail em 2022-03-15. Os dados também estão disponíveis para download no portal [Guarugeo](https://guarugeo.guarulhos.sp.gov.br/). Todas as camadas estão no formato `shapefile`, cada uma armazenada em um arquivo `WinRAR ZIP`.

SRID: 31983

## Bairros (nsvia)

1. Abrir `pg_cartografia_bairros.zip`

2. Selecionar todos os arquivos

3. Copiar para o diretório alvo

### Campos relevantes:

- `id_bairro` = id do bairro

- `bairro` = nome do bairro



## Logradouros (via)

1. Abrir `pg_cartografia_logradouros.zip`

2. Selecionar todos os arquivos

3. Copiar para o diretório alvo

### Campos relevantes:

- `cod_log` = id da via

- `id_bairro` = id do bairro

- `Logradouro` = nome do logradouro (via_name)

- `gid` = identificador único do logradouro

Obs: `cod_log` não é um id único, ele contempla vários segmentos de um mesmo logradouro. Ele é necessário para fazer join com o geoaddress. Existe um campo de id único chamado `gid`.



## Endereços (geoaddress)

1. Abrir `pg_renumeracoes.zip`

2. Selecionar todos os arquivos

3. Copiar para o diretório alvo

### Campos relevantes:

- `numnovo` = numero de porta (house_number)

- `cod_log` = id da via

- `gid` = identificador único do endereço


