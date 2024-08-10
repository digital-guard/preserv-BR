#!/bin/bash









# layer parcel:
rm -rf /tmp/sandbox/_pk7600001701_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600001701_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/d101e729d51ddfc33e4a866684074487c5a2601c7c84d4eca01ff9bbca186cda.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/d101e729d51ddfc33e4a866684074487c5a2601c7c84d4eca01ff9bbca186cda.rar && sudo chmod 664 /var/www/dl.digital-guard.org/d101e729d51ddfc33e4a866684074487c5a2601c7c84d4eca01ff9bbca186cda.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001701101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600001701_001; 7z  x -y /var/www/dl.digital-guard.org/d101e729d51ddfc33e4a866684074487c5a2601c7c84d4eca01ff9bbca186cda.rar "*lote_numero_predial*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600001701_001; shp2pgsql -D   -s 31982 "lote_numero_predial.shp" pk7600001701101_p1_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600001701_001/lote_numero_predial.shp','parcel_none','pk7600001701101_p1_parcel','7600001701101','d101e729d51ddfc33e4a866684074487c5a2601c7c84d4eca01ff9bbca186cda.rar',array['gid', 'Número AS hnum', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001701101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600001701_001/*lote_numero_predial.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/Gravatai/_pk0017.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/Gravatai/_pk0017.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-RS-Gravatai','/var/gits/_dg/preservCutGeo-BR2021/data/RS/Gravatai/_pk0017.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/Gravatai/_pk0017.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Gravatai/_pk0017.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Gravatai/_pk0017.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600001701_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600001701_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/d101e729d51ddfc33e4a866684074487c5a2601c7c84d4eca01ff9bbca186cda.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/d101e729d51ddfc33e4a866684074487c5a2601c7c84d4eca01ff9bbca186cda.rar && sudo chmod 664 /var/www/dl.digital-guard.org/d101e729d51ddfc33e4a866684074487c5a2601c7c84d4eca01ff9bbca186cda.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001701101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600001701_001; 7z  x -y /var/www/dl.digital-guard.org/d101e729d51ddfc33e4a866684074487c5a2601c7c84d4eca01ff9bbca186cda.rar "*sistema_viario*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600001701_001; shp2pgsql -D   -s 31982 "sistema_viario.shp" pk7600001701101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600001701101_p1_via AS SELECT gid, TIPO || ' ' || NOME AS via, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/sistema_viario.shp','via_full','vw1_pk7600001701101_p1_via','7600001701101','d101e729d51ddfc33e4a866684074487c5a2601c7c84d4eca01ff9bbca186cda.rar',array[]::text[],5,2)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600001701101_p1_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001701101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600001701_001/*sistema_viario.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/Gravatai/_pk0017.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/Gravatai/_pk0017.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-RS-Gravatai','/var/gits/_dg/preservCutGeo-BR2021/data/RS/Gravatai/_pk0017.01/via','2',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/Gravatai/_pk0017.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Gravatai/_pk0017.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Gravatai/_pk0017.01/via -type f -exec chmod 664 {} \;




