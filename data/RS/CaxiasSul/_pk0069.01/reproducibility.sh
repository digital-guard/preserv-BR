#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600006901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600006901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/a9d2db675520121d4ed84084ae868d5868cbfc7516a8266eee30a15c651474dd.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/a9d2db675520121d4ed84084ae868d5868cbfc7516a8266eee30a15c651474dd.zip && sudo chmod 664 /var/www/dl.digital-guard.org/a9d2db675520121d4ed84084ae868d5868cbfc7516a8266eee30a15c651474dd.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006901401_p4_block CASCADE"
cd /tmp/sandbox/_pk7600006901_001; 7z  x -y /var/www/dl.digital-guard.org/a9d2db675520121d4ed84084ae868d5868cbfc7516a8266eee30a15c651474dd.zip "*quadras*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600006901_001; shp2pgsql -D   -s 31982 "quadras.shp" pk7600006901401_p4_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600006901_001/quadras.shp','block_none','pk7600006901401_p4_block','7600006901401','a9d2db675520121d4ed84084ae868d5868cbfc7516a8266eee30a15c651474dd.zip',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006901401_p4_block CASCADE"
rm -f /tmp/sandbox/_pk7600006901_001/*quadras.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-RS-CaxiasSul','/var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/block -type f -exec chmod 664 {} \;


# layer cadparcel:
rm -rf /tmp/sandbox/_pk7600006901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600006901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/58858f634229c4d857ad8bf774758f6051357b365c15d9a75cdf778cde2f65f6.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/58858f634229c4d857ad8bf774758f6051357b365c15d9a75cdf778cde2f65f6.zip && sudo chmod 664 /var/www/dl.digital-guard.org/58858f634229c4d857ad8bf774758f6051357b365c15d9a75cdf778cde2f65f6.zip
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk7600006901501_p5_cadparcel CASCADE"
cd /tmp/sandbox/_pk7600006901_001; 7z  x -y /var/www/dl.digital-guard.org/58858f634229c4d857ad8bf774758f6051357b365c15d9a75cdf778cde2f65f6.zip "*data-1626873935092*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
iconv -f us-ascii -t UTF-8 /tmp/sandbox/_pk7600006901_001/data-1626873935092.csv | dos2unix > /tmp/sandbox/_pk7600006901_001/data-1626873935092.unix_utf8.csv
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.fdw_generate_direct_csv( '/tmp/sandbox/_pk7600006901_001/data-1626873935092.unix_utf8.csv', 'pk7600006901501_p5_cadparcel' )"

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('csv2sql','/tmp/sandbox/_pk7600006901_001/data-1626873935092.csv','cadparcel_cmpl','pk7600006901501_p5_cadparcel','7600006901501','58858f634229c4d857ad8bf774758f6051357b365c15d9a75cdf778cde2f65f6.zip',array['cod_localizacao_completo', 'nr_imovel AS hnum'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.cadastral_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk7600006901501_p5_cadparcel CASCADE"
rm -f /tmp/sandbox/_pk7600006901_001/*data-1626873935092.* || true




# layer nsvia:
rm -rf /tmp/sandbox/_pk7600006901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600006901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/17c3cf7a5fc8429b79ab09193162a627ef9d93123f7b31e1f51435ef1a8c028c.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/17c3cf7a5fc8429b79ab09193162a627ef9d93123f7b31e1f51435ef1a8c028c.zip && sudo chmod 664 /var/www/dl.digital-guard.org/17c3cf7a5fc8429b79ab09193162a627ef9d93123f7b31e1f51435ef1a8c028c.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006901101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk7600006901_001; 7z  x -y /var/www/dl.digital-guard.org/17c3cf7a5fc8429b79ab09193162a627ef9d93123f7b31e1f51435ef1a8c028c.zip "*bairros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600006901_001; shp2pgsql -D   -s 31982 "bairros.shp" pk7600006901101_p1_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600006901_001/bairros.shp','nsvia_full','pk7600006901101_p1_nsvia','7600006901101','17c3cf7a5fc8429b79ab09193162a627ef9d93123f7b31e1f51435ef1a8c028c.zip',array['gid', 'nome AS nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006901101_p1_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600006901_001/*bairros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-RS-CaxiasSul','/var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600006901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600006901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/ca028e7824a7489c9a406884b78fe83dfbc72f15471bd9651e636d8a8d2afd3a.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/ca028e7824a7489c9a406884b78fe83dfbc72f15471bd9651e636d8a8d2afd3a.zip && sudo chmod 664 /var/www/dl.digital-guard.org/ca028e7824a7489c9a406884b78fe83dfbc72f15471bd9651e636d8a8d2afd3a.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006901301_p3_parcel CASCADE"
cd /tmp/sandbox/_pk7600006901_001; 7z  x -y /var/www/dl.digital-guard.org/ca028e7824a7489c9a406884b78fe83dfbc72f15471bd9651e636d8a8d2afd3a.zip "*lotes*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600006901_001; shp2pgsql -D   -s 31982 "lotes.shp" pk7600006901301_p3_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600006901_001/lotes.shp','parcel_ext','pk7600006901301_p3_parcel','7600006901301','ca028e7824a7489c9a406884b78fe83dfbc72f15471bd9651e636d8a8d2afd3a.zip',array['gid', 'inscrica_1', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006901301_p3_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600006901_001/*lotes.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-RS-CaxiasSul','/var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600006901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600006901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/09e01c7ab557f61a35999b32585f72059e983600606ea2870e1520e284815165.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/09e01c7ab557f61a35999b32585f72059e983600606ea2870e1520e284815165.zip && sudo chmod 664 /var/www/dl.digital-guard.org/09e01c7ab557f61a35999b32585f72059e983600606ea2870e1520e284815165.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006901201_p2_via CASCADE"
cd /tmp/sandbox/_pk7600006901_001; 7z  x -y /var/www/dl.digital-guard.org/09e01c7ab557f61a35999b32585f72059e983600606ea2870e1520e284815165.zip "*logradouros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600006901_001; shp2pgsql -D   -s 31982 "logradouros.shp" pk7600006901201_p2_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw2_pk7600006901201_p2_via AS SELECT row_number() OVER () as gid, tipolograd || ' ' || nomeoficia AS via, nomeusual AS nomeusual, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/logradouros.shp','via_full','vw2_pk7600006901201_p2_via','7600006901201','09e01c7ab557f61a35999b32585f72059e983600606ea2870e1520e284815165.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw2_pk7600006901201_p2_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006901201_p2_via CASCADE"
rm -f /tmp/sandbox/_pk7600006901_001/*logradouros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-RS-CaxiasSul','/var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/CaxiasSul/_pk0069.01/via -type f -exec chmod 664 {} \;



# layer joining



psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.join('parcel_ext','inscrica_1','ca028e7824a7489c9a406884b78fe83dfbc72f15471bd9651e636d8a8d2afd3a.zip','cadparcel_cmpl','cod_localizacao_completo','58858f634229c4d857ad8bf774758f6051357b365c15d9a75cdf778cde2f65f6.zip')"

