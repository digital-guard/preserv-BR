#!/bin/bash









# layer parcel:
rm -rf /tmp/sandbox/_pk7600006201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600006201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/67f980eb940a57a8f4e40b8e15be9b4b65162aa9afe27d0a89f826047f9b9039.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/67f980eb940a57a8f4e40b8e15be9b4b65162aa9afe27d0a89f826047f9b9039.zip && sudo chmod 664 /var/www/dl.digital-guard.org/67f980eb940a57a8f4e40b8e15be9b4b65162aa9afe27d0a89f826047f9b9039.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006201201_p2_parcel CASCADE"
cd /tmp/sandbox/_pk7600006201_001; 7z  x -y /var/www/dl.digital-guard.org/67f980eb940a57a8f4e40b8e15be9b4b65162aa9afe27d0a89f826047f9b9039.zip "*Lotes basicos*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=32720"
cd /tmp/sandbox/_pk7600006201_001; shp2pgsql -D -W ISO-8859-1  -s 32720 "Lotes basicos.shp" pk7600006201201_p2_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw2_pk7600006201201_p2_parcel AS SELECT gid, LOTES_TIPO || ' ' || LOTES_ENDE AS via, LOTES_NUME AS hnum, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/Lotes basicos.shp','parcel_full','vw2_pk7600006201201_p2_parcel','7600006201201','67f980eb940a57a8f4e40b8e15be9b4b65162aa9afe27d0a89f826047f9b9039.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw2_pk7600006201201_p2_parcel"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006201201_p2_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600006201_001/*Lotes basicos.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RO/JiParana/_pk0062.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RO/JiParana/_pk0062.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-RO-JiParana','/var/gits/_dg/preservCutGeo-BR2021/data/RO/JiParana/_pk0062.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RO/JiParana/_pk0062.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RO/JiParana/_pk0062.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RO/JiParana/_pk0062.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600006201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600006201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/910851a581a1eefe4a3a8534ffd46ac6ad11e998fcf7c6ebf624700b885a4b01.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/910851a581a1eefe4a3a8534ffd46ac6ad11e998fcf7c6ebf624700b885a4b01.zip && sudo chmod 664 /var/www/dl.digital-guard.org/910851a581a1eefe4a3a8534ffd46ac6ad11e998fcf7c6ebf624700b885a4b01.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006201101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600006201_001; 7z  x -y /var/www/dl.digital-guard.org/910851a581a1eefe4a3a8534ffd46ac6ad11e998fcf7c6ebf624700b885a4b01.zip "*Ruas Matriz nova*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=32720"
cd /tmp/sandbox/_pk7600006201_001; shp2pgsql -D   -s 32720 "Ruas Matriz nova.shp" pk7600006201101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600006201_001/Ruas Matriz nova.shp','via_full','pk7600006201101_p1_via','7600006201101','910851a581a1eefe4a3a8534ffd46ac6ad11e998fcf7c6ebf624700b885a4b01.zip',array['gid', 'Rua as via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006201101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600006201_001/*Ruas Matriz nova.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RO/JiParana/_pk0062.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RO/JiParana/_pk0062.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-RO-JiParana','/var/gits/_dg/preservCutGeo-BR2021/data/RO/JiParana/_pk0062.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RO/JiParana/_pk0062.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RO/JiParana/_pk0062.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RO/JiParana/_pk0062.01/via -type f -exec chmod 664 {} \;




