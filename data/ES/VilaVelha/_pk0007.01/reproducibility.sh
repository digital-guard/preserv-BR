#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600000701_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600000701_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/3984d1a48b63d858fdfbe7829e493d1c35650546eb84039a59f9008de9bc4871.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/3984d1a48b63d858fdfbe7829e493d1c35650546eb84039a59f9008de9bc4871.zip && sudo chmod 664 /var/www/dl.digital-guard.org/3984d1a48b63d858fdfbe7829e493d1c35650546eb84039a59f9008de9bc4871.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000701301_p3_block CASCADE"
cd /tmp/sandbox/_pk7600000701_001; 7z  x -y /var/www/dl.digital-guard.org/3984d1a48b63d858fdfbe7829e493d1c35650546eb84039a59f9008de9bc4871.zip "*QUADRAS/QUADRAS*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31984"
cd /tmp/sandbox/_pk7600000701_001; shp2pgsql -D -W ISO-8859-1  -s 31984 "QUADRAS/QUADRAS.shp" pk7600000701301_p3_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600000701_001/QUADRAS/QUADRAS.shp','block_none','pk7600000701301_p3_block','7600000701301','3984d1a48b63d858fdfbe7829e493d1c35650546eb84039a59f9008de9bc4871.zip',array['gid', 'CODGIS AS ref', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000701301_p3_block CASCADE"
rm -f /tmp/sandbox/_pk7600000701_001/*QUADRAS/QUADRAS.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/ES/VilaVelha/_pk0007.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/ES/VilaVelha/_pk0007.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-ES-VilaVelha','/var/gits/_dg/preservCutGeo-BR2021/data/ES/VilaVelha/_pk0007.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/ES/VilaVelha/_pk0007.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/VilaVelha/_pk0007.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/VilaVelha/_pk0007.01/block -type f -exec chmod 664 {} \;






# layer nsvia:
rm -rf /tmp/sandbox/_pk7600000701_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600000701_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/c0cd7b2a4cc67b5d49a4d296f41b564b23464364ab746adc6d2206d5dd9249af.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/c0cd7b2a4cc67b5d49a4d296f41b564b23464364ab746adc6d2206d5dd9249af.zip && sudo chmod 664 /var/www/dl.digital-guard.org/c0cd7b2a4cc67b5d49a4d296f41b564b23464364ab746adc6d2206d5dd9249af.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000701201_p2_nsvia CASCADE"
cd /tmp/sandbox/_pk7600000701_001; 7z  x -y /var/www/dl.digital-guard.org/c0cd7b2a4cc67b5d49a4d296f41b564b23464364ab746adc6d2206d5dd9249af.zip "*BAIRROS/BAIRROS*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31984"
cd /tmp/sandbox/_pk7600000701_001; shp2pgsql -D -W ISO-8859-1  -s 31984 "BAIRROS/BAIRROS.shp" pk7600000701201_p2_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600000701_001/BAIRROS/BAIRROS.shp','nsvia_full','pk7600000701201_p2_nsvia','7600000701201','c0cd7b2a4cc67b5d49a4d296f41b564b23464364ab746adc6d2206d5dd9249af.zip',array['gid', 'BAIRRO AS nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000701201_p2_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600000701_001/*BAIRROS/BAIRROS.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/ES/VilaVelha/_pk0007.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/ES/VilaVelha/_pk0007.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-ES-VilaVelha','/var/gits/_dg/preservCutGeo-BR2021/data/ES/VilaVelha/_pk0007.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/ES/VilaVelha/_pk0007.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/VilaVelha/_pk0007.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/VilaVelha/_pk0007.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600000701_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600000701_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/5c7131c32a7411cf7a27022b8ac2989e88f86254ed74b6b3b2e5cf94b44e3acb.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/5c7131c32a7411cf7a27022b8ac2989e88f86254ed74b6b3b2e5cf94b44e3acb.zip && sudo chmod 664 /var/www/dl.digital-guard.org/5c7131c32a7411cf7a27022b8ac2989e88f86254ed74b6b3b2e5cf94b44e3acb.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000701101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600000701_001; 7z  x -y /var/www/dl.digital-guard.org/5c7131c32a7411cf7a27022b8ac2989e88f86254ed74b6b3b2e5cf94b44e3acb.zip "*LOTES/LOTES*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31984"
cd /tmp/sandbox/_pk7600000701_001; shp2pgsql -D -W ISO-8859-1  -s 31984 "LOTES/LOTES.shp" pk7600000701101_p1_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600000701_001/LOTES/LOTES.shp','parcel_none','pk7600000701101_p1_parcel','7600000701101','5c7131c32a7411cf7a27022b8ac2989e88f86254ed74b6b3b2e5cf94b44e3acb.zip',array['gid', 'CODGIS AS ref', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000701101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600000701_001/*LOTES/LOTES.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/ES/VilaVelha/_pk0007.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/ES/VilaVelha/_pk0007.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-ES-VilaVelha','/var/gits/_dg/preservCutGeo-BR2021/data/ES/VilaVelha/_pk0007.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/ES/VilaVelha/_pk0007.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/VilaVelha/_pk0007.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/VilaVelha/_pk0007.01/parcel -type f -exec chmod 664 {} \;





