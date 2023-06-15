#!/bin/bash








# layer nsvia:
rm -rf /tmp/sandbox/_pk7600003401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600003401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/ca5dab519aae0b5cfbc6f8930641c0cce2abbc34c25e306b3fe0aea87df34b74.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/ca5dab519aae0b5cfbc6f8930641c0cce2abbc34c25e306b3fe0aea87df34b74.rar && sudo chmod 664 /var/www/dl.digital-guard.org/ca5dab519aae0b5cfbc6f8930641c0cce2abbc34c25e306b3fe0aea87df34b74.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003401101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk7600003401_001; 7z  x -y /var/www/dl.digital-guard.org/ca5dab519aae0b5cfbc6f8930641c0cce2abbc34c25e306b3fe0aea87df34b74.rar "*Open Street/PARCELAMENTOS*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31981"
cd /tmp/sandbox/_pk7600003401_001; shp2pgsql -D   -s 31981 "Open Street/PARCELAMENTOS.shp" pk7600003401101_p1_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600003401_001/Open Street/PARCELAMENTOS.shp','nsvia_full','pk7600003401101_p1_nsvia','7600003401101','ca5dab519aae0b5cfbc6f8930641c0cce2abbc34c25e306b3fe0aea87df34b74.rar',array['gid', 'NOME', 'BAIRRO AS nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003401101_p1_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600003401_001/*Open Street/PARCELAMENTOS.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/MS/CampoGrande/_pk0034.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/MS/CampoGrande/_pk0034.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-MS-CampoGrande','/var/gits/_dg/preservCutGeo-BR2021/data/MS/CampoGrande/_pk0034.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/MS/CampoGrande/_pk0034.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MS/CampoGrande/_pk0034.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MS/CampoGrande/_pk0034.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600003401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600003401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/ca5dab519aae0b5cfbc6f8930641c0cce2abbc34c25e306b3fe0aea87df34b74.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/ca5dab519aae0b5cfbc6f8930641c0cce2abbc34c25e306b3fe0aea87df34b74.rar && sudo chmod 664 /var/www/dl.digital-guard.org/ca5dab519aae0b5cfbc6f8930641c0cce2abbc34c25e306b3fe0aea87df34b74.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003401101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600003401_001; 7z  x -y /var/www/dl.digital-guard.org/ca5dab519aae0b5cfbc6f8930641c0cce2abbc34c25e306b3fe0aea87df34b74.rar "*Open Street/IMOVEL_2020_Logradouro*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31981"
cd /tmp/sandbox/_pk7600003401_001; shp2pgsql -D   -s 31981 "Open Street/IMOVEL_2020_Logradouro.shp" pk7600003401101_p1_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600003401_001/Open Street/IMOVEL_2020_Logradouro.shp','parcel_full','pk7600003401101_p1_parcel','7600003401101','ca5dab519aae0b5cfbc6f8930641c0cce2abbc34c25e306b3fe0aea87df34b74.rar',array['gid', 'RUAIMO AS via', 'NRPORTA AS hnum', 'COMPLEMENT AS house_info', 'QUADRA', 'LOTE', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003401101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600003401_001/*Open Street/IMOVEL_2020_Logradouro.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/MS/CampoGrande/_pk0034.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/MS/CampoGrande/_pk0034.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-MS-CampoGrande','/var/gits/_dg/preservCutGeo-BR2021/data/MS/CampoGrande/_pk0034.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/MS/CampoGrande/_pk0034.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MS/CampoGrande/_pk0034.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MS/CampoGrande/_pk0034.01/parcel -type f -exec chmod 664 {} \;





