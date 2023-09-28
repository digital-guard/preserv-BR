#!/bin/bash







# layer geoaddress:
rm -rf /tmp/sandbox/_pk7600002901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/b192fba419ef8133861a9051d2382d08476193eafbd8932f0ea05456157c301c.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/b192fba419ef8133861a9051d2382d08476193eafbd8932f0ea05456157c301c.zip && sudo chmod 664 /var/www/dl.digital-guard.org/b192fba419ef8133861a9051d2382d08476193eafbd8932f0ea05456157c301c.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002901101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk7600002901_001; 7z  x -y /var/www/dl.digital-guard.org/b192fba419ef8133861a9051d2382d08476193eafbd8932f0ea05456157c301c.zip "*LOTES_PONTO_S2K*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600002901_001; shp2pgsql -D -W ISO-8859-1  -s 31983 "LOTES_PONTO_S2K.shp" pk7600002901101_p1_geoaddress | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600002901_001/LOTES_PONTO_S2K.shp','geoaddress_full','pk7600002901101_p1_geoaddress','7600002901101','b192fba419ef8133861a9051d2382d08476193eafbd8932f0ea05456157c301c.zip',array['gid', 'L_NUMERO AS hnum', 'X', 'Y', 'geom'],1,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002901101_p1_geoaddress CASCADE"
rm -f /tmp/sandbox/_pk7600002901_001/*LOTES_PONTO_S2K.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Santos/_pk0029.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Santos/_pk0029.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','BR-SP-Santos','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Santos/_pk0029.01/geoaddress','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Santos/_pk0029.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Santos/_pk0029.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Santos/_pk0029.01/geoaddress -type f -exec chmod 664 {} \;







