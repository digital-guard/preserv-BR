#!/bin/bash








# layer nsvia:
rm -rf /tmp/sandbox/_pk7600006101_002 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600006101_002
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/52302cd28b0d4e36ba923a7f1fc82ff4d16f544a92b667933f8b46e036213b88.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/52302cd28b0d4e36ba923a7f1fc82ff4d16f544a92b667933f8b46e036213b88.zip && sudo chmod 664 /var/www/dl.digital-guard.org/52302cd28b0d4e36ba923a7f1fc82ff4d16f544a92b667933f8b46e036213b88.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006101101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk7600006101_002; 7z  x -y /var/www/dl.digital-guard.org/52302cd28b0d4e36ba923a7f1fc82ff4d16f544a92b667933f8b46e036213b88.zip '*Bairros*' '*Localidades Rurais*' ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=29192"
cd /tmp/sandbox/_pk7600006101_002; find /tmp/sandbox/_pk7600006101_002 -path "*Bairros*.shp" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c 'DROP TABLE IF EXISTS pk7600006101101_p1_nsvia'; shp2pgsql -D   -s 29192 '{}' pk7600006101101_p1_nsvia | psql -q postgres://postgres@localhost/ingest1; psql postgres://postgres@localhost/ingest1 -c \"SELECT ingest.any_load('shp2sql','$$(find /tmp/sandbox/_pk7600006101_002 -path "*Bairros*.shp" | head -n 1)','nsvia_full','pk7600006101101_p1_nsvia','7600006101101','52302cd28b0d4e36ba923a7f1fc82ff4d16f544a92b667933f8b46e036213b88.zip',array['gid', 'nome AS nsvia', 'geom'],5,1,True)\"; chmod -R a+rx . 2> /dev/null" \;
cd /tmp/sandbox/_pk7600006101_002; find /tmp/sandbox/_pk7600006101_002 -path "*Localidades Rurais*.shp" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c 'DROP TABLE IF EXISTS pk7600006101101_p1_nsvia'; shp2pgsql -D   -s 29192 '{}' pk7600006101101_p1_nsvia | psql -q postgres://postgres@localhost/ingest1; psql postgres://postgres@localhost/ingest1 -c \"SELECT ingest.any_load('shp2sql','$$(find /tmp/sandbox/_pk7600006101_002 -path "*Bairros*.shp" | head -n 1)','nsvia_full','pk7600006101101_p1_nsvia','7600006101101','52302cd28b0d4e36ba923a7f1fc82ff4d16f544a92b667933f8b46e036213b88.zip',array['gid', 'nomes AS nsvia', 'geom'],5,1,False)\"; chmod -R a+rx . 2> /dev/null" \;
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load_assign( '$$(find /tmp/sandbox/_pk7600006101_002 -path "*Bairros*.shp" | head -n 1)','nsvia_full','7600006101101' )"
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006101101_p1_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600006101_002/*Bairros.* || true
rm -f /tmp/sandbox/_pk7600006101_002/*Localidades Rurais.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PR/Araucaria/_pk0061.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PR/Araucaria/_pk0061.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-PR-Araucaria','/var/gits/_dg/preservCutGeo-BR2021/data/PR/Araucaria/_pk0061.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PR/Araucaria/_pk0061.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Araucaria/_pk0061.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Araucaria/_pk0061.01/nsvia -type f -exec chmod 664 {} \;


# layer via:
rm -rf /tmp/sandbox/_pk7600006101_002 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600006101_002
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/52302cd28b0d4e36ba923a7f1fc82ff4d16f544a92b667933f8b46e036213b88.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/52302cd28b0d4e36ba923a7f1fc82ff4d16f544a92b667933f8b46e036213b88.zip && sudo chmod 664 /var/www/dl.digital-guard.org/52302cd28b0d4e36ba923a7f1fc82ff4d16f544a92b667933f8b46e036213b88.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006101101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600006101_002; 7z  x -y /var/www/dl.digital-guard.org/52302cd28b0d4e36ba923a7f1fc82ff4d16f544a92b667933f8b46e036213b88.zip "*Sistema Viario*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=29192"
cd /tmp/sandbox/_pk7600006101_002; shp2pgsql -D   -s 29192 "Sistema Viario.shp" pk7600006101101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600006101_002/Sistema Viario.shp','via_full','pk7600006101101_p1_via','7600006101101','52302cd28b0d4e36ba923a7f1fc82ff4d16f544a92b667933f8b46e036213b88.zip',array['gid', 'endereço AS via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006101101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600006101_002/*Sistema Viario.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PR/Araucaria/_pk0061.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PR/Araucaria/_pk0061.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-PR-Araucaria','/var/gits/_dg/preservCutGeo-BR2021/data/PR/Araucaria/_pk0061.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PR/Araucaria/_pk0061.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Araucaria/_pk0061.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Araucaria/_pk0061.01/via -type f -exec chmod 664 {} \;




