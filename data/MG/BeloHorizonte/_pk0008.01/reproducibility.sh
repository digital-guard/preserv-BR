#!/bin/bash







# layer geoaddress:
rm -rf /tmp/sandbox/_pk7600000801_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600000801_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/1ce29a555565be5f540ab0c6f93ac55797c368293e0a6bfb479a645a5a23f542.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/1ce29a555565be5f540ab0c6f93ac55797c368293e0a6bfb479a645a5a23f542.zip && sudo chmod 664 /var/www/dl.digital-guard.org/1ce29a555565be5f540ab0c6f93ac55797c368293e0a6bfb479a645a5a23f542.zip
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk7600000801101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk7600000801_001; 7z  x -y /var/www/dl.digital-guard.org/1ce29a555565be5f540ab0c6f93ac55797c368293e0a6bfb479a645a5a23f542.zip "*ENDERECO*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.fdw_generate_direct_csv( '/tmp/sandbox/_pk7600000801_001/ENDERECO.csv', 'pk7600000801101_p1_geoaddress' )"

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600000801101_p1_geoaddress AS SELECT row_number() OVER () as gid, \"SIGLA_TIPO_LOGRADOURO\" \
     || CASE WHEN \"SIGLA_TIPO_LOGRADOURO\" IN ('RUA','VIA') THEN ' ' ELSE '. ' END \
     || \"NOME_LOGRADOURO\" AS via,\
     \"NUMERO_IMOVEL\" || COALESCE(\"LETRA_IMOVEL\",'') AS hnum,\
     \"LETRA_IMOVEL\">'' AS is_complemento_provavel,\
     ST_GeomFromText(\"GEOMETRIA\",$(srid)) as geom \
FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('csv2sql','/tmp/sandbox/ENDERECO.csv','geoaddress_full','vw1_pk7600000801101_p1_geoaddress','7600000801101','1ce29a555565be5f540ab0c6f93ac55797c368293e0a6bfb479a645a5a23f542.zip',array[]::text[],1,2)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600000801101_p1_geoaddress"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk7600000801101_p1_geoaddress CASCADE"
rm -f /tmp/sandbox/_pk7600000801_001/*ENDERECO.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/MG/BeloHorizonte/_pk0008.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/MG/BeloHorizonte/_pk0008.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','BR-MG-BeloHorizonte','/var/gits/_dg/preservCutGeo-BR2021/data/MG/BeloHorizonte/_pk0008.01/geoaddress','2',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/MG/BeloHorizonte/_pk0008.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/BeloHorizonte/_pk0008.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/BeloHorizonte/_pk0008.01/geoaddress -type f -exec chmod 664 {} \;



# layer via:
rm -rf /tmp/sandbox/_pk7600000801_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600000801_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/7d7d0661683a8eebd95d544c47dd0e254fc75e3d916fe9900a3bd9fb7b2cc378.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/7d7d0661683a8eebd95d544c47dd0e254fc75e3d916fe9900a3bd9fb7b2cc378.zip && sudo chmod 664 /var/www/dl.digital-guard.org/7d7d0661683a8eebd95d544c47dd0e254fc75e3d916fe9900a3bd9fb7b2cc378.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000801201_p2_via CASCADE"
cd /tmp/sandbox/_pk7600000801_001; 7z  x -y /var/www/dl.digital-guard.org/7d7d0661683a8eebd95d544c47dd0e254fc75e3d916fe9900a3bd9fb7b2cc378.zip "*LOGRADOUROLine*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600000801_001; shp2pgsql -D -W ISO-8859-1  -s 31983 "LOGRADOUROLine.shp" pk7600000801201_p2_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw2_pk7600000801201_p2_via AS SELECT gid, TIPO_LOGRA || ' ' || NOME_LOGRA AS via, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/LOGRADOUROLine.shp','via_full','vw2_pk7600000801201_p2_via','7600000801201','7d7d0661683a8eebd95d544c47dd0e254fc75e3d916fe9900a3bd9fb7b2cc378.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw2_pk7600000801201_p2_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000801201_p2_via CASCADE"
rm -f /tmp/sandbox/_pk7600000801_001/*LOGRADOUROLine.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/MG/BeloHorizonte/_pk0008.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/MG/BeloHorizonte/_pk0008.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-MG-BeloHorizonte','/var/gits/_dg/preservCutGeo-BR2021/data/MG/BeloHorizonte/_pk0008.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/MG/BeloHorizonte/_pk0008.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/BeloHorizonte/_pk0008.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/BeloHorizonte/_pk0008.01/via -type f -exec chmod 664 {} \;




