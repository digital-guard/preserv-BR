#!/bin/bash








# layer nsvia:
rm -rf /tmp/sandbox/_pk7600007701_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007701_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/6d297935496b04b1d314cb05ba7fab27cf20fec02e2692a26313fdb5d65d0dae.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/6d297935496b04b1d314cb05ba7fab27cf20fec02e2692a26313fdb5d65d0dae.rar && sudo chmod 664 /var/www/dl.digital-guard.org/6d297935496b04b1d314cb05ba7fab27cf20fec02e2692a26313fdb5d65d0dae.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007701101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk7600007701_001; 7z  x -y /var/www/dl.digital-guard.org/6d297935496b04b1d314cb05ba7fab27cf20fec02e2692a26313fdb5d65d0dae.rar "*05_BAIRROS_PDC2014_LEI ATUAL*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600007701_001; shp2pgsql -D   -s 31982 "05_BAIRROS_PDC2014_LEI ATUAL.shp" pk7600007701101_p1_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600007701_001/05_BAIRROS_PDC2014_LEI ATUAL.shp','nsvia_full','pk7600007701101_p1_nsvia','7600007701101','6d297935496b04b1d314cb05ba7fab27cf20fec02e2692a26313fdb5d65d0dae.rar',array['gid', 'Text as nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007701101_p1_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600007701_001/*05_BAIRROS_PDC2014_LEI ATUAL.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SC/Chapeco/_pk0077.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SC/Chapeco/_pk0077.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "CALL ingest.ppublicating_geojsons('nsvia','BR-SC-Chapeco','/var/gits/_dg/preservCutGeo-BR2021/data/SC/Chapeco/_pk0077.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SC/Chapeco/_pk0077.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Chapeco/_pk0077.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Chapeco/_pk0077.01/nsvia -type f -exec chmod 664 {} \;


# layer via:
rm -rf /tmp/sandbox/_pk7600007701_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007701_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/6d297935496b04b1d314cb05ba7fab27cf20fec02e2692a26313fdb5d65d0dae.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/6d297935496b04b1d314cb05ba7fab27cf20fec02e2692a26313fdb5d65d0dae.rar && sudo chmod 664 /var/www/dl.digital-guard.org/6d297935496b04b1d314cb05ba7fab27cf20fec02e2692a26313fdb5d65d0dae.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007701101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600007701_001; 7z  x -y /var/www/dl.digital-guard.org/6d297935496b04b1d314cb05ba7fab27cf20fec02e2692a26313fdb5d65d0dae.rar "*03_VIAS*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600007701_001; shp2pgsql -D   -s 31982 "03_VIAS.shp" pk7600007701101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600007701101_p1_via AS SELECT gid, CLASSE || ' ' || NOME AS via, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/03_VIAS.shp','via_full','vw1_pk7600007701101_p1_via','7600007701101','6d297935496b04b1d314cb05ba7fab27cf20fec02e2692a26313fdb5d65d0dae.rar',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600007701101_p1_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007701101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600007701_001/*03_VIAS.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SC/Chapeco/_pk0077.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SC/Chapeco/_pk0077.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "CALL ingest.ppublicating_geojsons('via','BR-SC-Chapeco','/var/gits/_dg/preservCutGeo-BR2021/data/SC/Chapeco/_pk0077.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SC/Chapeco/_pk0077.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Chapeco/_pk0077.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Chapeco/_pk0077.01/via -type f -exec chmod 664 {} \;






