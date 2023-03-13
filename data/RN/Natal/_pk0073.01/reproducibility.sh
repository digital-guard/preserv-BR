#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600007301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007301_001
mkdir -p /tmp/pg_io
wget -P /var/www/preserv.addressforall.org/download http://dl.digital-guard.org/63f265730d08e440bbfaf630a78c053968ee7ec12447b19af9554f5a8a78614f.zip
sudo chown postgres:www-data /var/www/preserv.addressforall.org/download/63f265730d08e440bbfaf630a78c053968ee7ec12447b19af9554f5a8a78614f.zip && sudo chmod 664 /var/www/preserv.addressforall.org/download/63f265730d08e440bbfaf630a78c053968ee7ec12447b19af9554f5a8a78614f.zip
psql $(pg_uri_db) -c "DROP  TABLE IF EXISTS pk7600007301101_p1_block CASCADE"
cd /tmp/sandbox/_pk7600007301_001; 7z  x -y /var/www/preserv.addressforall.org/download/63f265730d08e440bbfaf630a78c053968ee7ec12447b19af9554f5a8a78614f.zip "*QUADRAS*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31985"
cd /tmp/sandbox/_pk7600007301_001; shp2pgsql -D   -s 31985 "QUADRAS.shp" pk7600007301101_p1_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600007301_001/QUADRAS.shp','block_full','pk7600007301101_p1_block','7600007301101','63f265730d08e440bbfaf630a78c053968ee7ec12447b19af9554f5a8a78614f.zip',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
rm -f "/tmp/sandbox/_pk7600007301_001/*QUADRAS.*" || true
psql $(pg_uri_db) -c "DROP TABLE IF EXISTS pk7600007301101_p1_block CASCADE"
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RN/Natal/_pk0073.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RN/Natal/_pk0073.01/block/*.geojson
psql $(pg_uri_db) -c "SELECT ingest.publicating_geojsons('block','BR-RN-Natal','/var/gits/_dg/preservCutGeo-BR2021/data/RN/Natal/_pk0073.01/block','1',9,3);"
cd /var/gits/_dg/preserv/src; sudo bash fixaPermissoes.sh /var/gits/_dg/preservCutGeo-BR2021/data/RN/Natal/_pk0073.01/block

# layer building:
rm -rf /tmp/sandbox/_pk7600007301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007301_001
mkdir -p /tmp/pg_io
wget -P /var/www/preserv.addressforall.org/download http://dl.digital-guard.org/2a5181306cd0b82550fa9901efd9dfa8d2865a053537c5ab6b784b06edbbd568.zip
sudo chown postgres:www-data /var/www/preserv.addressforall.org/download/2a5181306cd0b82550fa9901efd9dfa8d2865a053537c5ab6b784b06edbbd568.zip && sudo chmod 664 /var/www/preserv.addressforall.org/download/2a5181306cd0b82550fa9901efd9dfa8d2865a053537c5ab6b784b06edbbd568.zip
psql $(pg_uri_db) -c "DROP  TABLE IF EXISTS pk7600007301201_p2_building CASCADE"
cd /tmp/sandbox/_pk7600007301_001; 7z  x -y /var/www/preserv.addressforall.org/download/2a5181306cd0b82550fa9901efd9dfa8d2865a053537c5ab6b784b06edbbd568.zip "*Natal_Edif*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31985"
cd /tmp/sandbox/_pk7600007301_001; shp2pgsql -D -W ISO-8859-1  -s 31985 "Natal_Edif.shp" pk7600007301201_p2_building | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw2_pk7600007301201_p2_building AS SELECT gid, Tipo || ' ' || Nome AS via, Nº AS hnum, Bairro as nsvia, CEP as postcode, geom FROM $(tabname)"
psql $(pg_uri_db) -c "SELECT ingest.any_load('shp2sql','$(sandbox)/Natal_Edif.shp','building_full','vw2_pk7600007301201_p2_building','7600007301201','2a5181306cd0b82550fa9901efd9dfa8d2865a053537c5ab6b784b06edbbd568.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw2_pk7600007301201_p2_building"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
rm -f "/tmp/sandbox/_pk7600007301_001/*Natal_Edif.*" || true
psql $(pg_uri_db) -c "DROP TABLE IF EXISTS pk7600007301201_p2_building CASCADE"
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RN/Natal/_pk0073.01/building
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RN/Natal/_pk0073.01/building/*.geojson
psql $(pg_uri_db) -c "SELECT ingest.publicating_geojsons('building','BR-RN-Natal','/var/gits/_dg/preservCutGeo-BR2021/data/RN/Natal/_pk0073.01/building','1',9,3);"
cd /var/gits/_dg/preserv/src; sudo bash fixaPermissoes.sh /var/gits/_dg/preservCutGeo-BR2021/data/RN/Natal/_pk0073.01/building





# layer nsvia:
rm -rf /tmp/sandbox/_pk7600007301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007301_001
mkdir -p /tmp/pg_io
wget -P /var/www/preserv.addressforall.org/download http://dl.digital-guard.org/2abd24ace6842e2257f9e89bc7137de259ab9a1ea6175b3486911b99fca6dfdc.zip
sudo chown postgres:www-data /var/www/preserv.addressforall.org/download/2abd24ace6842e2257f9e89bc7137de259ab9a1ea6175b3486911b99fca6dfdc.zip && sudo chmod 664 /var/www/preserv.addressforall.org/download/2abd24ace6842e2257f9e89bc7137de259ab9a1ea6175b3486911b99fca6dfdc.zip
psql $(pg_uri_db) -c "DROP  TABLE IF EXISTS pk7600007301301_p3_nsvia CASCADE"
cd /tmp/sandbox/_pk7600007301_001; 7z  x -y /var/www/preserv.addressforall.org/download/2abd24ace6842e2257f9e89bc7137de259ab9a1ea6175b3486911b99fca6dfdc.zip "*Limite_de_Bairros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31985"
cd /tmp/sandbox/_pk7600007301_001; shp2pgsql -D   -s 31985 "Limite_de_Bairros.shp" pk7600007301301_p3_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600007301_001/Limite_de_Bairros.shp','nsvia_full','pk7600007301301_p3_nsvia','7600007301301','2abd24ace6842e2257f9e89bc7137de259ab9a1ea6175b3486911b99fca6dfdc.zip',array['gid', 'BAIRRO as nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
rm -f "/tmp/sandbox/_pk7600007301_001/*Limite_de_Bairros.*" || true
psql $(pg_uri_db) -c "DROP TABLE IF EXISTS pk7600007301301_p3_nsvia CASCADE"
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RN/Natal/_pk0073.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RN/Natal/_pk0073.01/nsvia/*.geojson
psql $(pg_uri_db) -c "SELECT ingest.publicating_geojsons('nsvia','BR-RN-Natal','/var/gits/_dg/preservCutGeo-BR2021/data/RN/Natal/_pk0073.01/nsvia','1',9,3);"
cd /var/gits/_dg/preserv/src; sudo bash fixaPermissoes.sh /var/gits/_dg/preservCutGeo-BR2021/data/RN/Natal/_pk0073.01/nsvia

# layer parcel:
rm -rf /tmp/sandbox/_pk7600007301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007301_001
mkdir -p /tmp/pg_io
wget -P /var/www/preserv.addressforall.org/download http://dl.digital-guard.org/4fb50d5099297049dab0406a2ff86b78328062b2834b7a6943e256c9dd82cb31.zip
sudo chown postgres:www-data /var/www/preserv.addressforall.org/download/4fb50d5099297049dab0406a2ff86b78328062b2834b7a6943e256c9dd82cb31.zip && sudo chmod 664 /var/www/preserv.addressforall.org/download/4fb50d5099297049dab0406a2ff86b78328062b2834b7a6943e256c9dd82cb31.zip
psql $(pg_uri_db) -c "DROP  TABLE IF EXISTS pk7600007301401_p4_parcel CASCADE"
cd /tmp/sandbox/_pk7600007301_001; 7z  x -y /var/www/preserv.addressforall.org/download/4fb50d5099297049dab0406a2ff86b78328062b2834b7a6943e256c9dd82cb31.zip "*Natal_Lotes*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31985"
cd /tmp/sandbox/_pk7600007301_001; shp2pgsql -D   -s 31985 "Natal_Lotes.shp" pk7600007301401_p4_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600007301_001/Natal_Lotes.shp','parcel_none','pk7600007301401_p4_parcel','7600007301401','4fb50d5099297049dab0406a2ff86b78328062b2834b7a6943e256c9dd82cb31.zip',array['gid', 'Bairro as nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
rm -f "/tmp/sandbox/_pk7600007301_001/*Natal_Lotes.*" || true
psql $(pg_uri_db) -c "DROP TABLE IF EXISTS pk7600007301401_p4_parcel CASCADE"
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RN/Natal/_pk0073.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RN/Natal/_pk0073.01/parcel/*.geojson
psql $(pg_uri_db) -c "SELECT ingest.publicating_geojsons('parcel','BR-RN-Natal','/var/gits/_dg/preservCutGeo-BR2021/data/RN/Natal/_pk0073.01/parcel','1',9,3);"
cd /var/gits/_dg/preserv/src; sudo bash fixaPermissoes.sh /var/gits/_dg/preservCutGeo-BR2021/data/RN/Natal/_pk0073.01/parcel

# layer via:
rm -rf /tmp/sandbox/_pk7600007301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007301_001
mkdir -p /tmp/pg_io
wget -P /var/www/preserv.addressforall.org/download http://dl.digital-guard.org/3939095828b4c0ec81efbcfca8f718d33e503dd8689e06d624c7957ba7fbb918.zip
sudo chown postgres:www-data /var/www/preserv.addressforall.org/download/3939095828b4c0ec81efbcfca8f718d33e503dd8689e06d624c7957ba7fbb918.zip && sudo chmod 664 /var/www/preserv.addressforall.org/download/3939095828b4c0ec81efbcfca8f718d33e503dd8689e06d624c7957ba7fbb918.zip
psql $(pg_uri_db) -c "DROP  TABLE IF EXISTS pk7600007301501_p5_via CASCADE"
cd /tmp/sandbox/_pk7600007301_001; 7z  x -y /var/www/preserv.addressforall.org/download/3939095828b4c0ec81efbcfca8f718d33e503dd8689e06d624c7957ba7fbb918.zip "*Logradouros_2019_SIRGAS2000*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31985"
cd /tmp/sandbox/_pk7600007301_001; shp2pgsql -D   -s 31985 "Logradouros_2019_SIRGAS2000.shp" pk7600007301501_p5_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw5_pk7600007301501_p5_via AS SELECT gid, TIPO || ' ' || NOME_1 AS via, geom FROM $(tabname)"
psql $(pg_uri_db) -c "SELECT ingest.any_load('shp2sql','$(sandbox)/Logradouros_2019_SIRGAS2000.shp','via_full','vw5_pk7600007301501_p5_via','7600007301501','3939095828b4c0ec81efbcfca8f718d33e503dd8689e06d624c7957ba7fbb918.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw5_pk7600007301501_p5_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
rm -f "/tmp/sandbox/_pk7600007301_001/*Logradouros_2019_SIRGAS2000.*" || true
psql $(pg_uri_db) -c "DROP TABLE IF EXISTS pk7600007301501_p5_via CASCADE"
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RN/Natal/_pk0073.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RN/Natal/_pk0073.01/via/*.geojson
psql $(pg_uri_db) -c "SELECT ingest.publicating_geojsons('via','BR-RN-Natal','/var/gits/_dg/preservCutGeo-BR2021/data/RN/Natal/_pk0073.01/via','1',9,3);"
cd /var/gits/_dg/preserv/src; sudo bash fixaPermissoes.sh /var/gits/_dg/preservCutGeo-BR2021/data/RN/Natal/_pk0073.01/via




