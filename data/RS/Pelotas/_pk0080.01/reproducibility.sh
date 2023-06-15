#!/bin/bash







# layer geoaddress:
rm -rf /tmp/sandbox/_pk7600008001_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600008001_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/3c69a4bf2fa9cce1b701968f6c970230e51ee2a656f7168f384f5066a05eaba2.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/3c69a4bf2fa9cce1b701968f6c970230e51ee2a656f7168f384f5066a05eaba2.zip && sudo chmod 664 /var/www/dl.digital-guard.org/3c69a4bf2fa9cce1b701968f6c970230e51ee2a656f7168f384f5066a05eaba2.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008001101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk7600008001_001; 7z  x -y /var/www/dl.digital-guard.org/3c69a4bf2fa9cce1b701968f6c970230e51ee2a656f7168f384f5066a05eaba2.zip "*DADOS PELOTAS/numeracao_cadastral*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600008001_001; shp2pgsql -D   -s 31982 "DADOS PELOTAS/numeracao_cadastral.shp" pk7600008001101_p1_geoaddress | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600008001_001/DADOS PELOTAS/numeracao_cadastral.shp','geoaddress_full','pk7600008001101_p1_geoaddress','7600008001101','3c69a4bf2fa9cce1b701968f6c970230e51ee2a656f7168f384f5066a05eaba2.zip',array['gid', 'text AS hnum', 'geom'],1,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008001101_p1_geoaddress CASCADE"
rm -f /tmp/sandbox/_pk7600008001_001/*DADOS PELOTAS/numeracao_cadastral.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/Pelotas/_pk0080.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/Pelotas/_pk0080.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','BR-RS-Pelotas','/var/gits/_dg/preservCutGeo-BR2021/data/RS/Pelotas/_pk0080.01/geoaddress','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/Pelotas/_pk0080.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Pelotas/_pk0080.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Pelotas/_pk0080.01/geoaddress -type f -exec chmod 664 {} \;


# layer parcel:
rm -rf /tmp/sandbox/_pk7600008001_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600008001_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/3c69a4bf2fa9cce1b701968f6c970230e51ee2a656f7168f384f5066a05eaba2.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/3c69a4bf2fa9cce1b701968f6c970230e51ee2a656f7168f384f5066a05eaba2.zip && sudo chmod 664 /var/www/dl.digital-guard.org/3c69a4bf2fa9cce1b701968f6c970230e51ee2a656f7168f384f5066a05eaba2.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008001101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600008001_001; 7z  x -y /var/www/dl.digital-guard.org/3c69a4bf2fa9cce1b701968f6c970230e51ee2a656f7168f384f5066a05eaba2.zip "*DADOS PELOTAS/pelotas_lotes_cadastro*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600008001_001; shp2pgsql -D   -s 31982 "DADOS PELOTAS/pelotas_lotes_cadastro.shp" pk7600008001101_p1_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600008001_001/DADOS PELOTAS/pelotas_lotes_cadastro.shp','parcel_none','pk7600008001101_p1_parcel','7600008001101','3c69a4bf2fa9cce1b701968f6c970230e51ee2a656f7168f384f5066a05eaba2.zip',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008001101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600008001_001/*DADOS PELOTAS/pelotas_lotes_cadastro.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/Pelotas/_pk0080.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/Pelotas/_pk0080.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-RS-Pelotas','/var/gits/_dg/preservCutGeo-BR2021/data/RS/Pelotas/_pk0080.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/Pelotas/_pk0080.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Pelotas/_pk0080.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Pelotas/_pk0080.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600008001_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600008001_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/3c69a4bf2fa9cce1b701968f6c970230e51ee2a656f7168f384f5066a05eaba2.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/3c69a4bf2fa9cce1b701968f6c970230e51ee2a656f7168f384f5066a05eaba2.zip && sudo chmod 664 /var/www/dl.digital-guard.org/3c69a4bf2fa9cce1b701968f6c970230e51ee2a656f7168f384f5066a05eaba2.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008001101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600008001_001; 7z  x -y /var/www/dl.digital-guard.org/3c69a4bf2fa9cce1b701968f6c970230e51ee2a656f7168f384f5066a05eaba2.zip "*DADOS PELOTAS/pelotas_eixos_viarios*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600008001_001; shp2pgsql -D   -s 31982 "DADOS PELOTAS/pelotas_eixos_viarios.shp" pk7600008001101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600008001_001/DADOS PELOTAS/pelotas_eixos_viarios.shp','via_full','pk7600008001101_p1_via','7600008001101','3c69a4bf2fa9cce1b701968f6c970230e51ee2a656f7168f384f5066a05eaba2.zip',array['gid', 'nome_map AS via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008001101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600008001_001/*DADOS PELOTAS/pelotas_eixos_viarios.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/Pelotas/_pk0080.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/Pelotas/_pk0080.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-RS-Pelotas','/var/gits/_dg/preservCutGeo-BR2021/data/RS/Pelotas/_pk0080.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/Pelotas/_pk0080.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Pelotas/_pk0080.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Pelotas/_pk0080.01/via -type f -exec chmod 664 {} \;




