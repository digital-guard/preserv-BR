#!/bin/bash








# layer nsvia:
rm -rf /tmp/sandbox/_pk7600001401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600001401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/7d96c19771ca271623058eeb9fdc4ceb67ff68c3937a7b66e7ccdb1a4e6580fb.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/7d96c19771ca271623058eeb9fdc4ceb67ff68c3937a7b66e7ccdb1a4e6580fb.rar && sudo chmod 664 /var/www/dl.digital-guard.org/7d96c19771ca271623058eeb9fdc4ceb67ff68c3937a7b66e7ccdb1a4e6580fb.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001401301_p3_nsvia CASCADE"
cd /tmp/sandbox/_pk7600001401_001; 7z  x -y /var/www/dl.digital-guard.org/7d96c19771ca271623058eeb9fdc4ceb67ff68c3937a7b66e7ccdb1a4e6580fb.rar "*BAIRROS*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600001401_001; shp2pgsql -D -W ISO-8859-1  -s 31982 "BAIRROS.shp" pk7600001401301_p3_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600001401_001/BAIRROS.shp','nsvia_full','pk7600001401301_p3_nsvia','7600001401301','7d96c19771ca271623058eeb9fdc4ceb67ff68c3937a7b66e7ccdb1a4e6580fb.rar',array['gid', 'BAIRRO AS nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001401301_p3_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600001401_001/*BAIRROS.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PR/Pinhais/_pk0014.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PR/Pinhais/_pk0014.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-PR-Pinhais','/var/gits/_dg/preservCutGeo-BR2021/data/PR/Pinhais/_pk0014.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PR/Pinhais/_pk0014.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Pinhais/_pk0014.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Pinhais/_pk0014.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600001401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600001401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/56d32368409f4ba2c99afadc7ad307bd8cc660b93d38e57936da313fafde1f13.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/56d32368409f4ba2c99afadc7ad307bd8cc660b93d38e57936da313fafde1f13.rar && sudo chmod 664 /var/www/dl.digital-guard.org/56d32368409f4ba2c99afadc7ad307bd8cc660b93d38e57936da313fafde1f13.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001401101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600001401_001; 7z  x -y /var/www/dl.digital-guard.org/56d32368409f4ba2c99afadc7ad307bd8cc660b93d38e57936da313fafde1f13.rar "*LOTES*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600001401_001; shp2pgsql -D -W ISO-8859-1  -s 31982 "LOTES.shp" pk7600001401101_p1_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600001401101_p1_parcel AS SELECT gid, NOME_LOGRA || ' ' || TIPO_LOGRA AS via, NUMERO as hnum, NOME_BAIRR AS nsvia, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/LOTES.shp','parcel_full','vw1_pk7600001401101_p1_parcel','7600001401101','56d32368409f4ba2c99afadc7ad307bd8cc660b93d38e57936da313fafde1f13.rar',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600001401101_p1_parcel"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001401101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600001401_001/*LOTES.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PR/Pinhais/_pk0014.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PR/Pinhais/_pk0014.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-PR-Pinhais','/var/gits/_dg/preservCutGeo-BR2021/data/PR/Pinhais/_pk0014.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PR/Pinhais/_pk0014.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Pinhais/_pk0014.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Pinhais/_pk0014.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600001401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600001401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/27c0c467222a668837f62e9f40ac85f94685ea50f3d655207384f2343d13f573.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/27c0c467222a668837f62e9f40ac85f94685ea50f3d655207384f2343d13f573.rar && sudo chmod 664 /var/www/dl.digital-guard.org/27c0c467222a668837f62e9f40ac85f94685ea50f3d655207384f2343d13f573.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001401201_p2_via CASCADE"
cd /tmp/sandbox/_pk7600001401_001; 7z  x -y /var/www/dl.digital-guard.org/27c0c467222a668837f62e9f40ac85f94685ea50f3d655207384f2343d13f573.rar "*RUAS*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600001401_001; shp2pgsql -D -W ISO-8859-1  -s 31982 "RUAS.shp" pk7600001401201_p2_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600001401_001/RUAS.shp','via_full','pk7600001401201_p2_via','7600001401201','27c0c467222a668837f62e9f40ac85f94685ea50f3d655207384f2343d13f573.rar',array['gid', 'NOME_RUA  AS via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001401201_p2_via CASCADE"
rm -f /tmp/sandbox/_pk7600001401_001/*RUAS.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PR/Pinhais/_pk0014.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PR/Pinhais/_pk0014.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-PR-Pinhais','/var/gits/_dg/preservCutGeo-BR2021/data/PR/Pinhais/_pk0014.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PR/Pinhais/_pk0014.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Pinhais/_pk0014.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Pinhais/_pk0014.01/via -type f -exec chmod 664 {} \;




