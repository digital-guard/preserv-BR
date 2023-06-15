#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600001901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600001901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/f4d3819f9853e85e43bf7a58de7f257eed5f63bcf36daed1c4db0f2701544adc.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/f4d3819f9853e85e43bf7a58de7f257eed5f63bcf36daed1c4db0f2701544adc.zip && sudo chmod 664 /var/www/dl.digital-guard.org/f4d3819f9853e85e43bf7a58de7f257eed5f63bcf36daed1c4db0f2701544adc.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001901201_p2_block CASCADE"
cd /tmp/sandbox/_pk7600001901_001; 7z  x -y /var/www/dl.digital-guard.org/f4d3819f9853e85e43bf7a58de7f257eed5f63bcf36daed1c4db0f2701544adc.zip "*Quadras*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600001901_001; shp2pgsql -D   -s 31982 "Quadras.shp" pk7600001901201_p2_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600001901_001/Quadras.shp','block_none','pk7600001901201_p2_block','7600001901201','f4d3819f9853e85e43bf7a58de7f257eed5f63bcf36daed1c4db0f2701544adc.zip',array['gid', 'NumQuadra', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001901201_p2_block CASCADE"
rm -f /tmp/sandbox/_pk7600001901_001/*Quadras.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-RS-SantaMaria','/var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/block -type f -exec chmod 664 {} \;






# layer nsvia:
rm -rf /tmp/sandbox/_pk7600001901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600001901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/f4d3819f9853e85e43bf7a58de7f257eed5f63bcf36daed1c4db0f2701544adc.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/f4d3819f9853e85e43bf7a58de7f257eed5f63bcf36daed1c4db0f2701544adc.zip && sudo chmod 664 /var/www/dl.digital-guard.org/f4d3819f9853e85e43bf7a58de7f257eed5f63bcf36daed1c4db0f2701544adc.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001901201_p2_nsvia CASCADE"
cd /tmp/sandbox/_pk7600001901_001; 7z  x -y /var/www/dl.digital-guard.org/f4d3819f9853e85e43bf7a58de7f257eed5f63bcf36daed1c4db0f2701544adc.zip "*Bairros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600001901_001; shp2pgsql -D   -s 31982 "Bairros.shp" pk7600001901201_p2_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600001901_001/Bairros.shp','nsvia_full','pk7600001901201_p2_nsvia','7600001901201','f4d3819f9853e85e43bf7a58de7f257eed5f63bcf36daed1c4db0f2701544adc.zip',array['gid', 'NOME AS nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001901201_p2_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600001901_001/*Bairros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-RS-SantaMaria','/var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600001901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600001901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/51a6beb9fca43e0fb45727138982f7806b8df52fce53f5e0e31edd61bfbc21b9.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/51a6beb9fca43e0fb45727138982f7806b8df52fce53f5e0e31edd61bfbc21b9.rar && sudo chmod 664 /var/www/dl.digital-guard.org/51a6beb9fca43e0fb45727138982f7806b8df52fce53f5e0e31edd61bfbc21b9.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001901101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600001901_001; 7z  x -y /var/www/dl.digital-guard.org/51a6beb9fca43e0fb45727138982f7806b8df52fce53f5e0e31edd61bfbc21b9.rar "*Lotes/lote*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600001901_001; shp2pgsql -D   -s 31982 "Lotes/lote.shp" pk7600001901101_p1_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600001901101_p1_parcel AS SELECT gid, Tipo || ' ' || Logradouro AS via, Numero AS hnum, Bairro AS nsvia, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/Lotes/lote.shp','parcel_full','vw1_pk7600001901101_p1_parcel','7600001901101','51a6beb9fca43e0fb45727138982f7806b8df52fce53f5e0e31edd61bfbc21b9.rar',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600001901101_p1_parcel"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001901101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600001901_001/*Lotes/lote.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-RS-SantaMaria','/var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600001901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600001901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/9600dcba403c8dc0b066c8f429507e4672966a01c93119923f75361a6ebc64c0.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/9600dcba403c8dc0b066c8f429507e4672966a01c93119923f75361a6ebc64c0.zip && sudo chmod 664 /var/www/dl.digital-guard.org/9600dcba403c8dc0b066c8f429507e4672966a01c93119923f75361a6ebc64c0.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001901301_p3_via CASCADE"
cd /tmp/sandbox/_pk7600001901_001; 7z  x -y /var/www/dl.digital-guard.org/9600dcba403c8dc0b066c8f429507e4672966a01c93119923f75361a6ebc64c0.zip "*Ruas*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600001901_001; shp2pgsql -D   -s 31982 "Ruas.shp" pk7600001901301_p3_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600001901_001/Ruas.shp','via_full','pk7600001901301_p3_via','7600001901301','9600dcba403c8dc0b066c8f429507e4672966a01c93119923f75361a6ebc64c0.zip',array['gid', 'NOME AS via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001901301_p3_via CASCADE"
rm -f /tmp/sandbox/_pk7600001901_001/*Ruas.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-RS-SantaMaria','/var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaMaria/_pk0019.01/via -type f -exec chmod 664 {} \;




