# Geral

Recebemos os dados por e-mail em 2022-03-15. Os dados também estão disponíveis para download no portal [Guarugeo](https://guarugeo.guarulhos.sp.gov.br/). Todas as camadas estão no formato `shapefile`.

SRID: 31983



## nsvia

Abrir pg_cartografia_bairros.zip

Selecionar todos os arquivos

Copiar para o diretório alvo

gid: gid

bairro: nsvia_name

geom: geom



## via

Abrir pg_cartografia_logradouros.zip

Selecionar todos os arquivos

Copiar para o diretório alvo

gid: gid

Logradouro: via_name

geom: geom



## geoaddress

Abrir pg_renumeracoes.zip

Selecionar todos os arquivos

Copiar para o diretório alvo

gid: gid

numnovo: house_number

geom: geom

**Obs:**

Logradouro: via_name (necessario buscar no arquivo via atraves de join com o campo cod_log)



## Outros arquivos:

- pg_div_municipio.zip

- pg_cartografia_ct_vias.zip

# Procedimento de join geoaddress e via 
```
Quando for fazer ingestão guardar os números de file_id, iremos usar no script

make all_layers 
From file_id=1 inserted type=via_full. 
From file_id=2 inserted type=nsvia_full.
From file_id=3 inserted type=geoaddress_full.

1) Criação de tabela temporária para via
Tem via com via_name nulo vindo dos arquivos

create table tmp_via as 
select 
	properties->'cod_log' AS cod_log, properties->'via_name' as via_name from ingest.feature_asis 
where 
	ingest.feature_asis.file_id = 1 AND (properties->'via_name')::text <> '' and (properties->'via_name')::text <> 'null'
group by 
	properties->'cod_log',properties->'via_name'
;
SELECT 6916

2) Update ingest.feature_asis file_id=3 geoaddress

UPDATE ingest.feature_asis as t1 
SET properties = jsonb_set(t1.properties, '{via_name}', COALESCE(t2.via_name, '""') , TRUE )
FROM tmp_via as t2
where t1.file_id=3 and T1.properties->'cod_log' = t2.cod_log;

UPDATE 284101

select count(properties) from ingest.feature_asis
where file_id = 3;
 289917



```


