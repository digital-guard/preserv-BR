#!/bin/bash



# layer building:
rm -rf /tmp/sandbox/_pk7600014601_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600014601_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/c7e8f19fa27fc1e515c43383403b54291ad39aa39e09cd5d96d30e6385942a8a.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/c7e8f19fa27fc1e515c43383403b54291ad39aa39e09cd5d96d30e6385942a8a.zip && sudo chmod 664 /var/www/dl.digital-guard.org/c7e8f19fa27fc1e515c43383403b54291ad39aa39e09cd5d96d30e6385942a8a.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600014601101_p1_building CASCADE"
cd /tmp/sandbox/_pk7600014601_001; 7z  x -y /var/www/dl.digital-guard.org/c7e8f19fa27fc1e515c43383403b54291ad39aa39e09cd5d96d30e6385942a8a.zip "*unidade_inscricao_geometriaPolygon*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600014601_001; shp2pgsql -D   -s 31982 "unidade_inscricao_geometriaPolygon.shp" pk7600014601101_p1_building | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600014601101_p1_building AS SELECT gid, 'yes' AS building, cd_distrit || cd_setor || nr_quadra || nr_lote || nr_edifica || nr_unidade AS inscricao_edificacao, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/unidade_inscricao_geometriaPolygon.shp','building_ext','vw1_pk7600014601101_p1_building','7600014601101','c7e8f19fa27fc1e515c43383403b54291ad39aa39e09cd5d96d30e6385942a8a.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600014601101_p1_building"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600014601101_p1_building CASCADE"
rm -f /tmp/sandbox/_pk7600014601_001/*unidade_inscricao_geometriaPolygon.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PR/Umuarama/_pk0146.01/building
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PR/Umuarama/_pk0146.01/building/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('building','BR-PR-Umuarama','/var/gits/_dg/preservCutGeo-BR2021/data/PR/Umuarama/_pk0146.01/building','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PR/Umuarama/_pk0146.01/building
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Umuarama/_pk0146.01/building -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Umuarama/_pk0146.01/building -type f -exec chmod 664 {} \;

# layer cadparcel:
rm -rf /tmp/sandbox/_pk7600014601_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600014601_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/c7e8f19fa27fc1e515c43383403b54291ad39aa39e09cd5d96d30e6385942a8a.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/c7e8f19fa27fc1e515c43383403b54291ad39aa39e09cd5d96d30e6385942a8a.zip && sudo chmod 664 /var/www/dl.digital-guard.org/c7e8f19fa27fc1e515c43383403b54291ad39aa39e09cd5d96d30e6385942a8a.zip
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk7600014601101_p1_cadparcel CASCADE"
cd /tmp/sandbox/_pk7600014601_001; 7z  x -y /var/www/dl.digital-guard.org/c7e8f19fa27fc1e515c43383403b54291ad39aa39e09cd5d96d30e6385942a8a.zip "*TABELA IMOVEL*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
xlsx2csv -i  "/tmp/sandbox/_pk7600014601_001/TABELA IMOVEL.xlsx" "/tmp/sandbox/_pk7600014601_001/TABELA IMOVEL.csv"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.fdw_generate_direct_csv( '/tmp/sandbox/_pk7600014601_001/TABELA IMOVEL.csv', 'pk7600014601101_p1_cadparcel' )"

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600014601101_p1_cadparcel AS SELECT DISTINCT \"LOGRADOURO\" as via, \"NUMERO\" as hnum, substring(\"INSCRIÇÃO\",1,14) AS inscricao_lote FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('csv2sql','/tmp/sandbox/TABELA IMOVEL.xlsx','cadparcel_cmpl','vw1_pk7600014601101_p1_cadparcel','7600014601101','c7e8f19fa27fc1e515c43383403b54291ad39aa39e09cd5d96d30e6385942a8a.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600014601101_p1_cadparcel"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.cadastral_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk7600014601101_p1_cadparcel CASCADE"
rm -f /tmp/sandbox/_pk7600014601_001/*TABELA IMOVEL.* || true




# layer nsvia:
rm -rf /tmp/sandbox/_pk7600014601_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600014601_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/c7e8f19fa27fc1e515c43383403b54291ad39aa39e09cd5d96d30e6385942a8a.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/c7e8f19fa27fc1e515c43383403b54291ad39aa39e09cd5d96d30e6385942a8a.zip && sudo chmod 664 /var/www/dl.digital-guard.org/c7e8f19fa27fc1e515c43383403b54291ad39aa39e09cd5d96d30e6385942a8a.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600014601101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk7600014601_001; 7z  x -y /var/www/dl.digital-guard.org/c7e8f19fa27fc1e515c43383403b54291ad39aa39e09cd5d96d30e6385942a8a.zip "*st_bairroPolygon*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600014601_001; shp2pgsql -D   -s 31982 "st_bairroPolygon.shp" pk7600014601101_p1_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600014601_001/st_bairroPolygon.shp','nsvia_none','pk7600014601101_p1_nsvia','7600014601101','c7e8f19fa27fc1e515c43383403b54291ad39aa39e09cd5d96d30e6385942a8a.zip',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600014601101_p1_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600014601_001/*st_bairroPolygon.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PR/Umuarama/_pk0146.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PR/Umuarama/_pk0146.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-PR-Umuarama','/var/gits/_dg/preservCutGeo-BR2021/data/PR/Umuarama/_pk0146.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PR/Umuarama/_pk0146.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Umuarama/_pk0146.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Umuarama/_pk0146.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600014601_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600014601_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/c7e8f19fa27fc1e515c43383403b54291ad39aa39e09cd5d96d30e6385942a8a.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/c7e8f19fa27fc1e515c43383403b54291ad39aa39e09cd5d96d30e6385942a8a.zip && sudo chmod 664 /var/www/dl.digital-guard.org/c7e8f19fa27fc1e515c43383403b54291ad39aa39e09cd5d96d30e6385942a8a.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600014601101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600014601_001; 7z  x -y /var/www/dl.digital-guard.org/c7e8f19fa27fc1e515c43383403b54291ad39aa39e09cd5d96d30e6385942a8a.zip "*lote_inscricao_geometriaPolygon*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600014601_001; shp2pgsql -D   -s 31982 "lote_inscricao_geometriaPolygon.shp" pk7600014601101_p1_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600014601_001/lote_inscricao_geometriaPolygon.shp','parcel_ext','pk7600014601101_p1_parcel','7600014601101','c7e8f19fa27fc1e515c43383403b54291ad39aa39e09cd5d96d30e6385942a8a.zip',array['gid', 'cd_distrit || cd_setor || nr_quadra || nr_lote AS inscricao_lote', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600014601101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600014601_001/*lote_inscricao_geometriaPolygon.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PR/Umuarama/_pk0146.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PR/Umuarama/_pk0146.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-PR-Umuarama','/var/gits/_dg/preservCutGeo-BR2021/data/PR/Umuarama/_pk0146.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PR/Umuarama/_pk0146.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Umuarama/_pk0146.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Umuarama/_pk0146.01/parcel -type f -exec chmod 664 {} \;




# layer joining



psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.join('parcel_ext','inscricao_lote','c7e8f19fa27fc1e515c43383403b54291ad39aa39e09cd5d96d30e6385942a8a.zip','cadparcel_cmpl','inscricao_lote','c7e8f19fa27fc1e515c43383403b54291ad39aa39e09cd5d96d30e6385942a8a.zip')"

