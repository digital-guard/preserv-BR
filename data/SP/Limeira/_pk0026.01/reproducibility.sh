#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600002601_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002601_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/529f86b71a936bfdbca3d633b80912f496b9c94a2505ef816e406e2362b631c4.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/529f86b71a936bfdbca3d633b80912f496b9c94a2505ef816e406e2362b631c4.zip && sudo chmod 664 /var/www/dl.digital-guard.org/529f86b71a936bfdbca3d633b80912f496b9c94a2505ef816e406e2362b631c4.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002601101_p1_block CASCADE"
cd /tmp/sandbox/_pk7600002601_001; 7z  x -y /var/www/dl.digital-guard.org/529f86b71a936bfdbca3d633b80912f496b9c94a2505ef816e406e2362b631c4.zip "*quadras*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600002601_001; shp2pgsql -D   -s 31983 "quadras.shp" pk7600002601101_p1_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600002601_001/quadras.shp','block_full','pk7600002601101_p1_block','7600002601101','529f86b71a936bfdbca3d633b80912f496b9c94a2505ef816e406e2362b631c4.zip',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002601101_p1_block CASCADE"
rm -f /tmp/sandbox/_pk7600002601_001/*quadras.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-SP-Limeira','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/block -type f -exec chmod 664 {} \;






# layer nsvia:
rm -rf /tmp/sandbox/_pk7600002601_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002601_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/529f86b71a936bfdbca3d633b80912f496b9c94a2505ef816e406e2362b631c4.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/529f86b71a936bfdbca3d633b80912f496b9c94a2505ef816e406e2362b631c4.zip && sudo chmod 664 /var/www/dl.digital-guard.org/529f86b71a936bfdbca3d633b80912f496b9c94a2505ef816e406e2362b631c4.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002601101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk7600002601_001; 7z  x -y /var/www/dl.digital-guard.org/529f86b71a936bfdbca3d633b80912f496b9c94a2505ef816e406e2362b631c4.zip "*loteamentos*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600002601_001; shp2pgsql -D   -s 31983 "loteamentos.shp" pk7600002601101_p1_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600002601101_p1_nsvia AS SELECT gid, Tipo || ' ' || Nome AS nsvia, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/loteamentos.shp','nsvia_full','vw1_pk7600002601101_p1_nsvia','7600002601101','529f86b71a936bfdbca3d633b80912f496b9c94a2505ef816e406e2362b631c4.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600002601101_p1_nsvia"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002601101_p1_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600002601_001/*loteamentos.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-SP-Limeira','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600002601_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002601_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/529f86b71a936bfdbca3d633b80912f496b9c94a2505ef816e406e2362b631c4.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/529f86b71a936bfdbca3d633b80912f496b9c94a2505ef816e406e2362b631c4.zip && sudo chmod 664 /var/www/dl.digital-guard.org/529f86b71a936bfdbca3d633b80912f496b9c94a2505ef816e406e2362b631c4.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002601101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600002601_001; 7z  x -y /var/www/dl.digital-guard.org/529f86b71a936bfdbca3d633b80912f496b9c94a2505ef816e406e2362b631c4.zip "*lotes*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600002601_001; shp2pgsql -D   -s 31983 "lotes.shp" pk7600002601101_p1_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600002601_001/lotes.shp','parcel_full','pk7600002601101_p1_parcel','7600002601101','529f86b71a936bfdbca3d633b80912f496b9c94a2505ef816e406e2362b631c4.zip',array['gid', 'ENDER_IMOV as via', 'NRO_IMOV as hnum', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002601101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600002601_001/*lotes.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-SP-Limeira','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600002601_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002601_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/529f86b71a936bfdbca3d633b80912f496b9c94a2505ef816e406e2362b631c4.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/529f86b71a936bfdbca3d633b80912f496b9c94a2505ef816e406e2362b631c4.zip && sudo chmod 664 /var/www/dl.digital-guard.org/529f86b71a936bfdbca3d633b80912f496b9c94a2505ef816e406e2362b631c4.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002601101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600002601_001; 7z  x -y /var/www/dl.digital-guard.org/529f86b71a936bfdbca3d633b80912f496b9c94a2505ef816e406e2362b631c4.zip "*eixo*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600002601_001; shp2pgsql -D   -s 31983 "eixo.shp" pk7600002601101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600002601101_p1_via AS SELECT gid, tipo || ' ' || compl_1 || ' ' || compl_2 || ' ' || nome_1 AS via, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/eixo.shp','via_full','vw1_pk7600002601101_p1_via','7600002601101','529f86b71a936bfdbca3d633b80912f496b9c94a2505ef816e406e2362b631c4.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600002601101_p1_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002601101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600002601_001/*eixo.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-SP-Limeira','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Limeira/_pk0026.01/via -type f -exec chmod 664 {} \;




