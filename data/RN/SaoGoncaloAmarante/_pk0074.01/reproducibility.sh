#!/bin/bash








# layer nsvia:
rm -rf /tmp/sandbox/_pk7600007401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/0d3ff4b054eecdf731311a1a0198a75084e87727b049ffff93468646f25cb562.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/0d3ff4b054eecdf731311a1a0198a75084e87727b049ffff93468646f25cb562.zip && sudo chmod 664 /var/www/dl.digital-guard.org/0d3ff4b054eecdf731311a1a0198a75084e87727b049ffff93468646f25cb562.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007401101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk7600007401_001; 7z  x -y /var/www/dl.digital-guard.org/0d3ff4b054eecdf731311a1a0198a75084e87727b049ffff93468646f25cb562.zip "*Arquivos Vetoriais - SGA/Bairros/Bairros_SGA_2020*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
sudo docker run --rm --network host -v /tmp/sandbox:/tmp ghcr.io/osgeo/gdal ogr2ogr -lco GEOMETRY_NAME=geom -overwrite -f "PostgreSQL" PG:" dbname='ingest1' host='localhost' port='5432' user='postgres' " "/tmp/Arquivos Vetoriais - SGA/Bairros/Bairros_SGA_2020.kmz"  -nln pk7600007401101_p1_nsvia -a_srs EPSG:4326  

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('ogr2ogr','/tmp/sandbox/_pk7600007401_001/Arquivos Vetoriais - SGA/Bairros/Bairros_SGA_2020.kmz','nsvia_full','pk7600007401101_p1_nsvia','7600007401101','0d3ff4b054eecdf731311a1a0198a75084e87727b049ffff93468646f25cb562.zip',array['row_number() OVER () AS gid', 'Name as nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007401101_p1_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600007401_001/*Arquivos Vetoriais - SGA/Bairros/Bairros_SGA_2020.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RN/SaoGoncaloAmarante/_pk0074.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RN/SaoGoncaloAmarante/_pk0074.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "CALL ingest.ppublicating_geojsons('nsvia','BR-RN-SaoGoncaloAmarante','/var/gits/_dg/preservCutGeo-BR2021/data/RN/SaoGoncaloAmarante/_pk0074.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RN/SaoGoncaloAmarante/_pk0074.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RN/SaoGoncaloAmarante/_pk0074.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RN/SaoGoncaloAmarante/_pk0074.01/nsvia -type f -exec chmod 664 {} \;


# layer via:
rm -rf /tmp/sandbox/_pk7600007401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/0d3ff4b054eecdf731311a1a0198a75084e87727b049ffff93468646f25cb562.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/0d3ff4b054eecdf731311a1a0198a75084e87727b049ffff93468646f25cb562.zip && sudo chmod 664 /var/www/dl.digital-guard.org/0d3ff4b054eecdf731311a1a0198a75084e87727b049ffff93468646f25cb562.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007401101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600007401_001; 7z  x -y /var/www/dl.digital-guard.org/0d3ff4b054eecdf731311a1a0198a75084e87727b049ffff93468646f25cb562.zip "*Arquivos Vetoriais - SGA/Logradouros_2019/mp_eixos_SGAmarante*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
cd /tmp/sandbox/_pk7600007401_001; shp2pgsql -D -W ISO-8859-1  -s 4326 "Arquivos Vetoriais - SGA/Logradouros_2019/mp_eixos_SGAmarante.shp" pk7600007401101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600007401_001/Arquivos Vetoriais - SGA/Logradouros_2019/mp_eixos_SGAmarante.shp','via_full','pk7600007401101_p1_via','7600007401101','0d3ff4b054eecdf731311a1a0198a75084e87727b049ffff93468646f25cb562.zip',array['gid', 'MTR_NO_COM as via', 'MTR_CO_CEP', 'MTR_NO_BR as nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007401101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600007401_001/*Arquivos Vetoriais - SGA/Logradouros_2019/mp_eixos_SGAmarante.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RN/SaoGoncaloAmarante/_pk0074.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RN/SaoGoncaloAmarante/_pk0074.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "CALL ingest.ppublicating_geojsons('via','BR-RN-SaoGoncaloAmarante','/var/gits/_dg/preservCutGeo-BR2021/data/RN/SaoGoncaloAmarante/_pk0074.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RN/SaoGoncaloAmarante/_pk0074.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RN/SaoGoncaloAmarante/_pk0074.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RN/SaoGoncaloAmarante/_pk0074.01/via -type f -exec chmod 664 {} \;






