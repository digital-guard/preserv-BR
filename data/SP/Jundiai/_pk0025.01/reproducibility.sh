#!/bin/bash



# layer building:
rm -rf /tmp/sandbox/_pk7600002501_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002501_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/512fe4c44525a211c68415da0ab06d565a6ba3653739809d46404d6653ce5064.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/512fe4c44525a211c68415da0ab06d565a6ba3653739809d46404d6653ce5064.zip && sudo chmod 664 /var/www/dl.digital-guard.org/512fe4c44525a211c68415da0ab06d565a6ba3653739809d46404d6653ce5064.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002501301_p3_building CASCADE"
cd /tmp/sandbox/_pk7600002501_001; 7z  x -y /var/www/dl.digital-guard.org/512fe4c44525a211c68415da0ab06d565a6ba3653739809d46404d6653ce5064.zip "*edificacoes*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600002501_001; shp2pgsql -D   -s 31983 "edificacoes.shp" pk7600002501301_p3_building | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw3_pk7600002501301_p3_building AS SELECT gid, 'yes' AS building, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/edificacoes.shp','building_none','vw3_pk7600002501301_p3_building','7600002501301','512fe4c44525a211c68415da0ab06d565a6ba3653739809d46404d6653ce5064.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw3_pk7600002501301_p3_building"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002501301_p3_building CASCADE"
rm -f /tmp/sandbox/_pk7600002501_001/*edificacoes.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/building
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/building/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('building','BR-SP-Jundiai','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/building','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/building
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/building -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/building -type f -exec chmod 664 {} \;




# layer geoaddress:
rm -rf /tmp/sandbox/_pk7600002501_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002501_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/c26c149b65a42e9de131145b8db24aed006f37c5f44c625c835df2fc359f4763.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/c26c149b65a42e9de131145b8db24aed006f37c5f44c625c835df2fc359f4763.zip && sudo chmod 664 /var/www/dl.digital-guard.org/c26c149b65a42e9de131145b8db24aed006f37c5f44c625c835df2fc359f4763.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002501501_p5_geoaddress CASCADE"
cd /tmp/sandbox/_pk7600002501_001; 7z  x -y /var/www/dl.digital-guard.org/c26c149b65a42e9de131145b8db24aed006f37c5f44c625c835df2fc359f4763.zip "*numerosprediais*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600002501_001; shp2pgsql -D -W ISO-8859-1  -s 31983 "numerosprediais.shp" pk7600002501501_p5_geoaddress | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw5_pk7600002501501_p5_geoaddress AS SELECT row_number() OVER () AS gid, numero_int AS hnum, REGEXP_REPLACE(replace(logradouro,'.', ' '), '[[:space:]]+', ' ','g') AS via, bairro AS nsvia, complement AS sup, loteamento, cep AS postcode, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/numerosprediais.shp','geoaddress_full','vw5_pk7600002501501_p5_geoaddress','7600002501501','c26c149b65a42e9de131145b8db24aed006f37c5f44c625c835df2fc359f4763.zip',array[]::text[],1,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw5_pk7600002501501_p5_geoaddress"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002501501_p5_geoaddress CASCADE"
rm -f /tmp/sandbox/_pk7600002501_001/*numerosprediais.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','BR-SP-Jundiai','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/geoaddress','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/geoaddress -type f -exec chmod 664 {} \;

# layer nsvia:
rm -rf /tmp/sandbox/_pk7600002501_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002501_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/7995d41f628e31599f80b367650d363f47e75e1515be9fefabefca91189608a5.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/7995d41f628e31599f80b367650d363f47e75e1515be9fefabefca91189608a5.zip && sudo chmod 664 /var/www/dl.digital-guard.org/7995d41f628e31599f80b367650d363f47e75e1515be9fefabefca91189608a5.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002501401_p4_nsvia CASCADE"
cd /tmp/sandbox/_pk7600002501_001; 7z  x -y /var/www/dl.digital-guard.org/7995d41f628e31599f80b367650d363f47e75e1515be9fefabefca91189608a5.zip "*v_bairros_populacao*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600002501_001; shp2pgsql -D -W ISO-8859-1  -s 31983 "v_bairros_populacao.shp" pk7600002501401_p4_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600002501_001/v_bairros_populacao.shp','nsvia_full','pk7600002501401_p4_nsvia','7600002501401','7995d41f628e31599f80b367650d363f47e75e1515be9fefabefca91189608a5.zip',array['gid', 'nmbairro as nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002501401_p4_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600002501_001/*v_bairros_populacao.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-SP-Jundiai','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600002501_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002501_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/4c4a1565e1f7d5675ff2d546d0e6a85acd7bbaa018503601dd07e1be80dee130.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/4c4a1565e1f7d5675ff2d546d0e6a85acd7bbaa018503601dd07e1be80dee130.zip && sudo chmod 664 /var/www/dl.digital-guard.org/4c4a1565e1f7d5675ff2d546d0e6a85acd7bbaa018503601dd07e1be80dee130.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002501101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600002501_001; 7z  x -y /var/www/dl.digital-guard.org/4c4a1565e1f7d5675ff2d546d0e6a85acd7bbaa018503601dd07e1be80dee130.zip "*lotes_jund*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600002501_001; shp2pgsql -D   -s 31983 "lotes_jund.shp" pk7600002501101_p1_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600002501_001/lotes_jund.shp','parcel_none','pk7600002501101_p1_parcel','7600002501101','4c4a1565e1f7d5675ff2d546d0e6a85acd7bbaa018503601dd07e1be80dee130.zip',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002501101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600002501_001/*lotes_jund.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-SP-Jundiai','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600002501_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002501_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/062c98c3fc074c76a5ff8d1bb3ad97b120d4a60d2e75c835fd6ff096f466da58.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/062c98c3fc074c76a5ff8d1bb3ad97b120d4a60d2e75c835fd6ff096f466da58.zip && sudo chmod 664 /var/www/dl.digital-guard.org/062c98c3fc074c76a5ff8d1bb3ad97b120d4a60d2e75c835fd6ff096f466da58.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002501201_p2_via CASCADE"
cd /tmp/sandbox/_pk7600002501_001; 7z  x -y /var/www/dl.digital-guard.org/062c98c3fc074c76a5ff8d1bb3ad97b120d4a60d2e75c835fd6ff096f466da58.zip "*v_logr_ortofoto-utf8*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600002501_001; shp2pgsql -D   -s 31983 "v_logr_ortofoto-utf8.shp" pk7600002501201_p2_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw2_pk7600002501201_p2_via AS SELECT row_number() OVER () AS gid, REGEXP_REPLACE(logrtotal, '[[:space:]]+', ' ','g') AS via, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/v_logr_ortofoto-utf8.shp','via_full','vw2_pk7600002501201_p2_via','7600002501201','062c98c3fc074c76a5ff8d1bb3ad97b120d4a60d2e75c835fd6ff096f466da58.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw2_pk7600002501201_p2_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002501201_p2_via CASCADE"
rm -f /tmp/sandbox/_pk7600002501_001/*v_logr_ortofoto-utf8.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-SP-Jundiai','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jundiai/_pk0025.01/via -type f -exec chmod 664 {} \;




