#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600007901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/6cf7e47ce736468fb740f4f6f884464e81f8ff3a9682f92c38d041825ebb4a39.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/6cf7e47ce736468fb740f4f6f884464e81f8ff3a9682f92c38d041825ebb4a39.zip && sudo chmod 664 /var/www/dl.digital-guard.org/6cf7e47ce736468fb740f4f6f884464e81f8ff3a9682f92c38d041825ebb4a39.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007901401_p4_block CASCADE"
cd /tmp/sandbox/_pk7600007901_001; 7z  x -y /var/www/dl.digital-guard.org/6cf7e47ce736468fb740f4f6f884464e81f8ff3a9682f92c38d041825ebb4a39.zip "*DELIM QUADRAS*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600007901_001; shp2pgsql -D   -s 31982 "DELIM QUADRAS.shp" pk7600007901401_p4_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600007901_001/DELIM QUADRAS.shp','block_full','pk7600007901401_p4_block','7600007901401','6cf7e47ce736468fb740f4f6f884464e81f8ff3a9682f92c38d041825ebb4a39.zip',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007901401_p4_block CASCADE"
rm -f /tmp/sandbox/_pk7600007901_001/*DELIM QUADRAS.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-PR-Toledo','/var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/block -type f -exec chmod 664 {} \;





# layer geoaddress:
rm -rf /tmp/sandbox/_pk7600007901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/e17bb963a4bf4f48743c5a60ac6ab91a88b6aff8b3ef7045a34bde155dbef1b9.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/e17bb963a4bf4f48743c5a60ac6ab91a88b6aff8b3ef7045a34bde155dbef1b9.zip && sudo chmod 664 /var/www/dl.digital-guard.org/e17bb963a4bf4f48743c5a60ac6ab91a88b6aff8b3ef7045a34bde155dbef1b9.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007901101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk7600007901_001; 7z  x -y /var/www/dl.digital-guard.org/e17bb963a4bf4f48743c5a60ac6ab91a88b6aff8b3ef7045a34bde155dbef1b9.zip "*NUM PREDIAIS*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600007901_001; shp2pgsql -D   -s 31982 "NUM PREDIAIS.shp" pk7600007901101_p1_geoaddress | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600007901_001/NUM PREDIAIS.shp','geoaddress_none','pk7600007901101_p1_geoaddress','7600007901101','e17bb963a4bf4f48743c5a60ac6ab91a88b6aff8b3ef7045a34bde155dbef1b9.zip',array['gid', 'numero_pre as hnum', 'geom'],1,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007901101_p1_geoaddress CASCADE"
rm -f /tmp/sandbox/_pk7600007901_001/*NUM PREDIAIS.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','BR-PR-Toledo','/var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/geoaddress','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/geoaddress -type f -exec chmod 664 {} \;

# layer nsvia:
rm -rf /tmp/sandbox/_pk7600007901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/54e8c962d93c5075b58656b0d935889e21ea340f97c0603be1ef5f1ee07d6805.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/54e8c962d93c5075b58656b0d935889e21ea340f97c0603be1ef5f1ee07d6805.zip && sudo chmod 664 /var/www/dl.digital-guard.org/54e8c962d93c5075b58656b0d935889e21ea340f97c0603be1ef5f1ee07d6805.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007901301_p3_nsvia CASCADE"
cd /tmp/sandbox/_pk7600007901_001; 7z  x -y /var/www/dl.digital-guard.org/54e8c962d93c5075b58656b0d935889e21ea340f97c0603be1ef5f1ee07d6805.zip "*Bairros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600007901_001; shp2pgsql -D   -s 31982 "Bairros.shp" pk7600007901301_p3_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600007901_001/Bairros.shp','nsvia_full','pk7600007901301_p3_nsvia','7600007901301','54e8c962d93c5075b58656b0d935889e21ea340f97c0603be1ef5f1ee07d6805.zip',array['gid', 'nm_bairro as nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007901301_p3_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600007901_001/*Bairros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-PR-Toledo','/var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/nsvia -type f -exec chmod 664 {} \;


# layer via:
rm -rf /tmp/sandbox/_pk7600007901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/497e972dd7415c9465e32e95d87d88d927327d5469d3c4f5a2aac306b6966404.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/497e972dd7415c9465e32e95d87d88d927327d5469d3c4f5a2aac306b6966404.zip && sudo chmod 664 /var/www/dl.digital-guard.org/497e972dd7415c9465e32e95d87d88d927327d5469d3c4f5a2aac306b6966404.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007901201_p2_via CASCADE"
cd /tmp/sandbox/_pk7600007901_001; 7z  x -y /var/www/dl.digital-guard.org/497e972dd7415c9465e32e95d87d88d927327d5469d3c4f5a2aac306b6966404.zip "*LOGRADOUROS*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600007901_001; shp2pgsql -D   -s 31982 "LOGRADOUROS.shp" pk7600007901201_p2_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600007901_001/LOGRADOUROS.shp','via_full','pk7600007901201_p2_via','7600007901201','497e972dd7415c9465e32e95d87d88d927327d5469d3c4f5a2aac306b6966404.zip',array['gid', 'nomelogr as via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007901201_p2_via CASCADE"
rm -f /tmp/sandbox/_pk7600007901_001/*LOGRADOUROS.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-PR-Toledo','/var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Toledo/_pk0079.01/via -type f -exec chmod 664 {} \;




