#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600002401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/5041bf52dc6cbd99fb555180a3f34becae8c61352e975f61bfb9c56182e49749.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/5041bf52dc6cbd99fb555180a3f34becae8c61352e975f61bfb9c56182e49749.rar && sudo chmod 664 /var/www/dl.digital-guard.org/5041bf52dc6cbd99fb555180a3f34becae8c61352e975f61bfb9c56182e49749.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002401301_p3_block CASCADE"
cd /tmp/sandbox/_pk7600002401_001; 7z  x -y /var/www/dl.digital-guard.org/5041bf52dc6cbd99fb555180a3f34becae8c61352e975f61bfb9c56182e49749.rar "*Quadra/Quadra*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=32723"
cd /tmp/sandbox/_pk7600002401_001; shp2pgsql -D   -s 32723 "Quadra/Quadra.shp" pk7600002401301_p3_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600002401_001/Quadra/Quadra.shp','block_none','pk7600002401301_p3_block','7600002401301','5041bf52dc6cbd99fb555180a3f34becae8c61352e975f61bfb9c56182e49749.rar',array['geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002401301_p3_block CASCADE"
rm -f /tmp/sandbox/_pk7600002401_001/*Quadra/Quadra.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-SP-Itu','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/block -type f -exec chmod 664 {} \;

# layer building:
rm -rf /tmp/sandbox/_pk7600002401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/5041bf52dc6cbd99fb555180a3f34becae8c61352e975f61bfb9c56182e49749.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/5041bf52dc6cbd99fb555180a3f34becae8c61352e975f61bfb9c56182e49749.rar && sudo chmod 664 /var/www/dl.digital-guard.org/5041bf52dc6cbd99fb555180a3f34becae8c61352e975f61bfb9c56182e49749.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002401301_p3_building CASCADE"
cd /tmp/sandbox/_pk7600002401_001; 7z  x -y /var/www/dl.digital-guard.org/5041bf52dc6cbd99fb555180a3f34becae8c61352e975f61bfb9c56182e49749.rar "*Edificação/Edificação*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=32723"
cd /tmp/sandbox/_pk7600002401_001; shp2pgsql -D   -s 32723 "Edificação/Edificação.shp" pk7600002401301_p3_building | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600002401_001/Edificação/Edificação.shp','building_none','pk7600002401301_p3_building','7600002401301','5041bf52dc6cbd99fb555180a3f34becae8c61352e975f61bfb9c56182e49749.rar',array['geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002401301_p3_building CASCADE"
rm -f /tmp/sandbox/_pk7600002401_001/*Edificação/Edificação.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/building
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/building/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('building','BR-SP-Itu','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/building','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/building
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/building -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/building -type f -exec chmod 664 {} \;






# layer parcel:
rm -rf /tmp/sandbox/_pk7600002401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/00f40e3731f0e04b8d1050a4716385f412aed5b32b560a47cc321ef4ea5413f8.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/00f40e3731f0e04b8d1050a4716385f412aed5b32b560a47cc321ef4ea5413f8.rar && sudo chmod 664 /var/www/dl.digital-guard.org/00f40e3731f0e04b8d1050a4716385f412aed5b32b560a47cc321ef4ea5413f8.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002401101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600002401_001; 7z  x -y /var/www/dl.digital-guard.org/00f40e3731f0e04b8d1050a4716385f412aed5b32b560a47cc321ef4ea5413f8.rar "*lotes_Itu*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=32723"
sudo docker run --rm --network host -v /tmp/sandbox:/tmp osgeo/gdal ogr2ogr -lco GEOMETRY_NAME=geom -overwrite -f "PostgreSQL" PG:" dbname='ingest1' host='localhost' port='5432' user='postgres' " "/tmp/lotes_Itu.TAB"  -nln pk7600002401101_p1_parcel -a_srs EPSG:32723  

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('ogr2ogr','/tmp/sandbox/_pk7600002401_001/lotes_Itu.TAB','parcel_full','pk7600002401101_p1_parcel','7600002401101','00f40e3731f0e04b8d1050a4716385f412aed5b32b560a47cc321ef4ea5413f8.rar',array['Bairro as nsvia', 'Logradouro AS via', 'Numero AS hnum', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002401101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600002401_001/*lotes_Itu.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-SP-Itu','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600002401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/e10b14c4bfeaa6b40b725acc573a98fba308b72836002af3c7431982b74348f1.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/e10b14c4bfeaa6b40b725acc573a98fba308b72836002af3c7431982b74348f1.rar && sudo chmod 664 /var/www/dl.digital-guard.org/e10b14c4bfeaa6b40b725acc573a98fba308b72836002af3c7431982b74348f1.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002401201_p2_via CASCADE"
cd /tmp/sandbox/_pk7600002401_001; 7z  x -y /var/www/dl.digital-guard.org/e10b14c4bfeaa6b40b725acc573a98fba308b72836002af3c7431982b74348f1.rar "*LOGRADOURO_2019*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=32723"
sudo docker run --rm --network host -v /tmp/sandbox:/tmp osgeo/gdal ogr2ogr -lco GEOMETRY_NAME=geom -overwrite -f "PostgreSQL" PG:" dbname='ingest1' host='localhost' port='5432' user='postgres' " "/tmp/LOGRADOURO_2019.tab"  -nln pk7600002401201_p2_via -a_srs EPSG:32723  -nlt CONVERT_TO_LINEAR -nlt PROMOTE_TO_MULTI

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('ogr2ogr','/tmp/sandbox/_pk7600002401_001/LOGRADOURO_2019.tab','via_full','pk7600002401201_p2_via','7600002401201','e10b14c4bfeaa6b40b725acc573a98fba308b72836002af3c7431982b74348f1.rar',array['Logradouro AS via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002401201_p2_via CASCADE"
rm -f /tmp/sandbox/_pk7600002401_001/*LOGRADOURO_2019.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-SP-Itu','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itu/_pk0024.01/via -type f -exec chmod 664 {} \;




