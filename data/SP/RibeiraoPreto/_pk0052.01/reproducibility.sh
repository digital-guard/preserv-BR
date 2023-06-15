#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600005201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600005201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/6cd0d4b475e61b8cbd078787ea8b38ebdd051a1def026ca476d4a83d40354738.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/6cd0d4b475e61b8cbd078787ea8b38ebdd051a1def026ca476d4a83d40354738.zip && sudo chmod 664 /var/www/dl.digital-guard.org/6cd0d4b475e61b8cbd078787ea8b38ebdd051a1def026ca476d4a83d40354738.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005201101_p1_block CASCADE"
cd /tmp/sandbox/_pk7600005201_001; 7z  x -y /var/www/dl.digital-guard.org/6cd0d4b475e61b8cbd078787ea8b38ebdd051a1def026ca476d4a83d40354738.zip "*quadras*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600005201_001; shp2pgsql -D   -s 31983 "quadras.shp" pk7600005201101_p1_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600005201_001/quadras.shp','block_full','pk7600005201101_p1_block','7600005201101','6cd0d4b475e61b8cbd078787ea8b38ebdd051a1def026ca476d4a83d40354738.zip',array['gid', 'QUADRA', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005201101_p1_block CASCADE"
rm -f /tmp/sandbox/_pk7600005201_001/*quadras.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/RibeiraoPreto/_pk0052.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/RibeiraoPreto/_pk0052.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-SP-RibeiraoPreto','/var/gits/_dg/preservCutGeo-BR2021/data/SP/RibeiraoPreto/_pk0052.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/RibeiraoPreto/_pk0052.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/RibeiraoPreto/_pk0052.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/RibeiraoPreto/_pk0052.01/block -type f -exec chmod 664 {} \;


# layer cadparcel:
rm -rf /tmp/sandbox/_pk7600005201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600005201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/6cd0d4b475e61b8cbd078787ea8b38ebdd051a1def026ca476d4a83d40354738.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/6cd0d4b475e61b8cbd078787ea8b38ebdd051a1def026ca476d4a83d40354738.zip && sudo chmod 664 /var/www/dl.digital-guard.org/6cd0d4b475e61b8cbd078787ea8b38ebdd051a1def026ca476d4a83d40354738.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005201101_p1_cadparcel CASCADE"
cd /tmp/sandbox/_pk7600005201_001; 7z  x -y /var/www/dl.digital-guard.org/6cd0d4b475e61b8cbd078787ea8b38ebdd051a1def026ca476d4a83d40354738.zip "*lograd*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600005201_001; shp2pgsql -D   -s 31983 "lograd.shp" pk7600005201101_p1_cadparcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600005201101_p1_cadparcel AS SELECT DISTINCT NOME_LOGR AS via, COD_DV_LOG AS cod_dv_log FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/lograd.shp','cadparcel_cmpl','vw1_pk7600005201101_p1_cadparcel','7600005201101','6cd0d4b475e61b8cbd078787ea8b38ebdd051a1def026ca476d4a83d40354738.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600005201101_p1_cadparcel"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.cadastral_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005201101_p1_cadparcel CASCADE"
rm -f /tmp/sandbox/_pk7600005201_001/*lograd.* || true





# layer parcel:
rm -rf /tmp/sandbox/_pk7600005201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600005201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/6cd0d4b475e61b8cbd078787ea8b38ebdd051a1def026ca476d4a83d40354738.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/6cd0d4b475e61b8cbd078787ea8b38ebdd051a1def026ca476d4a83d40354738.zip && sudo chmod 664 /var/www/dl.digital-guard.org/6cd0d4b475e61b8cbd078787ea8b38ebdd051a1def026ca476d4a83d40354738.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005201101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600005201_001; 7z  x -y /var/www/dl.digital-guard.org/6cd0d4b475e61b8cbd078787ea8b38ebdd051a1def026ca476d4a83d40354738.zip "*lotes*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600005201_001; shp2pgsql -D   -s 31983 "lotes.shp" pk7600005201101_p1_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600005201_001/lotes.shp','parcel_ext','pk7600005201101_p1_parcel','7600005201101','6cd0d4b475e61b8cbd078787ea8b38ebdd051a1def026ca476d4a83d40354738.zip',array['gid', 'NRO_IMOV AS hnum', 'COD_DV_LOG AS cod_dv_log', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005201101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600005201_001/*lotes.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/RibeiraoPreto/_pk0052.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/RibeiraoPreto/_pk0052.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-SP-RibeiraoPreto','/var/gits/_dg/preservCutGeo-BR2021/data/SP/RibeiraoPreto/_pk0052.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/RibeiraoPreto/_pk0052.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/RibeiraoPreto/_pk0052.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/RibeiraoPreto/_pk0052.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600005201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600005201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/6cd0d4b475e61b8cbd078787ea8b38ebdd051a1def026ca476d4a83d40354738.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/6cd0d4b475e61b8cbd078787ea8b38ebdd051a1def026ca476d4a83d40354738.zip && sudo chmod 664 /var/www/dl.digital-guard.org/6cd0d4b475e61b8cbd078787ea8b38ebdd051a1def026ca476d4a83d40354738.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005201101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600005201_001; 7z  x -y /var/www/dl.digital-guard.org/6cd0d4b475e61b8cbd078787ea8b38ebdd051a1def026ca476d4a83d40354738.zip "*lograd*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600005201_001; shp2pgsql -D   -s 31983 "lograd.shp" pk7600005201101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600005201_001/lograd.shp','via_full','pk7600005201101_p1_via','7600005201101','6cd0d4b475e61b8cbd078787ea8b38ebdd051a1def026ca476d4a83d40354738.zip',array['gid', 'NOME_LOGR AS via', 'COD_DV_LOG AS cod_dv_log', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005201101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600005201_001/*lograd.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/RibeiraoPreto/_pk0052.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/RibeiraoPreto/_pk0052.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-SP-RibeiraoPreto','/var/gits/_dg/preservCutGeo-BR2021/data/SP/RibeiraoPreto/_pk0052.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/RibeiraoPreto/_pk0052.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/RibeiraoPreto/_pk0052.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/RibeiraoPreto/_pk0052.01/via -type f -exec chmod 664 {} \;



# layer joining



psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.join('parcel_ext','cod_dv_log','6cd0d4b475e61b8cbd078787ea8b38ebdd051a1def026ca476d4a83d40354738.zip','cadparcel_cmpl','cod_dv_log','6cd0d4b475e61b8cbd078787ea8b38ebdd051a1def026ca476d4a83d40354738.zip')"

