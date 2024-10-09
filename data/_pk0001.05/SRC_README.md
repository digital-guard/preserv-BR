Os endereços domiciliares fornecidos pelo CNEFE de 2022 precisam ser convertidos em "endereços horizontais", com um endereço apenas por ponto geográfico (latitude/longitude).

Cada endereço horizontal resulta em um, dois ou mais domicílios. Tipicamente efícios de condomínios verticais podem apresentar um só endereço horizontal com dezenas ou centenas de domicílios. Do ponto de vista do endereçamento postal, os endereços de um mesmo condomínio vertical diferem apenas no chamado "complemento do endereço". Removendo as colunas relativas ao complemento, e eliminando duplicações, teríamos automaticamente a lista de endereços horizontais desejadas.

O processo descrito a seguir consiste na filtragem dos complementos, mas, infelzimente, não é tão simples quanto parece. Algumas outras normalizações foram necessárias:

1. Em certas cidades, como Brasília (fora do "padrão nacional"), as "colunas de complemento" do CNEFE foram utilizadas para descrever a localização horizontal, não podendo ser eliminadas em tais casos.

2. Mesmo nos condomínios (domicílios coletivos) houveram casos em que o CNEFE apresentou dois ou mais pontos diferentes, às vezes com os pontos diferindo por menos de um metro.

3. A *string* de nome de logradouro, nos formatos OSM e OpenAddressess precisa ser uma só, ou seja, requer concatenação das partes. Além disso algumas strings do CNEFE não se encontravam com espaços normalizados, requer normalização dos espaços.

4. Para caso de mesmo ponto com dois ou mais endereços distintos, foi necessário eleger um deles como correto. Como a maioria desses casos não passavam de dois, o segundo foi indicado entre parêntesis, como "(ou rual tal)" ou "(ou número tal)".

5. ... Diversos outros problemas menores.

Para corrigir a duplicidade de ponto indicada no item 2 foi adotada a solução de "snap to grid", usando a grade Geohash de 10 dígitos (da ordem de 1 ou 2 m² conforme latitude). Para o item 2 foi utilizada uma regular expression simples.

## Objetivo
Descrever o passo-a-passo de como produto de dado foi gerado. 

Nota. Os scripts descritos a seguir não foram otimizados, consistem apenas de um passo-a-passo razoável e de fácil execussão, para [garantir a reprodutibilidade](https://en.wikipedia.org/wiki/Reproducibility) do processo de geração do produto de dado &mdash; ou seja, garantir que qualquer pessoa possa repetir o que foi feito, chegando nos mesmos resultados.

## Metadados

Através dos metadados podemos garantir, sem sobra de dúvida, qual foi o dado original empregado, para depois iniciar o processo de reprodução da filtragem desses dados.

Os descritores do arquivo [`fileDescr-IBGE_CNEFE.csv`](fileDescr-IBGE_CNEFE.csv) foram gerados a partir de comandos Linux.

* **arquivo**: nome de arquivo (ZIP original do IBGE ou o CSV original).
* **bytes**: volume do arquivo, em bytes.
* **sha256**: [*hash* criptográfica SHA256](https://en.wikipedia.org/wiki/SHA-2), garantindo a autenticidade do arquivo.
* **lines**: quantidade de linhas na tabela (mais uma linha de header).

```bash
# gera checksum SHA256:
sha256sum *.csv
sha256sum *.zip

# gera contagem de bytes:
ls -l *.csv | awk '{print $9,$5;}'
ls -l *.zip | awk '{print $9,$5;}'

# gera contagem de linhas:
for fname in *.csv; do   wc -l $fname; done
```

## Carga dos dados CNEFE

Tradicionalmente a carga bruta (*as is*) de CSV no PostgreSQL é feita por COPY. Há todavia o custo de se copiar no banco algo que será em seguida descartado, e talvez ocupando espaço demais para bancos de dados sem muitos GB disponíveis. Uma outra estratégia é [usar a *extension* `file_fdw`](https://stackoverflow.com/a/62493516/287948) do PostgreSQL... A seguir apenas a primeira, por ser mais simples.
 
1. Criar uma tabela temporária de colunas-texto, evitando risco de interrupção da cópia por erro de tipo.
2. Rodar comandos COPY para cada CSV. Supor que todos os arquivos originais e "unzipados" estejam em `/tmp/IBGE_cnefe2022`
3. Converter para uma tabela com colunas em formato correto, e apagar a tabela do item 1.

Para o item 1 temos, seguindo o cabeçalho dos CSVs:
```sql
CREATE TABLE ibge_cnefe2022_tmp (
  COD_UNICO_ENDERECO text,
  COD_UF text,
  ...
  COD_INDICADOR_FINALIDADE_CONST text,
  COD_TIPO_ESPECI text
);
```
Para o item 2 podemos gerar em terminal Linux (linguagem Bash) os comandos COPY necessários:
```bash
ls *.csv | awk '{print "COPY ibge_cnefe2022 FROM #/tmp/IBGE_cnefe2022/" $1 "# WITH (format CSV, delimiter #;#, header);";}' | sed  "s/#/'/g"
```
No caso de servidor remoto e sem permissão de SSH local, podemos usar o comando de terminal `psql` conforme [essa dica](https://stackoverflow.com/a/41464864/287948).
<!-- 
A segunda abordagem, sem COPY, requer criação de uma tabela temporária praticamente idêntica:
```sql
CREATE EXTENSION file_fdw;
CREATE SERVER import FOREIGN DATA WRAPPER file_fdw;
CREATE FOREIGN TABLE ibge_cnefe2022_tmp(
  ...
) SERVER import OPTIONS ( filename '/tmp/pg_io/file.csv', format 'csv', delimiter ';');
```
...
```bash
ls *.csv | awk '{print "ALTER FOREIGN TABLE ibge_cnefe2022_tmp OPTIONS (SET filename #/tmp/IBGE_cnefe2022/" $1 "#); "}' | sed  "s/#/'/g"
```
-->

Por fim, o item 3 consiste em simplesmente criar a tabela desejada e apagar a bruta:

```sql
CREATE TABLE ibge_cnefe2022 AS
 SELECT ST_GeoHash(geom,10) as ghs10,
       cod_unico_endereco::bigint, cod_uf::int,
       cod_municipio::int,         cod_distrito::int,
       cod_subdistrito::bigint,    substring(cod_setor,0,16)::bigint as cod_setor,
       num_quadra::int,            num_face::int, 
       cep::bigint,                dsc_localidade,
       nom_tipo_seglogr,           nom_titulo_seglogr,
       nom_seglogr,                num_endereco,
       dsc_modificador,            nom_comp_elem1,
       val_comp_elem1,             nom_comp_elem2,
       val_comp_elem2,             nv_geo_coord::smallint,
       cod_especie::smallint,      dsc_estabelecimento,
       cod_indicador_estab_endereco::smallint,
       cod_indicador_const_endereco::smallint,
       cod_indicador_finalidade_const::smallint,
       cod_tipo_especi::smallint,
       via_name, -- nome completo da rua, normalizado 
       geom
 FROM (
   SELECT *,
          regexp_replace( coalesce(nom_tipo_seglogr,'') ||' '|| coalesce(nom_titulo_seglogr,'') ||' '|| coalesce(nom_seglogr,''), '\s+',' ','g') as via_name,
          ST_SetSRID(ST_MakePoint(longitude::float, latitude::float),4326) as geom
   FROM ibge_cnefe2022_tmp
 ) t
 ORDER BY 4,1
;
DROP TABLE ibge_cnefe2022_tmp cascade;  -- não precisamos mais dos dados brutos em TXT.
```

Para a geração do produto final também foi utilizada a tabela ***jurisdiction***, disponivel em https://git.digital-guard.org/preserv-BR/blob/main/data/jurisdictionLevel4.csv

## Análise e formatação final dos dados

Diversos relatórios estatísticos podem ser gerados, a seguir apenas os básicos para justificar as decisões de filtragem.

```sql
CREATE TABLE ibge_cnefe2022_ghs10_geom AS 
 -- Garante latitude e longitude originais, sem o "snap to grid". Em caso de duplicidade usa centroide.
 SELECT  ghs10, st_centroid(ST_Collect(geom)) as geom
 FROM ibge_cnefe2022 group by 1 order by 1
; -- 89899299

CREATE VIEW vw_ibge_cnefe2022_aux AS
  SELECT e.*, g.geom
  FROM ibge_cnefe2022 e 
  INNER JOIN ibge_cnefe2022_ghs10_geom g 
  ON g.ghs10=e.ghs10
;

CREATE VIEW ibge_cnefe2022_exp_OpenAddresses AS
 -- produto de dados exportado para https://OpenAddresses.io
 SELECT e.ghs10 as id,
     substring(j.isolabel_ext,3,2) as region, 
     j.name as city,
     e.num_endereco as number,
     via_name as street,
     e.cep as postcode,
     ST_Y(e.geom) as lat,
     ST_X(e.geom) as lon
 FROM vw_ibge_cnefe2022_aux e
 INNER JOIN jurisdiction j ON j.jurisd_base_id=76 AND j.jurisd_local_id=e.cod_municipio
 ORDER BY e.cod_municipio, e.ghs10
; -- 89899299
```

