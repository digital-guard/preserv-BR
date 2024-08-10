#!/bin/bash








# layer nsvia:
rm -rf /tmp/sandbox/_pk7600005001_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600005001_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/2dd6c00405143aa6378b38a80eb5a7f4d7ce201d31e99c60b4a5bf4ad5bf98de.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/2dd6c00405143aa6378b38a80eb5a7f4d7ce201d31e99c60b4a5bf4ad5bf98de.zip && sudo chmod 664 /var/www/dl.digital-guard.org/2dd6c00405143aa6378b38a80eb5a7f4d7ce201d31e99c60b4a5bf4ad5bf98de.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005001101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk7600005001_001; 7z  x -y /var/www/dl.digital-guard.org/2dd6c00405143aa6378b38a80eb5a7f4d7ce201d31e99c60b4a5bf4ad5bf98de.zip "*Prefeituras_Bairro*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31984"
cd /tmp/sandbox/_pk7600005001_001; shp2pgsql -D   -s 31984 "Prefeituras_Bairro.shp" pk7600005001101_p1_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600005001_001/Prefeituras_Bairro.shp','nsvia_full','pk7600005001101_p1_nsvia','7600005001101','2dd6c00405143aa6378b38a80eb5a7f4d7ce201d31e99c60b4a5bf4ad5bf98de.zip',array['gid', 'subclasses AS nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005001101_p1_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600005001_001/*Prefeituras_Bairro.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/BA/Salvador/_pk0050.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/BA/Salvador/_pk0050.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-BA-Salvador','/var/gits/_dg/preservCutGeo-BR2021/data/BA/Salvador/_pk0050.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/BA/Salvador/_pk0050.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/BA/Salvador/_pk0050.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/BA/Salvador/_pk0050.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600005001_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600005001_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/e8326aac43117a60b0f6294ecc579e7c2bdaee704206a86d03edcff9a5f9db04.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/e8326aac43117a60b0f6294ecc579e7c2bdaee704206a86d03edcff9a5f9db04.zip && sudo chmod 664 /var/www/dl.digital-guard.org/e8326aac43117a60b0f6294ecc579e7c2bdaee704206a86d03edcff9a5f9db04.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005001301_p3_parcel CASCADE"
cd /tmp/sandbox/_pk7600005001_001; 7z  x -y /var/www/dl.digital-guard.org/e8326aac43117a60b0f6294ecc579e7c2bdaee704206a86d03edcff9a5f9db04.zip "*edf_edificacao_a.dxf*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31984"
sudo docker run --rm --network host -v /tmp/sandbox:/tmp osgeo/gdal ogr2ogr -lco GEOMETRY_NAME=geom -overwrite -f "PostgreSQL" PG:" dbname='ingest1' host='localhost' port='5432' user='postgres' " "/tmp/edf_edificacao_a.dxf"  -nln pk7600005001301_p3_parcel -a_srs EPSG:31984  

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw3_pk7600005001301_p3_parcel AS SELECT row_number() OVER () AS gid, ST_MakePolygon(geom) AS geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('ogr2ogr','/tmp/sandbox/edf_edificacao_a.dxf','parcel_none','vw3_pk7600005001301_p3_parcel','7600005001301','e8326aac43117a60b0f6294ecc579e7c2bdaee704206a86d03edcff9a5f9db04.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw3_pk7600005001301_p3_parcel"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005001301_p3_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600005001_001/*edf_edificacao_a.dxf.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/BA/Salvador/_pk0050.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/BA/Salvador/_pk0050.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-BA-Salvador','/var/gits/_dg/preservCutGeo-BR2021/data/BA/Salvador/_pk0050.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/BA/Salvador/_pk0050.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/BA/Salvador/_pk0050.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/BA/Salvador/_pk0050.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600005001_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600005001_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/58c2353cf924694da728d1107e71e9deb67d39c1f9ffd65a2eaffed32b4d253a.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/58c2353cf924694da728d1107e71e9deb67d39c1f9ffd65a2eaffed32b4d253a.zip && sudo chmod 664 /var/www/dl.digital-guard.org/58c2353cf924694da728d1107e71e9deb67d39c1f9ffd65a2eaffed32b4d253a.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005001201_p2_via CASCADE"
cd /tmp/sandbox/_pk7600005001_001; 7z  x -y /var/www/dl.digital-guard.org/58c2353cf924694da728d1107e71e9deb67d39c1f9ffd65a2eaffed32b4d253a.zip "*Trecho_de_Arruamento_2021-08-20*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31984"
cd /tmp/sandbox/_pk7600005001_001; shp2pgsql -D   -s 31984 "Trecho_de_Arruamento_2021-08-20.shp" pk7600005001201_p2_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw2_pk7600005001201_p2_via AS SELECT gid, \
ST_Boundary(geom) As geom \
FROM $(tabname) "
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/Trecho_de_Arruamento_2021-08-20.shp','via_none','vw2_pk7600005001201_p2_via','7600005001201','58c2353cf924694da728d1107e71e9deb67d39c1f9ffd65a2eaffed32b4d253a.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw2_pk7600005001201_p2_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005001201_p2_via CASCADE"
rm -f /tmp/sandbox/_pk7600005001_001/*Trecho_de_Arruamento_2021-08-20.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/BA/Salvador/_pk0050.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/BA/Salvador/_pk0050.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-BA-Salvador','/var/gits/_dg/preservCutGeo-BR2021/data/BA/Salvador/_pk0050.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/BA/Salvador/_pk0050.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/BA/Salvador/_pk0050.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/BA/Salvador/_pk0050.01/via -type f -exec chmod 664 {} \;




