#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600009101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600009101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/8d0400b02d594228c5a43df5e5bcdbbb620bce1175fac22fb2f196768159d53f.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/8d0400b02d594228c5a43df5e5bcdbbb620bce1175fac22fb2f196768159d53f.zip && sudo chmod 664 /var/www/dl.digital-guard.org/8d0400b02d594228c5a43df5e5bcdbbb620bce1175fac22fb2f196768159d53f.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600009101101_p1_block CASCADE"
cd /tmp/sandbox/_pk7600009101_001; 7z  x -y /var/www/dl.digital-guard.org/8d0400b02d594228c5a43df5e5bcdbbb620bce1175fac22fb2f196768159d53f.zip "*levels_3Polygon*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "INSERT INTO spatial_ref_sys (srid, auth_name, auth_srid, proj4text, srtext) VALUES (952047,'carlos',952047,'+proj=longlat +datum=WGS84 +no_defs',null);"
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=952047"
cd /tmp/sandbox/_pk7600009101_001; shp2pgsql -D   -s 952047 "levels_3Polygon.shp" pk7600009101101_p1_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600009101_001/levels_3Polygon.shp','block_full','pk7600009101101_p1_block','7600009101101','8d0400b02d594228c5a43df5e5bcdbbb620bce1175fac22fb2f196768159d53f.zip',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600009101101_p1_block CASCADE"
@echo "Delete SRID 952047 configurado via PROJ.4 string:"
@echo "+proj=longlat +datum=WGS84 +no_defs"
psql postgres://postgres@localhost/ingest1 -c "DELETE FROM spatial_ref_sys WHERE srid=952047;"
rm -f /tmp/sandbox/_pk7600009101_001/*levels_3Polygon.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-ES-CachoeiroItapemirim','/var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/block -type f -exec chmod 664 {} \;





# layer geoaddress:
rm -rf /tmp/sandbox/_pk7600009101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600009101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/4b8f5c5264e567014e98d3314a49ba2a1c71f8da5cba66572671fe674b7788f1.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/4b8f5c5264e567014e98d3314a49ba2a1c71f8da5cba66572671fe674b7788f1.zip && sudo chmod 664 /var/www/dl.digital-guard.org/4b8f5c5264e567014e98d3314a49ba2a1c71f8da5cba66572671fe674b7788f1.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600009101201_p2_geoaddress CASCADE"
cd /tmp/sandbox/_pk7600009101_001; 7z  x -y /var/www/dl.digital-guard.org/4b8f5c5264e567014e98d3314a49ba2a1c71f8da5cba66572671fe674b7788f1.zip "*inscricao_fiscal_cigeo*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "INSERT INTO spatial_ref_sys (srid, auth_name, auth_srid, proj4text, srtext) VALUES (952047,'carlos',952047,'+proj=longlat +datum=WGS84 +no_defs',null);"
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=952047"
cd /tmp/sandbox/_pk7600009101_001; shp2pgsql -D   -s 952047 "inscricao_fiscal_cigeo.shp" pk7600009101201_p2_geoaddress | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600009101_001/inscricao_fiscal_cigeo.shp','geoaddress_none','pk7600009101201_p2_geoaddress','7600009101201','4b8f5c5264e567014e98d3314a49ba2a1c71f8da5cba66572671fe674b7788f1.zip',array['gid', 'inscricao', 'geom'],1,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600009101201_p2_geoaddress CASCADE"
@echo "Delete SRID 952047 configurado via PROJ.4 string:"
@echo "+proj=longlat +datum=WGS84 +no_defs"
psql postgres://postgres@localhost/ingest1 -c "DELETE FROM spatial_ref_sys WHERE srid=952047;"
rm -f /tmp/sandbox/_pk7600009101_001/*inscricao_fiscal_cigeo.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','BR-ES-CachoeiroItapemirim','/var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/geoaddress','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/geoaddress -type f -exec chmod 664 {} \;

# layer nsvia:
rm -rf /tmp/sandbox/_pk7600009101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600009101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/5662a73fff9eeb6c1c3753b4d204b5c1074e9a17454c68fabcf17bd87c2c77b4.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/5662a73fff9eeb6c1c3753b4d204b5c1074e9a17454c68fabcf17bd87c2c77b4.rar && sudo chmod 664 /var/www/dl.digital-guard.org/5662a73fff9eeb6c1c3753b4d204b5c1074e9a17454c68fabcf17bd87c2c77b4.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600009101301_p3_nsvia CASCADE"
cd /tmp/sandbox/_pk7600009101_001; 7z  x -y /var/www/dl.digital-guard.org/5662a73fff9eeb6c1c3753b4d204b5c1074e9a17454c68fabcf17bd87c2c77b4.rar "*Camadas_Shap_base_Cachoeiro de Itpemirim/LIMITE_BAIRROS_7915_2021*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31984"
cd /tmp/sandbox/_pk7600009101_001; shp2pgsql -D -W UTF-8  -s 31984 "Camadas_Shap_base_Cachoeiro de Itpemirim/LIMITE_BAIRROS_7915_2021.shp" pk7600009101301_p3_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600009101_001/Camadas_Shap_base_Cachoeiro de Itpemirim/LIMITE_BAIRROS_7915_2021.shp','nsvia_full','pk7600009101301_p3_nsvia','7600009101301','5662a73fff9eeb6c1c3753b4d204b5c1074e9a17454c68fabcf17bd87c2c77b4.rar',array['gid', 'NOME as nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600009101301_p3_nsvia CASCADE"
@echo "Delete SRID 31984 configurado via PROJ.4 string:"
@echo "+proj=longlat +datum=WGS84 +no_defs"
psql postgres://postgres@localhost/ingest1 -c "DELETE FROM spatial_ref_sys WHERE srid=31984;"
rm -f /tmp/sandbox/_pk7600009101_001/*Camadas_Shap_base_Cachoeiro de Itpemirim/LIMITE_BAIRROS_7915_2021.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-ES-CachoeiroItapemirim','/var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600009101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600009101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/81db1f1d79472aa7e664a00e012628ee113c887e952e73af28e6e86ad10a7dab.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/81db1f1d79472aa7e664a00e012628ee113c887e952e73af28e6e86ad10a7dab.zip && sudo chmod 664 /var/www/dl.digital-guard.org/81db1f1d79472aa7e664a00e012628ee113c887e952e73af28e6e86ad10a7dab.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600009101401_p4_parcel CASCADE"
cd /tmp/sandbox/_pk7600009101_001; 7z  x -y /var/www/dl.digital-guard.org/81db1f1d79472aa7e664a00e012628ee113c887e952e73af28e6e86ad10a7dab.zip "*numeroinicioefim1*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "INSERT INTO spatial_ref_sys (srid, auth_name, auth_srid, proj4text, srtext) VALUES (952047,'carlos',952047,'+proj=longlat +datum=WGS84 +no_defs',null);"
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=952047"
cd /tmp/sandbox/_pk7600009101_001; shp2pgsql -D   -s 952047 "numeroinicioefim1.shp" pk7600009101401_p4_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600009101_001/numeroinicioefim1.shp','parcel_none','pk7600009101401_p4_parcel','7600009101401','81db1f1d79472aa7e664a00e012628ee113c887e952e73af28e6e86ad10a7dab.zip',array['gid', 'num01', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600009101401_p4_parcel CASCADE"
@echo "Delete SRID 952047 configurado via PROJ.4 string:"
@echo "+proj=longlat +datum=WGS84 +no_defs"
psql postgres://postgres@localhost/ingest1 -c "DELETE FROM spatial_ref_sys WHERE srid=952047;"
rm -f /tmp/sandbox/_pk7600009101_001/*numeroinicioefim1.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-ES-CachoeiroItapemirim','/var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600009101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600009101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/3a300c9f9836c3ea1af53bfdff81e4d663c413f688fdd9c9f583105c19f3ec39.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/3a300c9f9836c3ea1af53bfdff81e4d663c413f688fdd9c9f583105c19f3ec39.zip && sudo chmod 664 /var/www/dl.digital-guard.org/3a300c9f9836c3ea1af53bfdff81e4d663c413f688fdd9c9f583105c19f3ec39.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600009101601_p6_via CASCADE"
cd /tmp/sandbox/_pk7600009101_001; 7z  x -y /var/www/dl.digital-guard.org/3a300c9f9836c3ea1af53bfdff81e4d663c413f688fdd9c9f583105c19f3ec39.zip "*axisLine*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "INSERT INTO spatial_ref_sys (srid, auth_name, auth_srid, proj4text, srtext) VALUES (952047,'carlos',952047,'+proj=longlat +datum=WGS84 +no_defs',null);"
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=952047"
cd /tmp/sandbox/_pk7600009101_001; shp2pgsql -D -W ISO-8859-1  -s 952047 "axisLine.shp" pk7600009101601_p6_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw6_pk7600009101601_p6_via AS SELECT gid, tip_logr || ' ' || textstring AS via, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/axisLine.shp','via_full','vw6_pk7600009101601_p6_via','7600009101601','3a300c9f9836c3ea1af53bfdff81e4d663c413f688fdd9c9f583105c19f3ec39.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw6_pk7600009101601_p6_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600009101601_p6_via CASCADE"
@echo "Delete SRID 952047 configurado via PROJ.4 string:"
@echo "+proj=longlat +datum=WGS84 +no_defs"
psql postgres://postgres@localhost/ingest1 -c "DELETE FROM spatial_ref_sys WHERE srid=952047;"
rm -f /tmp/sandbox/_pk7600009101_001/*axisLine.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-ES-CachoeiroItapemirim','/var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/CachoeiroItapemirim/_pk0091.01/via -type f -exec chmod 664 {} \;




