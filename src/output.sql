-- Output scripts
-- for out-BR and this git repos

COPY ( -- ddd,parent_abbrev into  info.  Falta population e area oficiais do IBGE.
  SELECT osm_id, jurisd_base_id, jurisd_local_id, name, abbrev, wikidata_id,
         lexlabel, isolabel_ext, info, admin_level, parent_id
  FROM optim.jurisdiction
  ORDER BY jurisd_base_id, admin_level, jurisd_local_id
) TO '/tmp/pg_io/out/br-jurisdiction.csv' CSV HEADER
;

COPY (
  SELECT * FROM optim.vwdump_origin
) TO '/tmp/pg_io/out/br-origin.csv' CSV HEADER;

-- falta gravar JSONs que complementam tabelas. [{id,json1,json2},...]
-- nomes com final ~extra.json , ex. br-jurisdiction~extra.json
-- dispensando campos kx, que gastam nao representam informacao extra.
-- no caso de geometrias, arquivo geoJSON.
-- conteudos XML em separado por arquivos XML <root><content rowid="..."></content> ...</root>
-- ex. crm-newsleter~extra.xml
