#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600008201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600008201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/47063f994f552e27c3b528fcc60cb03e36923b6875dd862dc54062e0ecb3bf60.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/47063f994f552e27c3b528fcc60cb03e36923b6875dd862dc54062e0ecb3bf60.zip && sudo chmod 664 /var/www/dl.digital-guard.org/47063f994f552e27c3b528fcc60cb03e36923b6875dd862dc54062e0ecb3bf60.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008201301_p3_block CASCADE"
cd /tmp/sandbox/_pk7600008201_001; 7z  x -y /var/www/dl.digital-guard.org/47063f994f552e27c3b528fcc60cb03e36923b6875dd862dc54062e0ecb3bf60.zip "*QUARTEIRAO*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31981"
FSIZE=$$(du -b '/tmp/sandbox/_pk7600008201_001/QUARTEIRAO.geojson' | cut -f 1) ; \
if [ $$FSIZE -gt 157286400 ]; then \
cp -s /var/gits/_dg/preserv/src/splitGeojson.bash /tmp/sandbox/_pk7600008201_001; \
cd /tmp/sandbox/_pk7600008201_001; bash splitGeojson.bash 'QUARTEIRAO.geojson' 20000 ; \
psql postgres://postgres@localhost/ingest1 -c "DROP TABLE IF EXISTS pk7600008201301_p3_block" ; \
psql postgres://postgres@localhost/ingest1 -c "CREATE TABLE pk7600008201301_p3_block AS SELECT * FROM geojson_readfile_features_jgeom('/tmp/sandbox/_pk7600008201_001/splited1_QUARTEIRAO.geojson',null) WHERE jgeom->'type' is not null" ; \
cd /tmp/sandbox/_pk7600008201_001; find /tmp/sandbox/_pk7600008201_001 -path "*splited*_QUARTEIRAO.geojson" ! -path "*splited1_QUARTEIRAO.geojson" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c \"INSERT INTO pk7600008201301_p3_block SELECT * FROM geojson_readfile_features_jgeom('{}',null) WHERE jgeom->'type' is not null;\"" \; ; \
else \
psql postgres://postgres@localhost/ingest1 -c "DROP TABLE IF EXISTS pk7600008201301_p3_block" ; \
psql postgres://postgres@localhost/ingest1 -c "CREATE TABLE pk7600008201301_p3_block AS SELECT * FROM geojson_readfile_features_jgeom('/tmp/sandbox/_pk7600008201_001/QUARTEIRAO.geojson',null) WHERE jgeom->'type' is not null" ; \
fi

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw3_pk7600008201301_p3_block AS SELECT row_number() OVER () as gid, jgeom AS geom \
FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('geojson2sql','/tmp/sandbox/QUARTEIRAO.geojson','block_none','vw3_pk7600008201301_p3_block','7600008201301','47063f994f552e27c3b528fcc60cb03e36923b6875dd862dc54062e0ecb3bf60.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw3_pk7600008201301_p3_block"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008201301_p3_block CASCADE"
rm -f /tmp/sandbox/_pk7600008201_001/*QUARTEIRAO.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/Bage/_pk0082.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/Bage/_pk0082.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-RS-Bage','/var/gits/_dg/preservCutGeo-BR2021/data/RS/Bage/_pk0082.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/Bage/_pk0082.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Bage/_pk0082.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Bage/_pk0082.01/block -type f -exec chmod 664 {} \;







# layer parcel:
rm -rf /tmp/sandbox/_pk7600008201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600008201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/7fc034ac5c703dcfe93567bd5196ce6eba22df7b779b15ca713b026e85f64759.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/7fc034ac5c703dcfe93567bd5196ce6eba22df7b779b15ca713b026e85f64759.zip && sudo chmod 664 /var/www/dl.digital-guard.org/7fc034ac5c703dcfe93567bd5196ce6eba22df7b779b15ca713b026e85f64759.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008201201_p2_parcel CASCADE"
cd /tmp/sandbox/_pk7600008201_001; 7z  x -y /var/www/dl.digital-guard.org/7fc034ac5c703dcfe93567bd5196ce6eba22df7b779b15ca713b026e85f64759.zip "*LOTES_URBANOS*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31981"
FSIZE=$$(du -b '/tmp/sandbox/_pk7600008201_001/LOTES_URBANOS.geojson' | cut -f 1) ; \
if [ $$FSIZE -gt 157286400 ]; then \
cp -s /var/gits/_dg/preserv/src/splitGeojson.bash /tmp/sandbox/_pk7600008201_001; \
cd /tmp/sandbox/_pk7600008201_001; bash splitGeojson.bash 'LOTES_URBANOS.geojson' 20000 ; \
psql postgres://postgres@localhost/ingest1 -c "DROP TABLE IF EXISTS pk7600008201201_p2_parcel" ; \
psql postgres://postgres@localhost/ingest1 -c "CREATE TABLE pk7600008201201_p2_parcel AS SELECT * FROM geojson_readfile_features_jgeom('/tmp/sandbox/_pk7600008201_001/splited1_LOTES_URBANOS.geojson',null) WHERE jgeom->'type' is not null" ; \
cd /tmp/sandbox/_pk7600008201_001; find /tmp/sandbox/_pk7600008201_001 -path "*splited*_LOTES_URBANOS.geojson" ! -path "*splited1_LOTES_URBANOS.geojson" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c \"INSERT INTO pk7600008201201_p2_parcel SELECT * FROM geojson_readfile_features_jgeom('{}',null) WHERE jgeom->'type' is not null;\"" \; ; \
else \
psql postgres://postgres@localhost/ingest1 -c "DROP TABLE IF EXISTS pk7600008201201_p2_parcel" ; \
psql postgres://postgres@localhost/ingest1 -c "CREATE TABLE pk7600008201201_p2_parcel AS SELECT * FROM geojson_readfile_features_jgeom('/tmp/sandbox/_pk7600008201_001/LOTES_URBANOS.geojson',null) WHERE jgeom->'type' is not null" ; \
fi

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw2_pk7600008201201_p2_parcel AS SELECT row_number() OVER () as gid, properties->'logradouro' AS via, \
jgeom AS geom \
FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('geojson2sql','/tmp/sandbox/LOTES_URBANOS.geojson','parcel_full','vw2_pk7600008201201_p2_parcel','7600008201201','7fc034ac5c703dcfe93567bd5196ce6eba22df7b779b15ca713b026e85f64759.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw2_pk7600008201201_p2_parcel"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008201201_p2_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600008201_001/*LOTES_URBANOS.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/Bage/_pk0082.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/Bage/_pk0082.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-RS-Bage','/var/gits/_dg/preservCutGeo-BR2021/data/RS/Bage/_pk0082.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/Bage/_pk0082.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Bage/_pk0082.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Bage/_pk0082.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600008201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600008201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/e77fe6f601a65e46244bc70b4f19008ad4ce3b1db36fafbaed2a248429504e81.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/e77fe6f601a65e46244bc70b4f19008ad4ce3b1db36fafbaed2a248429504e81.zip && sudo chmod 664 /var/www/dl.digital-guard.org/e77fe6f601a65e46244bc70b4f19008ad4ce3b1db36fafbaed2a248429504e81.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008201101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600008201_001; 7z  x -y /var/www/dl.digital-guard.org/e77fe6f601a65e46244bc70b4f19008ad4ce3b1db36fafbaed2a248429504e81.zip "*LOGRADOUROS-utf8*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31981"
FSIZE=$$(du -b '/tmp/sandbox/_pk7600008201_001/LOGRADOUROS-utf8.geojson' | cut -f 1) ; \
if [ $$FSIZE -gt 157286400 ]; then \
cp -s /var/gits/_dg/preserv/src/splitGeojson.bash /tmp/sandbox/_pk7600008201_001; \
cd /tmp/sandbox/_pk7600008201_001; bash splitGeojson.bash 'LOGRADOUROS-utf8.geojson' 20000 ; \
psql postgres://postgres@localhost/ingest1 -c "DROP TABLE IF EXISTS pk7600008201101_p1_via" ; \
psql postgres://postgres@localhost/ingest1 -c "CREATE TABLE pk7600008201101_p1_via AS SELECT * FROM geojson_readfile_features_jgeom('/tmp/sandbox/_pk7600008201_001/splited1_LOGRADOUROS-utf8.geojson',null) WHERE jgeom->'type' is not null" ; \
cd /tmp/sandbox/_pk7600008201_001; find /tmp/sandbox/_pk7600008201_001 -path "*splited*_LOGRADOUROS-utf8.geojson" ! -path "*splited1_LOGRADOUROS-utf8.geojson" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c \"INSERT INTO pk7600008201101_p1_via SELECT * FROM geojson_readfile_features_jgeom('{}',null) WHERE jgeom->'type' is not null;\"" \; ; \
else \
psql postgres://postgres@localhost/ingest1 -c "DROP TABLE IF EXISTS pk7600008201101_p1_via" ; \
psql postgres://postgres@localhost/ingest1 -c "CREATE TABLE pk7600008201101_p1_via AS SELECT * FROM geojson_readfile_features_jgeom('/tmp/sandbox/_pk7600008201_001/LOGRADOUROS-utf8.geojson',null) WHERE jgeom->'type' is not null" ; \
fi

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600008201101_p1_via AS SELECT row_number() OVER () as gid, properties->'logradouro' AS via, \
    jgeom AS geom \
    FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('geojson2sql','/tmp/sandbox/LOGRADOUROS-utf8.geojson','via_full','vw1_pk7600008201101_p1_via','7600008201101','e77fe6f601a65e46244bc70b4f19008ad4ce3b1db36fafbaed2a248429504e81.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600008201101_p1_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008201101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600008201_001/*LOGRADOUROS-utf8.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/Bage/_pk0082.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/Bage/_pk0082.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-RS-Bage','/var/gits/_dg/preservCutGeo-BR2021/data/RS/Bage/_pk0082.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/Bage/_pk0082.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Bage/_pk0082.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Bage/_pk0082.01/via -type f -exec chmod 664 {} \;




