# Geral



## geoaddress

**Arquivo `NUMERO_DE_PORTA.shp`**

`SRID`: 31983

- `gid`: COD_NP

- `via_name`: (buscar via_name através de join da coluna **COD_TRECHO** com via)

- `house_number`: NP

**Outros comentários:**

- Possui 5 `gid` duplicados e algumas geometrias inválidas (pontos vazios).

- COMPL_NP: complemento do endereço.

- COD_QUADRA: código quadra.

- COD_FACE: código face de quadra.

- COD_LOTE: código lote.

- COD_TRECHO: código trecho do logradouro.

- CEP: CEP.

## via

**Arquivo `Logradouros.geojson`**

`SRID`: 4326

- `gid`: COD_TRECHO

- `via_name`: COMPLETO

- `via_type`: TIPO_LOGRA_EXT

- `name`: (é possivel construir a partir de `via_name` e `via_type`, **NOME_PARCIAL** está incompleto)

**Outros comentários**

- `gid` possui muitos valores duplicados.

- NOME_PARCIAL (`name`) está incompleto, mas é possível construir a partir de `via_name` (Ex: Estrada da Vendinha vs Estrada Vendinha).

- Cod_Bairro: código do bairro.

- Nome: nome do bairro.

- HIERARQUIA: se é arterial, coletora etc.

- SIT_TRECHO: Ativo ou NA, ou seja, indica trechos que não devem ser priorizados nas rotas.

## genericvia

**Arquivo ``**

SRID: 

- `gid`:

- `via_name`:

- `via_type`:

- `name`:

## building

**Arquivo ``**

SRID: 

- `gid`:

- `via_name`:

- `house_number`:

## parcel

**Arquivo `Lotes_(2013).geojson`**

SRID: 4326

- `gid`: cod_lote ou cod_lote + cod_quadra

- `via_name`: (cod_trecho)

- `house_number`: (cod_np)

**Observações**

- Possui muitos gid duplicados, mesmo utilizando cod_lot + cod_quadra. Desconfio que cod_lote deveria ser um id único.

## nsvia

**Arquivo `Limite_de_Bairros.geojson`**

SRID: 4326

- `gid`: CODBAIRRO_LONG

- `name`: NOME

## block

**Arquivo `Quadras_(2013).geojson`**

SRID: 4326

- `gid`: COD_QUADRA

**Observações**

- Possui 767 gid duplicados.
