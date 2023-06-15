#!/bin/bash

# layer address:
rm -rf /tmp/sandbox/_pk7600007802_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007802_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/cbf1efdbbdbc96f0c012556ff36040d8314564d300f9c53aaef8b49f0b8000c9.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/cbf1efdbbdbc96f0c012556ff36040d8314564d300f9c53aaef8b49f0b8000c9.zip && sudo chmod 664 /var/www/dl.digital-guard.org/cbf1efdbbdbc96f0c012556ff36040d8314564d300f9c53aaef8b49f0b8000c9.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007802201_p2_address CASCADE"
cd /tmp/sandbox/_pk7600007802_001; 7z  x -y /var/www/dl.digital-guard.org/cbf1efdbbdbc96f0c012556ff36040d8314564d300f9c53aaef8b49f0b8000c9.zip "*Logradouros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
FSIZE=$$(du -b '/tmp/sandbox/_pk7600007802_001/Logradouros.geojson' | cut -f 1) ; \
if [ $$FSIZE -gt 157286400 ]; then \
cp -s /var/gits/_dg/preserv/src/splitGeojson.bash /tmp/sandbox/_pk7600007802_001; \
cd /tmp/sandbox/_pk7600007802_001; bash splitGeojson.bash 'Logradouros.geojson' 20000 ; \
psql postgres://postgres@localhost/ingest1 -c "DROP TABLE IF EXISTS pk7600007802201_p2_address" ; \
psql postgres://postgres@localhost/ingest1 -c "CREATE TABLE pk7600007802201_p2_address AS SELECT * FROM geojson_readfile_features_jgeom('/tmp/sandbox/_pk7600007802_001/splited1_Logradouros.geojson',null) WHERE jgeom->'type' is not null" ; \
cd /tmp/sandbox/_pk7600007802_001; find /tmp/sandbox/_pk7600007802_001 -path "*splited*_Logradouros.geojson" ! -path "*splited1_Logradouros.geojson" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c \"INSERT INTO pk7600007802201_p2_address SELECT * FROM geojson_readfile_features_jgeom('{}',null) WHERE jgeom->'type' is not null;\"" \; ; \
else \
psql postgres://postgres@localhost/ingest1 -c "DROP TABLE IF EXISTS pk7600007802201_p2_address" ; \
psql postgres://postgres@localhost/ingest1 -c "CREATE TABLE pk7600007802201_p2_address AS SELECT * FROM geojson_readfile_features_jgeom('/tmp/sandbox/_pk7600007802_001/Logradouros.geojson',null) WHERE jgeom->'type' is not null" ; \
fi

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw2_pk7600007802201_p2_address AS SELECT DISTINCT properties->'COD_TRECHO' AS ref, properties->'COMPLETO' AS via FROM $(tabname) WHERE properties->'COD_TRECHO' IS NOT NULL AND properties->'COMPLETO' IS NOT NULL"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('geojson2sql','/tmp/sandbox/Logradouros.geojson','address_cmpl','vw2_pk7600007802201_p2_address','7600007802201','cbf1efdbbdbc96f0c012556ff36040d8314564d300f9c53aaef8b49f0b8000c9.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw2_pk7600007802201_p2_address"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.cadastral_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007802201_p2_address CASCADE"
rm -f /tmp/sandbox/_pk7600007802_001/*Logradouros.* || true

# layer block:
rm -rf /tmp/sandbox/_pk7600007802_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007802_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/6daa65d15bbda6b9d9959daf8d43c2063ed0410b643870c24d22af4fd149032d.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/6daa65d15bbda6b9d9959daf8d43c2063ed0410b643870c24d22af4fd149032d.zip && sudo chmod 664 /var/www/dl.digital-guard.org/6daa65d15bbda6b9d9959daf8d43c2063ed0410b643870c24d22af4fd149032d.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007802501_p5_block CASCADE"
cd /tmp/sandbox/_pk7600007802_001; 7z  x -y /var/www/dl.digital-guard.org/6daa65d15bbda6b9d9959daf8d43c2063ed0410b643870c24d22af4fd149032d.zip "*Quadras_(2013)*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
FSIZE=$$(du -b '/tmp/sandbox/_pk7600007802_001/Quadras_(2013).geojson' | cut -f 1) ; \
if [ $$FSIZE -gt 157286400 ]; then \
cp -s /var/gits/_dg/preserv/src/splitGeojson.bash /tmp/sandbox/_pk7600007802_001; \
cd /tmp/sandbox/_pk7600007802_001; bash splitGeojson.bash 'Quadras_(2013).geojson' 20000 ; \
psql postgres://postgres@localhost/ingest1 -c "DROP TABLE IF EXISTS pk7600007802501_p5_block" ; \
psql postgres://postgres@localhost/ingest1 -c "CREATE TABLE pk7600007802501_p5_block AS SELECT * FROM geojson_readfile_features_jgeom('/tmp/sandbox/_pk7600007802_001/splited1_Quadras_(2013).geojson',null) WHERE jgeom->'type' is not null" ; \
cd /tmp/sandbox/_pk7600007802_001; find /tmp/sandbox/_pk7600007802_001 -path "*splited*_Quadras_(2013).geojson" ! -path "*splited1_Quadras_(2013).geojson" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c \"INSERT INTO pk7600007802501_p5_block SELECT * FROM geojson_readfile_features_jgeom('{}',null) WHERE jgeom->'type' is not null;\"" \; ; \
else \
psql postgres://postgres@localhost/ingest1 -c "DROP TABLE IF EXISTS pk7600007802501_p5_block" ; \
psql postgres://postgres@localhost/ingest1 -c "CREATE TABLE pk7600007802501_p5_block AS SELECT * FROM geojson_readfile_features_jgeom('/tmp/sandbox/_pk7600007802_001/Quadras_(2013).geojson',null) WHERE jgeom->'type' is not null" ; \
fi

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw5_pk7600007802501_p5_block AS SELECT row_number() OVER () as gid, jgeom AS geom \
FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('geojson2sql','/tmp/sandbox/Quadras_(2013).geojson','block_none','vw5_pk7600007802501_p5_block','7600007802501','6daa65d15bbda6b9d9959daf8d43c2063ed0410b643870c24d22af4fd149032d.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw5_pk7600007802501_p5_block"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007802501_p5_block CASCADE"
rm -f /tmp/sandbox/_pk7600007802_001/*Quadras_(2013).* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-RJ-RioJaneiro','/var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/block -type f -exec chmod 664 {} \;





# layer geoaddress:
rm -rf /tmp/sandbox/_pk7600007802_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007802_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/ca3372bbecd51a34481c39af3c194db84c3fd6b578a14f58aa8f787d3f86caf4.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/ca3372bbecd51a34481c39af3c194db84c3fd6b578a14f58aa8f787d3f86caf4.rar && sudo chmod 664 /var/www/dl.digital-guard.org/ca3372bbecd51a34481c39af3c194db84c3fd6b578a14f58aa8f787d3f86caf4.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007802101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk7600007802_001; 7z  x -y /var/www/dl.digital-guard.org/ca3372bbecd51a34481c39af3c194db84c3fd6b578a14f58aa8f787d3f86caf4.rar "*NUMERO_DE_PORTA*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600007802_001; shp2pgsql -D -W UTF-8  -s 31983 "NUMERO_DE_PORTA.shp" pk7600007802101_p1_geoaddress | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600007802101_p1_geoaddress AS SELECT row_number() OVER () as gid, NP AS hnum, COD_TRECHO AS cod_trecho, CEP AS postcode, geom \
FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/NUMERO_DE_PORTA.shp','geoaddress_ext','vw1_pk7600007802101_p1_geoaddress','7600007802101','ca3372bbecd51a34481c39af3c194db84c3fd6b578a14f58aa8f787d3f86caf4.rar',array[]::text[],1,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600007802101_p1_geoaddress"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007802101_p1_geoaddress CASCADE"
rm -f /tmp/sandbox/_pk7600007802_001/*NUMERO_DE_PORTA.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','BR-RJ-RioJaneiro','/var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/geoaddress','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/geoaddress
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/geoaddress -type f -exec chmod 664 {} \;

# layer nsvia:
rm -rf /tmp/sandbox/_pk7600007802_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007802_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/ea44a4e799c709b77e0de02ca98c67895246bccc4634940c77e5e82ce1b61f31.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/ea44a4e799c709b77e0de02ca98c67895246bccc4634940c77e5e82ce1b61f31.zip && sudo chmod 664 /var/www/dl.digital-guard.org/ea44a4e799c709b77e0de02ca98c67895246bccc4634940c77e5e82ce1b61f31.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007802401_p4_nsvia CASCADE"
cd /tmp/sandbox/_pk7600007802_001; 7z  x -y /var/www/dl.digital-guard.org/ea44a4e799c709b77e0de02ca98c67895246bccc4634940c77e5e82ce1b61f31.zip "*Limite_de_Bairros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
FSIZE=$$(du -b '/tmp/sandbox/_pk7600007802_001/Limite_de_Bairros.geojson' | cut -f 1) ; \
if [ $$FSIZE -gt 157286400 ]; then \
cp -s /var/gits/_dg/preserv/src/splitGeojson.bash /tmp/sandbox/_pk7600007802_001; \
cd /tmp/sandbox/_pk7600007802_001; bash splitGeojson.bash 'Limite_de_Bairros.geojson' 20000 ; \
psql postgres://postgres@localhost/ingest1 -c "DROP TABLE IF EXISTS pk7600007802401_p4_nsvia" ; \
psql postgres://postgres@localhost/ingest1 -c "CREATE TABLE pk7600007802401_p4_nsvia AS SELECT * FROM geojson_readfile_features_jgeom('/tmp/sandbox/_pk7600007802_001/splited1_Limite_de_Bairros.geojson',null) WHERE jgeom->'type' is not null" ; \
cd /tmp/sandbox/_pk7600007802_001; find /tmp/sandbox/_pk7600007802_001 -path "*splited*_Limite_de_Bairros.geojson" ! -path "*splited1_Limite_de_Bairros.geojson" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c \"INSERT INTO pk7600007802401_p4_nsvia SELECT * FROM geojson_readfile_features_jgeom('{}',null) WHERE jgeom->'type' is not null;\"" \; ; \
else \
psql postgres://postgres@localhost/ingest1 -c "DROP TABLE IF EXISTS pk7600007802401_p4_nsvia" ; \
psql postgres://postgres@localhost/ingest1 -c "CREATE TABLE pk7600007802401_p4_nsvia AS SELECT * FROM geojson_readfile_features_jgeom('/tmp/sandbox/_pk7600007802_001/Limite_de_Bairros.geojson',null) WHERE jgeom->'type' is not null" ; \
fi

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw4_pk7600007802401_p4_nsvia AS SELECT row_number() OVER () as gid, properties->'NOME' as nsvia, jgeom AS geom \
FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('geojson2sql','/tmp/sandbox/Limite_de_Bairros.geojson','nsvia_full','vw4_pk7600007802401_p4_nsvia','7600007802401','ea44a4e799c709b77e0de02ca98c67895246bccc4634940c77e5e82ce1b61f31.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw4_pk7600007802401_p4_nsvia"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007802401_p4_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600007802_001/*Limite_de_Bairros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-RJ-RioJaneiro','/var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600007802_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007802_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/c2febb1aa33dcf75c3a23f36c6c535e7223f219e1b71fa1121cf278623961a01.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/c2febb1aa33dcf75c3a23f36c6c535e7223f219e1b71fa1121cf278623961a01.zip && sudo chmod 664 /var/www/dl.digital-guard.org/c2febb1aa33dcf75c3a23f36c6c535e7223f219e1b71fa1121cf278623961a01.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007802301_p3_parcel CASCADE"
cd /tmp/sandbox/_pk7600007802_001; 7z  x -y /var/www/dl.digital-guard.org/c2febb1aa33dcf75c3a23f36c6c535e7223f219e1b71fa1121cf278623961a01.zip "*Lotes_(2013)*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
FSIZE=$$(du -b '/tmp/sandbox/_pk7600007802_001/Lotes_(2013).geojson' | cut -f 1) ; \
if [ $$FSIZE -gt 157286400 ]; then \
cp -s /var/gits/_dg/preserv/src/splitGeojson.bash /tmp/sandbox/_pk7600007802_001; \
cd /tmp/sandbox/_pk7600007802_001; bash splitGeojson.bash 'Lotes_(2013).geojson' 20000 ; \
psql postgres://postgres@localhost/ingest1 -c "DROP TABLE IF EXISTS pk7600007802301_p3_parcel" ; \
psql postgres://postgres@localhost/ingest1 -c "CREATE TABLE pk7600007802301_p3_parcel AS SELECT * FROM geojson_readfile_features_jgeom('/tmp/sandbox/_pk7600007802_001/splited1_Lotes_(2013).geojson',null) WHERE jgeom->'type' is not null" ; \
cd /tmp/sandbox/_pk7600007802_001; find /tmp/sandbox/_pk7600007802_001 -path "*splited*_Lotes_(2013).geojson" ! -path "*splited1_Lotes_(2013).geojson" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c \"INSERT INTO pk7600007802301_p3_parcel SELECT * FROM geojson_readfile_features_jgeom('{}',null) WHERE jgeom->'type' is not null;\"" \; ; \
else \
psql postgres://postgres@localhost/ingest1 -c "DROP TABLE IF EXISTS pk7600007802301_p3_parcel" ; \
psql postgres://postgres@localhost/ingest1 -c "CREATE TABLE pk7600007802301_p3_parcel AS SELECT * FROM geojson_readfile_features_jgeom('/tmp/sandbox/_pk7600007802_001/Lotes_(2013).geojson',null) WHERE jgeom->'type' is not null" ; \
fi

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw3_pk7600007802301_p3_parcel AS SELECT row_number() OVER () as gid, properties->'cod_trecho' AS via, \
properties->'cod_np' AS hnum,  jgeom AS geom \
FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('geojson2sql','/tmp/sandbox/Lotes_(2013).geojson','parcel_full','vw3_pk7600007802301_p3_parcel','7600007802301','c2febb1aa33dcf75c3a23f36c6c535e7223f219e1b71fa1121cf278623961a01.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw3_pk7600007802301_p3_parcel"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007802301_p3_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600007802_001/*Lotes_(2013).* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-RJ-RioJaneiro','/var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600007802_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007802_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/cbf1efdbbdbc96f0c012556ff36040d8314564d300f9c53aaef8b49f0b8000c9.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/cbf1efdbbdbc96f0c012556ff36040d8314564d300f9c53aaef8b49f0b8000c9.zip && sudo chmod 664 /var/www/dl.digital-guard.org/cbf1efdbbdbc96f0c012556ff36040d8314564d300f9c53aaef8b49f0b8000c9.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007802201_p2_via CASCADE"
cd /tmp/sandbox/_pk7600007802_001; 7z  x -y /var/www/dl.digital-guard.org/cbf1efdbbdbc96f0c012556ff36040d8314564d300f9c53aaef8b49f0b8000c9.zip "*Logradouros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
FSIZE=$$(du -b '/tmp/sandbox/_pk7600007802_001/Logradouros.geojson' | cut -f 1) ; \
if [ $$FSIZE -gt 157286400 ]; then \
cp -s /var/gits/_dg/preserv/src/splitGeojson.bash /tmp/sandbox/_pk7600007802_001; \
cd /tmp/sandbox/_pk7600007802_001; bash splitGeojson.bash 'Logradouros.geojson' 20000 ; \
psql postgres://postgres@localhost/ingest1 -c "DROP TABLE IF EXISTS pk7600007802201_p2_via" ; \
psql postgres://postgres@localhost/ingest1 -c "CREATE TABLE pk7600007802201_p2_via AS SELECT * FROM geojson_readfile_features_jgeom('/tmp/sandbox/_pk7600007802_001/splited1_Logradouros.geojson',null) WHERE jgeom->'type' is not null" ; \
cd /tmp/sandbox/_pk7600007802_001; find /tmp/sandbox/_pk7600007802_001 -path "*splited*_Logradouros.geojson" ! -path "*splited1_Logradouros.geojson" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c \"INSERT INTO pk7600007802201_p2_via SELECT * FROM geojson_readfile_features_jgeom('{}',null) WHERE jgeom->'type' is not null;\"" \; ; \
else \
psql postgres://postgres@localhost/ingest1 -c "DROP TABLE IF EXISTS pk7600007802201_p2_via" ; \
psql postgres://postgres@localhost/ingest1 -c "CREATE TABLE pk7600007802201_p2_via AS SELECT * FROM geojson_readfile_features_jgeom('/tmp/sandbox/_pk7600007802_001/Logradouros.geojson',null) WHERE jgeom->'type' is not null" ; \
fi

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw2_pk7600007802201_p2_via AS SELECT  row_number() OVER () as gid, \
properties->'COMPLETO' AS via, \
properties->'COD_TRECHO' AS ref, \
jgeom AS geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('geojson2sql','/tmp/sandbox/Logradouros.geojson','via_full','vw2_pk7600007802201_p2_via','7600007802201','cbf1efdbbdbc96f0c012556ff36040d8314564d300f9c53aaef8b49f0b8000c9.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw2_pk7600007802201_p2_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007802201_p2_via CASCADE"
rm -f /tmp/sandbox/_pk7600007802_001/*Logradouros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-RJ-RioJaneiro','/var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RJ/RioJaneiro/_pk0078.02/via -type f -exec chmod 664 {} \;



# layer joining

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.join('geoaddress_ext','cod_trecho','ca3372bbecd51a34481c39af3c194db84c3fd6b578a14f58aa8f787d3f86caf4.rar','address_cmpl','ref','cbf1efdbbdbc96f0c012556ff36040d8314564d300f9c53aaef8b49f0b8000c9.zip')"



