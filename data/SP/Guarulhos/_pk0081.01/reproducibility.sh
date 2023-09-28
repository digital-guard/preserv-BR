#!/bin/bash

# layer address:
rm -rf /tmp/sandbox/_pk7600008101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600008101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/47910adcd297a9ba875d89dacc91bc6b2a37d6eab4910964253e117c1484b4c5.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/47910adcd297a9ba875d89dacc91bc6b2a37d6eab4910964253e117c1484b4c5.zip && sudo chmod 664 /var/www/dl.digital-guard.org/47910adcd297a9ba875d89dacc91bc6b2a37d6eab4910964253e117c1484b4c5.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008101201_p2_address CASCADE"
cd /tmp/sandbox/_pk7600008101_001; 7z  x -y /var/www/dl.digital-guard.org/47910adcd297a9ba875d89dacc91bc6b2a37d6eab4910964253e117c1484b4c5.zip "*pg_cartografia_logradouros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600008101_001; shp2pgsql -D   -s 31983 "pg_cartografia_logradouros.shp" pk7600008101201_p2_address | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw2_pk7600008101201_p2_address AS SELECT DISTINCT Logradouro as via, cod_log FROM $(tabname) WHERE Logradouro IS NOT NULL"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/pg_cartografia_logradouros.shp','address_cmpl','vw2_pk7600008101201_p2_address','7600008101201','47910adcd297a9ba875d89dacc91bc6b2a37d6eab4910964253e117c1484b4c5.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw2_pk7600008101201_p2_address"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.cadastral_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008101201_p2_address CASCADE"
rm -f /tmp/sandbox/_pk7600008101_001/*pg_cartografia_logradouros.* || true






# layer geoaddress:
rm -rf /tmp/sandbox/_pk7600008101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600008101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/1641b8c5fe5a2e9141939bb7353bda4fda1ea04d7a631a4d012e4759d1bf8447.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/1641b8c5fe5a2e9141939bb7353bda4fda1ea04d7a631a4d012e4759d1bf8447.zip && sudo chmod 664 /var/www/dl.digital-guard.org/1641b8c5fe5a2e9141939bb7353bda4fda1ea04d7a631a4d012e4759d1bf8447.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008101301_p3_geoaddress CASCADE"
cd /tmp/sandbox/_pk7600008101_001; 7z  x -y /var/www/dl.digital-guard.org/1641b8c5fe5a2e9141939bb7353bda4fda1ea04d7a631a4d012e4759d1bf8447.zip "*pg_renumeracoes*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600008101_001; shp2pgsql -D   -s 31983 "pg_renumeracoes.shp" pk7600008101301_p3_geoaddress | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600008101_001/pg_renumeracoes.shp','geoaddress_ext','pk7600008101301_p3_geoaddress','7600008101301','1641b8c5fe5a2e9141939bb7353bda4fda1ea04d7a631a4d012e4759d1bf8447.zip',array['gid', 'numnovo as hnum', 'cod_log', 'geom'],1,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008101301_p3_geoaddress CASCADE"
rm -f /tmp/sandbox/_pk7600008101_001/*pg_renumeracoes.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Guarulhos/_pk0081.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Guarulhos/_pk0081.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','BR-SP-Guarulhos','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Guarulhos/_pk0081.01/geoaddress','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Guarulhos/_pk0081.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Guarulhos/_pk0081.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Guarulhos/_pk0081.01/geoaddress -type f -exec chmod 664 {} \;

# layer nsvia:
rm -rf /tmp/sandbox/_pk7600008101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600008101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/d9cddc63f7782d250fc80f0572b9fb884ee7ec1911e19deea4381a4ad5d0a172.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/d9cddc63f7782d250fc80f0572b9fb884ee7ec1911e19deea4381a4ad5d0a172.zip && sudo chmod 664 /var/www/dl.digital-guard.org/d9cddc63f7782d250fc80f0572b9fb884ee7ec1911e19deea4381a4ad5d0a172.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008101101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk7600008101_001; 7z  x -y /var/www/dl.digital-guard.org/d9cddc63f7782d250fc80f0572b9fb884ee7ec1911e19deea4381a4ad5d0a172.zip "*pg_cartografia_bairros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600008101_001; shp2pgsql -D   -s 31983 "pg_cartografia_bairros.shp" pk7600008101101_p1_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600008101_001/pg_cartografia_bairros.shp','nsvia_full','pk7600008101101_p1_nsvia','7600008101101','d9cddc63f7782d250fc80f0572b9fb884ee7ec1911e19deea4381a4ad5d0a172.zip',array['gid', 'bairro as nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008101101_p1_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600008101_001/*pg_cartografia_bairros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Guarulhos/_pk0081.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Guarulhos/_pk0081.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-SP-Guarulhos','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Guarulhos/_pk0081.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Guarulhos/_pk0081.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Guarulhos/_pk0081.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Guarulhos/_pk0081.01/nsvia -type f -exec chmod 664 {} \;


# layer via:
rm -rf /tmp/sandbox/_pk7600008101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600008101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/47910adcd297a9ba875d89dacc91bc6b2a37d6eab4910964253e117c1484b4c5.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/47910adcd297a9ba875d89dacc91bc6b2a37d6eab4910964253e117c1484b4c5.zip && sudo chmod 664 /var/www/dl.digital-guard.org/47910adcd297a9ba875d89dacc91bc6b2a37d6eab4910964253e117c1484b4c5.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008101201_p2_via CASCADE"
cd /tmp/sandbox/_pk7600008101_001; 7z  x -y /var/www/dl.digital-guard.org/47910adcd297a9ba875d89dacc91bc6b2a37d6eab4910964253e117c1484b4c5.zip "*pg_cartografia_logradouros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600008101_001; shp2pgsql -D   -s 31983 "pg_cartografia_logradouros.shp" pk7600008101201_p2_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600008101_001/pg_cartografia_logradouros.shp','via_full','pk7600008101201_p2_via','7600008101201','47910adcd297a9ba875d89dacc91bc6b2a37d6eab4910964253e117c1484b4c5.zip',array['gid', 'Logradouro as via', 'cod_log', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008101201_p2_via CASCADE"
rm -f /tmp/sandbox/_pk7600008101_001/*pg_cartografia_logradouros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Guarulhos/_pk0081.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Guarulhos/_pk0081.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-SP-Guarulhos','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Guarulhos/_pk0081.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Guarulhos/_pk0081.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Guarulhos/_pk0081.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Guarulhos/_pk0081.01/via -type f -exec chmod 664 {} \;



# layer joining

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.join('geoaddress_ext','cod_log','1641b8c5fe5a2e9141939bb7353bda4fda1ea04d7a631a4d012e4759d1bf8447.zip','address_cmpl','cod_log','47910adcd297a9ba875d89dacc91bc6b2a37d6eab4910964253e117c1484b4c5.zip')"



