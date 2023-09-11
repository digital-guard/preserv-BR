#!/bin/bash







# layer geoaddress:
rm -rf /tmp/sandbox/_pk7600007502_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007502_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/c252e8028e7f3abc353c7aebdfd5929913959b7931b05a4b18187c3a954b1296.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/c252e8028e7f3abc353c7aebdfd5929913959b7931b05a4b18187c3a954b1296.zip && sudo chmod 664 /var/www/dl.digital-guard.org/c252e8028e7f3abc353c7aebdfd5929913959b7931b05a4b18187c3a954b1296.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007502101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk7600007502_001; 7z  x -y /var/www/dl.digital-guard.org/c252e8028e7f3abc353c7aebdfd5929913959b7931b05a4b18187c3a954b1296.zip "*no.porta-brusque-maio2023*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
FSIZE=$$(du -b '/tmp/sandbox/_pk7600007502_001/no.porta-brusque-maio2023.geojson' | cut -f 1) ; \
if [ $$FSIZE -gt 157286400 ]; then \
cp -s /var/gits/_dg/preserv/src/splitGeojson.bash /tmp/sandbox/_pk7600007502_001; \
cd /tmp/sandbox/_pk7600007502_001; bash splitGeojson.bash 'no.porta-brusque-maio2023.geojson' 20000 ; \
psql postgres://postgres@localhost/ingest1 -c "DROP TABLE IF EXISTS pk7600007502101_p1_geoaddress" ; \
psql postgres://postgres@localhost/ingest1 -c "CREATE TABLE pk7600007502101_p1_geoaddress AS SELECT * FROM geojson_readfile_features_jgeom('/tmp/sandbox/_pk7600007502_001/splited1_no.porta-brusque-maio2023.geojson',null) WHERE jgeom->'type' is not null" ; \
cd /tmp/sandbox/_pk7600007502_001; find /tmp/sandbox/_pk7600007502_001 -path "*splited*_no.porta-brusque-maio2023.geojson" ! -path "*splited1_no.porta-brusque-maio2023.geojson" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c \"INSERT INTO pk7600007502101_p1_geoaddress SELECT * FROM geojson_readfile_features_jgeom('{}',null) WHERE jgeom->'type' is not null;\"" \; ; \
else \
psql postgres://postgres@localhost/ingest1 -c "DROP TABLE IF EXISTS pk7600007502101_p1_geoaddress" ; \
psql postgres://postgres@localhost/ingest1 -c "CREATE TABLE pk7600007502101_p1_geoaddress AS SELECT * FROM geojson_readfile_features_jgeom('/tmp/sandbox/_pk7600007502_001/no.porta-brusque-maio2023.geojson',null) WHERE jgeom->'type' is not null" ; \
fi

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600007502101_p1_geoaddress AS SELECT row_number() OVER () as gid, properties->'nr_porta' as hnum, \
jgeom AS geom \
FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('geojson2sql','/tmp/sandbox/no.porta-brusque-maio2023.geojson','geoaddress_full','vw1_pk7600007502101_p1_geoaddress','7600007502101','c252e8028e7f3abc353c7aebdfd5929913959b7931b05a4b18187c3a954b1296.zip',array[]::text[],1,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600007502101_p1_geoaddress"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007502101_p1_geoaddress CASCADE"
rm -f /tmp/sandbox/_pk7600007502_001/*no.porta-brusque-maio2023.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SC/Brusque/_pk0075.02/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SC/Brusque/_pk0075.02/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','BR-SC-Brusque','/var/gits/_dg/preservCutGeo-BR2021/data/SC/Brusque/_pk0075.02/geoaddress','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SC/Brusque/_pk0075.02/geoaddress
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Brusque/_pk0075.02/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Brusque/_pk0075.02/geoaddress -type f -exec chmod 664 {} \;



# layer via:
rm -rf /tmp/sandbox/_pk7600007502_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007502_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/c252e8028e7f3abc353c7aebdfd5929913959b7931b05a4b18187c3a954b1296.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/c252e8028e7f3abc353c7aebdfd5929913959b7931b05a4b18187c3a954b1296.zip && sudo chmod 664 /var/www/dl.digital-guard.org/c252e8028e7f3abc353c7aebdfd5929913959b7931b05a4b18187c3a954b1296.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007502101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600007502_001; 7z  x -y /var/www/dl.digital-guard.org/c252e8028e7f3abc353c7aebdfd5929913959b7931b05a4b18187c3a954b1296.zip "*eixo_logradouro-brusque-maio2023*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
FSIZE=$$(du -b '/tmp/sandbox/_pk7600007502_001/eixo_logradouro-brusque-maio2023.geojson' | cut -f 1) ; \
if [ $$FSIZE -gt 157286400 ]; then \
cp -s /var/gits/_dg/preserv/src/splitGeojson.bash /tmp/sandbox/_pk7600007502_001; \
cd /tmp/sandbox/_pk7600007502_001; bash splitGeojson.bash 'eixo_logradouro-brusque-maio2023.geojson' 20000 ; \
psql postgres://postgres@localhost/ingest1 -c "DROP TABLE IF EXISTS pk7600007502101_p1_via" ; \
psql postgres://postgres@localhost/ingest1 -c "CREATE TABLE pk7600007502101_p1_via AS SELECT * FROM geojson_readfile_features_jgeom('/tmp/sandbox/_pk7600007502_001/splited1_eixo_logradouro-brusque-maio2023.geojson',null) WHERE jgeom->'type' is not null" ; \
cd /tmp/sandbox/_pk7600007502_001; find /tmp/sandbox/_pk7600007502_001 -path "*splited*_eixo_logradouro-brusque-maio2023.geojson" ! -path "*splited1_eixo_logradouro-brusque-maio2023.geojson" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c \"INSERT INTO pk7600007502101_p1_via SELECT * FROM geojson_readfile_features_jgeom('{}',null) WHERE jgeom->'type' is not null;\"" \; ; \
else \
psql postgres://postgres@localhost/ingest1 -c "DROP TABLE IF EXISTS pk7600007502101_p1_via" ; \
psql postgres://postgres@localhost/ingest1 -c "CREATE TABLE pk7600007502101_p1_via AS SELECT * FROM geojson_readfile_features_jgeom('/tmp/sandbox/_pk7600007502_001/eixo_logradouro-brusque-maio2023.geojson',null) WHERE jgeom->'type' is not null" ; \
fi

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600007502101_p1_via AS SELECT  row_number() OVER () as gid, \
CONCAT(properties->'tipo_logr', ' ', properties->'logr') AS via,  \
properties->'categ_via' as categ_via, \
jgeom AS geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('geojson2sql','/tmp/sandbox/eixo_logradouro-brusque-maio2023.geojson','via_full','vw1_pk7600007502101_p1_via','7600007502101','c252e8028e7f3abc353c7aebdfd5929913959b7931b05a4b18187c3a954b1296.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600007502101_p1_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007502101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600007502_001/*eixo_logradouro-brusque-maio2023.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SC/Brusque/_pk0075.02/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SC/Brusque/_pk0075.02/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-SC-Brusque','/var/gits/_dg/preservCutGeo-BR2021/data/SC/Brusque/_pk0075.02/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SC/Brusque/_pk0075.02/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Brusque/_pk0075.02/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Brusque/_pk0075.02/via -type f -exec chmod 664 {} \;




