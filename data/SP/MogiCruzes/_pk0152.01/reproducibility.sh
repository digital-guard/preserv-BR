#!/bin/bash










# layer via:
rm -rf /tmp/sandbox/_pk7600015201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600015201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/ca1f57eb1c709894fdb12d88899343c92ad07fc997b4d838ee1b89aec3320536.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/ca1f57eb1c709894fdb12d88899343c92ad07fc997b4d838ee1b89aec3320536.zip && sudo chmod 664 /var/www/dl.digital-guard.org/ca1f57eb1c709894fdb12d88899343c92ad07fc997b4d838ee1b89aec3320536.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600015201101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600015201_001; 7z  x -y /var/www/dl.digital-guard.org/ca1f57eb1c709894fdb12d88899343c92ad07fc997b4d838ee1b89aec3320536.zip "*eixos*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4760"
cd /tmp/sandbox/_pk7600015201_001; shp2pgsql -D   -s 4760 "eixos.shp" pk7600015201101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600015201_001/eixos.shp','via_full','pk7600015201101_p1_via','7600015201101','ca1f57eb1c709894fdb12d88899343c92ad07fc997b4d838ee1b89aec3320536.zip',array['gid', 'nome AS via', 'cep AS postcode', 'loteamento as nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600015201101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600015201_001/*eixos.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/MogiCruzes/_pk0152.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/MogiCruzes/_pk0152.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-SP-MogiCruzes','/var/gits/_dg/preservCutGeo-BR2021/data/SP/MogiCruzes/_pk0152.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/MogiCruzes/_pk0152.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/MogiCruzes/_pk0152.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/MogiCruzes/_pk0152.01/via -type f -exec chmod 664 {} \;




