#!/bin/bash










# layer via:
rm -rf /tmp/sandbox/_pk7600007001_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007001_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/a9eebc7790d496b13b2e69dd4fa1f43dd6596912fb21ff2131aa4c66ba3a52a4.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/a9eebc7790d496b13b2e69dd4fa1f43dd6596912fb21ff2131aa4c66ba3a52a4.zip && sudo chmod 664 /var/www/dl.digital-guard.org/a9eebc7790d496b13b2e69dd4fa1f43dd6596912fb21ff2131aa4c66ba3a52a4.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007001101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600007001_001; 7z  x -y /var/www/dl.digital-guard.org/a9eebc7790d496b13b2e69dd4fa1f43dd6596912fb21ff2131aa4c66ba3a52a4.zip "*Logradouros_Itabira_2021*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=22523"
cd /tmp/sandbox/_pk7600007001_001; shp2pgsql -D   -s 22523 "Logradouros_Itabira_2021.shp" pk7600007001101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600007001_001/Logradouros_Itabira_2021.shp','via_full','pk7600007001101_p1_via','7600007001101','a9eebc7790d496b13b2e69dd4fa1f43dd6596912fb21ff2131aa4c66ba3a52a4.zip',array['gid', 'LOG_NOME AS via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007001101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600007001_001/*Logradouros_Itabira_2021.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/MG/Itabira/_pk0070.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/MG/Itabira/_pk0070.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "CALL ingest.ppublicating_geojsons('via','BR-MG-Itabira','/var/gits/_dg/preservCutGeo-BR2021/data/MG/Itabira/_pk0070.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/MG/Itabira/_pk0070.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/Itabira/_pk0070.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/Itabira/_pk0070.01/via -type f -exec chmod 664 {} \;




