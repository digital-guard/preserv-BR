#!/bin/bash







# layer geoaddress:
rm -rf /tmp/sandbox/_pk7600011001_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600011001_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/8884e9035116c647376301085809c7cbfb0d44841e1f51035b4b286e8648b05a.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/8884e9035116c647376301085809c7cbfb0d44841e1f51035b4b286e8648b05a.zip && sudo chmod 664 /var/www/dl.digital-guard.org/8884e9035116c647376301085809c7cbfb0d44841e1f51035b4b286e8648b05a.zip
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk7600011001101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk7600011001_001; 7z  x -y /var/www/dl.digital-guard.org/8884e9035116c647376301085809c7cbfb0d44841e1f51035b4b286e8648b05a.zip "*Num_Predial_14_03_2022*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
xlsx2csv -i  "/tmp/sandbox/_pk7600011001_001/Num_Predial_14_03_2022.xlsx" "/tmp/sandbox/_pk7600011001_001/Num_Predial_14_03_2022.csv"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.fdw_generate_direct_csv( '/tmp/sandbox/_pk7600011001_001/Num_Predial_14_03_2022.csv', 'pk7600011001101_p1_geoaddress' )"

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600011001101_p1_geoaddress AS SELECT row_number() OVER () AS gid, \"Tipo Logradouro\" || ' ' || \"Logradouro\" AS via,   \
ST_SetSRID(ST_MakePoint(round(\"Longitude\"::float,8),round(\"Latitude\"::float,8)),4326) as geom, \
\"Número Predial\" as house_number
FROM $(tabname) where \"Longitude\"::float <= 90 and \"Latitude\"::float <= 90"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('csv2sql','/tmp/sandbox/Num_Predial_14_03_2022.xlsx','geoaddress_full','vw1_pk7600011001101_p1_geoaddress','7600011001101','8884e9035116c647376301085809c7cbfb0d44841e1f51035b4b286e8648b05a.zip',array[]::text[],1,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600011001101_p1_geoaddress"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk7600011001101_p1_geoaddress CASCADE"
rm -f /tmp/sandbox/_pk7600011001_001/*Num_Predial_14_03_2022.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PR/Maringa/_pk0110.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PR/Maringa/_pk0110.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','BR-PR-Maringa','/var/gits/_dg/preservCutGeo-BR2021/data/PR/Maringa/_pk0110.01/geoaddress','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PR/Maringa/_pk0110.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Maringa/_pk0110.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Maringa/_pk0110.01/geoaddress -type f -exec chmod 664 {} \;







