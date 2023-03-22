#!/bin/bash









# layer parcel:
rm -rf /tmp/sandbox/_pk7600014101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600014101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/b69cef94c0fad1a99013289fd30eb3ad0d612e227547f1a95cbd104716980263.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/b69cef94c0fad1a99013289fd30eb3ad0d612e227547f1a95cbd104716980263.rar && sudo chmod 664 /var/www/dl.digital-guard.org/b69cef94c0fad1a99013289fd30eb3ad0d612e227547f1a95cbd104716980263.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600014101101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600014101_001; 7z  x -y /var/www/dl.digital-guard.org/b69cef94c0fad1a99013289fd30eb3ad0d612e227547f1a95cbd104716980263.rar "*Municipio de Itajai_SC/lotes*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=3857"
cd /tmp/sandbox/_pk7600014101_001; shp2pgsql -D   -s 3857 "Municipio de Itajai_SC/lotes.shp" pk7600014101101_p1_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600014101_001/Municipio de Itajai_SC/lotes.shp','parcel_full','pk7600014101101_p1_parcel','7600014101101','b69cef94c0fad1a99013289fd30eb3ad0d612e227547f1a95cbd104716980263.rar',array['gid', 'numero as hnum', 'nomevia as via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600014101101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600014101_001/*Municipio de Itajai_SC/lotes.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SC/Itajai/_pk0141.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SC/Itajai/_pk0141.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-SC-Itajai','/var/gits/_dg/preservCutGeo-BR2021/data/SC/Itajai/_pk0141.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SC/Itajai/_pk0141.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Itajai/_pk0141.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Itajai/_pk0141.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600014101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600014101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/b69cef94c0fad1a99013289fd30eb3ad0d612e227547f1a95cbd104716980263.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/b69cef94c0fad1a99013289fd30eb3ad0d612e227547f1a95cbd104716980263.rar && sudo chmod 664 /var/www/dl.digital-guard.org/b69cef94c0fad1a99013289fd30eb3ad0d612e227547f1a95cbd104716980263.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600014101101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600014101_001; 7z  x -y /var/www/dl.digital-guard.org/b69cef94c0fad1a99013289fd30eb3ad0d612e227547f1a95cbd104716980263.rar "*Municipio de Itajai_SC/vias*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=3857"
cd /tmp/sandbox/_pk7600014101_001; shp2pgsql -D   -s 3857 "Municipio de Itajai_SC/vias.shp" pk7600014101101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600014101_001/Municipio de Itajai_SC/vias.shp','via_full','pk7600014101101_p1_via','7600014101101','b69cef94c0fad1a99013289fd30eb3ad0d612e227547f1a95cbd104716980263.rar',array['gid', 'nome as via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600014101101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600014101_001/*Municipio de Itajai_SC/vias.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SC/Itajai/_pk0141.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SC/Itajai/_pk0141.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-SC-Itajai','/var/gits/_dg/preservCutGeo-BR2021/data/SC/Itajai/_pk0141.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SC/Itajai/_pk0141.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Itajai/_pk0141.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Itajai/_pk0141.01/via -type f -exec chmod 664 {} \;




