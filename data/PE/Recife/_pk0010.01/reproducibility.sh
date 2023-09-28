#!/bin/bash








# layer nsvia:
rm -rf /tmp/sandbox/_pk7600001001_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600001001_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/04fffd56aef1c5a53cb35e5864b940b0b103e6e4752adcff7d4f30a2cb99ddb6.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/04fffd56aef1c5a53cb35e5864b940b0b103e6e4752adcff7d4f30a2cb99ddb6.zip && sudo chmod 664 /var/www/dl.digital-guard.org/04fffd56aef1c5a53cb35e5864b940b0b103e6e4752adcff7d4f30a2cb99ddb6.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001001101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk7600001001_001; 7z  x -y /var/www/dl.digital-guard.org/04fffd56aef1c5a53cb35e5864b940b0b103e6e4752adcff7d4f30a2cb99ddb6.zip "*Bairros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31985"
cd /tmp/sandbox/_pk7600001001_001; shp2pgsql -D -W ISO-8859-1  -s 31985 "Bairros.shp" pk7600001001101_p1_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600001001_001/Bairros.shp','nsvia_full','pk7600001001101_p1_nsvia','7600001001101','04fffd56aef1c5a53cb35e5864b940b0b103e6e4752adcff7d4f30a2cb99ddb6.zip',array['gid', 'EBAIRRNO_1 AS nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001001101_p1_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600001001_001/*Bairros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PE/Recife/_pk0010.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PE/Recife/_pk0010.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-PE-Recife','/var/gits/_dg/preservCutGeo-BR2021/data/PE/Recife/_pk0010.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PE/Recife/_pk0010.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PE/Recife/_pk0010.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PE/Recife/_pk0010.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600001001_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600001001_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/04fffd56aef1c5a53cb35e5864b940b0b103e6e4752adcff7d4f30a2cb99ddb6.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/04fffd56aef1c5a53cb35e5864b940b0b103e6e4752adcff7d4f30a2cb99ddb6.zip && sudo chmod 664 /var/www/dl.digital-guard.org/04fffd56aef1c5a53cb35e5864b940b0b103e6e4752adcff7d4f30a2cb99ddb6.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001001101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600001001_001; 7z  x -y /var/www/dl.digital-guard.org/04fffd56aef1c5a53cb35e5864b940b0b103e6e4752adcff7d4f30a2cb99ddb6.zip "*Lotes*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31985"
cd /tmp/sandbox/_pk7600001001_001; shp2pgsql -D -W ISO-8859-1  -s 31985 "Lotes.shp" pk7600001001101_p1_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600001001_001/Lotes.shp','parcel_full','pk7600001001101_p1_parcel','7600001001101','04fffd56aef1c5a53cb35e5864b940b0b103e6e4752adcff7d4f30a2cb99ddb6.zip',array['gid', 'ENDNUMERO AS hnum', 'QTDPAVIMEN', 'NMEDIFICAC', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001001101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600001001_001/*Lotes.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PE/Recife/_pk0010.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PE/Recife/_pk0010.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-PE-Recife','/var/gits/_dg/preservCutGeo-BR2021/data/PE/Recife/_pk0010.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PE/Recife/_pk0010.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PE/Recife/_pk0010.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PE/Recife/_pk0010.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600001001_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600001001_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/04fffd56aef1c5a53cb35e5864b940b0b103e6e4752adcff7d4f30a2cb99ddb6.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/04fffd56aef1c5a53cb35e5864b940b0b103e6e4752adcff7d4f30a2cb99ddb6.zip && sudo chmod 664 /var/www/dl.digital-guard.org/04fffd56aef1c5a53cb35e5864b940b0b103e6e4752adcff7d4f30a2cb99ddb6.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001001101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600001001_001; 7z  x -y /var/www/dl.digital-guard.org/04fffd56aef1c5a53cb35e5864b940b0b103e6e4752adcff7d4f30a2cb99ddb6.zip "*TrechoLogradouros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31985"
cd /tmp/sandbox/_pk7600001001_001; shp2pgsql -D -W ISO-8859-1  -s 31985 "TrechoLogradouros.shp" pk7600001001101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600001001_001/TrechoLogradouros.shp','via_full','pk7600001001101_p1_via','7600001001101','04fffd56aef1c5a53cb35e5864b940b0b103e6e4752adcff7d4f30a2cb99ddb6.zip',array['gid', 'NLGPAVOFIC AS via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001001101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600001001_001/*TrechoLogradouros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PE/Recife/_pk0010.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PE/Recife/_pk0010.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-PE-Recife','/var/gits/_dg/preservCutGeo-BR2021/data/PE/Recife/_pk0010.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PE/Recife/_pk0010.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PE/Recife/_pk0010.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PE/Recife/_pk0010.01/via -type f -exec chmod 664 {} \;




