#!/bin/bash









# layer parcel:
rm -rf /tmp/sandbox/_pk7600003101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600003101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/3c89fd728a33d781a60088e8b384295e92e70c96b6c9fed78bd4f36f819df67a.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/3c89fd728a33d781a60088e8b384295e92e70c96b6c9fed78bd4f36f819df67a.zip && sudo chmod 664 /var/www/dl.digital-guard.org/3c89fd728a33d781a60088e8b384295e92e70c96b6c9fed78bd4f36f819df67a.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003101101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600003101_001; 7z  x -y /var/www/dl.digital-guard.org/3c89fd728a33d781a60088e8b384295e92e70c96b6c9fed78bd4f36f819df67a.zip "*lotes_prediais*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600003101_001; shp2pgsql -D -W ISO-8859-1  -s 31983 "lotes_prediais.shp" pk7600003101101_p1_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600003101101_p1_parcel AS SELECT gid, complement, \"número por\" AS hnum, split_part(\"tipo do lo\",'|',2) || ' ' || \"nome do lo\" AS via, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/lotes_prediais.shp','parcel_full','vw1_pk7600003101101_p1_parcel','7600003101101','3c89fd728a33d781a60088e8b384295e92e70c96b6c9fed78bd4f36f819df67a.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600003101101_p1_parcel"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003101101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600003101_001/*lotes_prediais.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Sorocaba/_pk0031.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Sorocaba/_pk0031.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-SP-Sorocaba','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Sorocaba/_pk0031.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Sorocaba/_pk0031.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Sorocaba/_pk0031.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Sorocaba/_pk0031.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600003101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600003101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/f88024120a0355a4a9c5ee990c31a41a031a06c25e82eca5e7320d00030edb36.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/f88024120a0355a4a9c5ee990c31a41a031a06c25e82eca5e7320d00030edb36.zip && sudo chmod 664 /var/www/dl.digital-guard.org/f88024120a0355a4a9c5ee990c31a41a031a06c25e82eca5e7320d00030edb36.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003101201_p2_via CASCADE"
cd /tmp/sandbox/_pk7600003101_001; 7z  x -y /var/www/dl.digital-guard.org/f88024120a0355a4a9c5ee990c31a41a031a06c25e82eca5e7320d00030edb36.zip "*eixos_sorocaba*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=5533"
cd /tmp/sandbox/_pk7600003101_001; shp2pgsql -D -W ISO-8859-1  -s 5533 "eixos_sorocaba.shp" pk7600003101201_p2_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw2_pk7600003101201_p2_via AS SELECT gid, TIPO || ' ' || NOME AS via, BAIRRO AS nsvia, IMPLANTADO, CLANDESTIN, SITUACAO, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/eixos_sorocaba.shp','via_full','vw2_pk7600003101201_p2_via','7600003101201','f88024120a0355a4a9c5ee990c31a41a031a06c25e82eca5e7320d00030edb36.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw2_pk7600003101201_p2_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003101201_p2_via CASCADE"
rm -f /tmp/sandbox/_pk7600003101_001/*eixos_sorocaba.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Sorocaba/_pk0031.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Sorocaba/_pk0031.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-SP-Sorocaba','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Sorocaba/_pk0031.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Sorocaba/_pk0031.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Sorocaba/_pk0031.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Sorocaba/_pk0031.01/via -type f -exec chmod 664 {} \;




