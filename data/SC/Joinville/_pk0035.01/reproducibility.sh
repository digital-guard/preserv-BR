#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600003501_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600003501_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/3d4a6f528249d062a0bcfb18aa6c115828bb651a164617489c14017b6433c02a.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/3d4a6f528249d062a0bcfb18aa6c115828bb651a164617489c14017b6433c02a.zip && sudo chmod 664 /var/www/dl.digital-guard.org/3d4a6f528249d062a0bcfb18aa6c115828bb651a164617489c14017b6433c02a.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003501101_p1_block CASCADE"
cd /tmp/sandbox/_pk7600003501_001; 7z  x -y /var/www/dl.digital-guard.org/3d4a6f528249d062a0bcfb18aa6c115828bb651a164617489c14017b6433c02a.zip "*Malha Fundi ria/Quadras*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600003501_001; shp2pgsql -D   -s 31982 "Malha Fundi ria/Quadras.shp" pk7600003501101_p1_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600003501_001/Malha Fundi ria/Quadras.shp','block_none','pk7600003501101_p1_block','7600003501101','3d4a6f528249d062a0bcfb18aa6c115828bb651a164617489c14017b6433c02a.zip',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003501101_p1_block CASCADE"
rm -f /tmp/sandbox/_pk7600003501_001/*Malha Fundi ria/Quadras.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SC/Joinville/_pk0035.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SC/Joinville/_pk0035.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-SC-Joinville','/var/gits/_dg/preservCutGeo-BR2021/data/SC/Joinville/_pk0035.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SC/Joinville/_pk0035.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Joinville/_pk0035.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Joinville/_pk0035.01/block -type f -exec chmod 664 {} \;







# layer parcel:
rm -rf /tmp/sandbox/_pk7600003501_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600003501_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/3d4a6f528249d062a0bcfb18aa6c115828bb651a164617489c14017b6433c02a.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/3d4a6f528249d062a0bcfb18aa6c115828bb651a164617489c14017b6433c02a.zip && sudo chmod 664 /var/www/dl.digital-guard.org/3d4a6f528249d062a0bcfb18aa6c115828bb651a164617489c14017b6433c02a.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003501101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600003501_001; 7z  x -y /var/www/dl.digital-guard.org/3d4a6f528249d062a0bcfb18aa6c115828bb651a164617489c14017b6433c02a.zip '*Malha Fundi ria/lotes2020_uso*' '*Malha Fundi ria/Lotes_rurais*' ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600003501_001; find /tmp/sandbox/_pk7600003501_001 -path "*Malha Fundi ria/lotes2020_uso*.shp" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c 'DROP TABLE IF EXISTS pk7600003501101_p1_parcel'; shp2pgsql -D   -s 31982 '{}' pk7600003501101_p1_parcel | psql -q postgres://postgres@localhost/ingest1; psql postgres://postgres@localhost/ingest1 -c \"SELECT ingest.any_load('shp2sql','$$(find /tmp/sandbox/_pk7600003501_001 -path "*Malha Fundi ria/lotes2020_uso*.shp" | head -n 1)','parcel_full','pk7600003501101_p1_parcel','7600003501101','3d4a6f528249d062a0bcfb18aa6c115828bb651a164617489c14017b6433c02a.zip',array['gid', '___logradour AS via', '___numero_25 AS hnum', '___bairro_28 AS nsvia', 'uso', 'geom'],5,1,True)\"; chmod -R a+rx . 2> /dev/null" \;
cd /tmp/sandbox/_pk7600003501_001; find /tmp/sandbox/_pk7600003501_001 -path "*Malha Fundi ria/Lotes_rurais*.shp" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c 'DROP TABLE IF EXISTS pk7600003501101_p1_parcel'; shp2pgsql -D   -s 31982 '{}' pk7600003501101_p1_parcel | psql -q postgres://postgres@localhost/ingest1; psql postgres://postgres@localhost/ingest1 -c \"SELECT ingest.any_load('shp2sql','$$(find /tmp/sandbox/_pk7600003501_001 -path "*Malha Fundi ria/lotes2020_uso*.shp" | head -n 1)','parcel_full','pk7600003501101_p1_parcel','7600003501101','3d4a6f528249d062a0bcfb18aa6c115828bb651a164617489c14017b6433c02a.zip',array['gid', 'iq_lote', 'geom'],5,1,False)\"; chmod -R a+rx . 2> /dev/null" \;
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load_assign( '$$(find /tmp/sandbox/_pk7600003501_001 -path "*Malha Fundi ria/lotes2020_uso*.shp" | head -n 1)','parcel_full','7600003501101' )"
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003501101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600003501_001/*Malha Fundi ria/lotes2020_uso.* || true
rm -f /tmp/sandbox/_pk7600003501_001/*Malha Fundi ria/Lotes_rurais.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SC/Joinville/_pk0035.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SC/Joinville/_pk0035.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-SC-Joinville','/var/gits/_dg/preservCutGeo-BR2021/data/SC/Joinville/_pk0035.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SC/Joinville/_pk0035.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Joinville/_pk0035.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Joinville/_pk0035.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600003501_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600003501_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/207c82a3f2fa79f943c7b393b0e4fe636ff60305302f9c64c8364851fc6bf6c2.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/207c82a3f2fa79f943c7b393b0e4fe636ff60305302f9c64c8364851fc6bf6c2.zip && sudo chmod 664 /var/www/dl.digital-guard.org/207c82a3f2fa79f943c7b393b0e4fe636ff60305302f9c64c8364851fc6bf6c2.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003501201_p2_via CASCADE"
cd /tmp/sandbox/_pk7600003501_001; 7z  x -y /var/www/dl.digital-guard.org/207c82a3f2fa79f943c7b393b0e4fe636ff60305302f9c64c8364851fc6bf6c2.zip "*Malha Vi ria/logradouros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600003501_001; shp2pgsql -D   -s 31982 "Malha Vi ria/logradouros.shp" pk7600003501201_p2_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600003501_001/Malha Vi ria/logradouros.shp','via_full','pk7600003501201_p2_via','7600003501201','207c82a3f2fa79f943c7b393b0e4fe636ff60305302f9c64c8364851fc6bf6c2.zip',array['gid', 'nomelog AS via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003501201_p2_via CASCADE"
rm -f /tmp/sandbox/_pk7600003501_001/*Malha Vi ria/logradouros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SC/Joinville/_pk0035.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SC/Joinville/_pk0035.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-SC-Joinville','/var/gits/_dg/preservCutGeo-BR2021/data/SC/Joinville/_pk0035.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SC/Joinville/_pk0035.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Joinville/_pk0035.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Joinville/_pk0035.01/via -type f -exec chmod 664 {} \;




