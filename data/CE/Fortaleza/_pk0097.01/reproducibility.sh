#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600009701_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600009701_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/82edaae1d8a79f5167d88cb89a09a21f7e2f89bae88d16d39ebbe971a28976d5.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/82edaae1d8a79f5167d88cb89a09a21f7e2f89bae88d16d39ebbe971a28976d5.zip && sudo chmod 664 /var/www/dl.digital-guard.org/82edaae1d8a79f5167d88cb89a09a21f7e2f89bae88d16d39ebbe971a28976d5.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600009701401_p4_block CASCADE"
cd /tmp/sandbox/_pk7600009701_001; 7z  x -y /var/www/dl.digital-guard.org/82edaae1d8a79f5167d88cb89a09a21f7e2f89bae88d16d39ebbe971a28976d5.zip "*quadras*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31984"
cd /tmp/sandbox/_pk7600009701_001; shp2pgsql -D -W ISO-8859-1  -s 31984 "quadras.shp" pk7600009701401_p4_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600009701_001/quadras.shp','block_full','pk7600009701401_p4_block','7600009701401','82edaae1d8a79f5167d88cb89a09a21f7e2f89bae88d16d39ebbe971a28976d5.zip',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600009701401_p4_block CASCADE"
rm -f /tmp/sandbox/_pk7600009701_001/*quadras.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-CE-Fortaleza','/var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/block -type f -exec chmod 664 {} \;

# layer building:
rm -rf /tmp/sandbox/_pk7600009701_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600009701_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/8a07c88d17167f65182a6c1a86fb89842d2e0bfe4ca5f7fc2dba4d41d9f682f9.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/8a07c88d17167f65182a6c1a86fb89842d2e0bfe4ca5f7fc2dba4d41d9f682f9.zip && sudo chmod 664 /var/www/dl.digital-guard.org/8a07c88d17167f65182a6c1a86fb89842d2e0bfe4ca5f7fc2dba4d41d9f682f9.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600009701101_p1_building CASCADE"
cd /tmp/sandbox/_pk7600009701_001; 7z  x -y /var/www/dl.digital-guard.org/8a07c88d17167f65182a6c1a86fb89842d2e0bfe4ca5f7fc2dba4d41d9f682f9.zip "*edificacoes*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31984"
cd /tmp/sandbox/_pk7600009701_001; shp2pgsql -D -W ISO-8859-1  -s 31984 "edificacoes.shp" pk7600009701101_p1_building | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600009701101_p1_building AS SELECT gid, 'yes' AS building, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/edificacoes.shp','building_full','vw1_pk7600009701101_p1_building','7600009701101','8a07c88d17167f65182a6c1a86fb89842d2e0bfe4ca5f7fc2dba4d41d9f682f9.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600009701101_p1_building"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600009701101_p1_building CASCADE"
rm -f /tmp/sandbox/_pk7600009701_001/*edificacoes.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/building
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/building/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('building','BR-CE-Fortaleza','/var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/building','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/building
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/building -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/building -type f -exec chmod 664 {} \;





# layer nsvia:
rm -rf /tmp/sandbox/_pk7600009701_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600009701_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/4c97d93a39cce2190b436b1adf1d56321627fef452dbbf18ede812731e2a035b.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/4c97d93a39cce2190b436b1adf1d56321627fef452dbbf18ede812731e2a035b.zip && sudo chmod 664 /var/www/dl.digital-guard.org/4c97d93a39cce2190b436b1adf1d56321627fef452dbbf18ede812731e2a035b.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600009701501_p5_nsvia CASCADE"
cd /tmp/sandbox/_pk7600009701_001; 7z  x -y /var/www/dl.digital-guard.org/4c97d93a39cce2190b436b1adf1d56321627fef452dbbf18ede812731e2a035b.zip "*bairros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31984"
cd /tmp/sandbox/_pk7600009701_001; shp2pgsql -D -W ISO-8859-1  -s 31984 "bairros.shp" pk7600009701501_p5_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600009701_001/bairros.shp','nsvia_full','pk7600009701501_p5_nsvia','7600009701501','4c97d93a39cce2190b436b1adf1d56321627fef452dbbf18ede812731e2a035b.zip',array['gid', 'nome_bairr as nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600009701501_p5_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600009701_001/*bairros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-CE-Fortaleza','/var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600009701_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600009701_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/d6bfda4f6ec70796d753b570ff04afc040ba6a2c438f116b301a977db3788b5e.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/d6bfda4f6ec70796d753b570ff04afc040ba6a2c438f116b301a977db3788b5e.zip && sudo chmod 664 /var/www/dl.digital-guard.org/d6bfda4f6ec70796d753b570ff04afc040ba6a2c438f116b301a977db3788b5e.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600009701201_p2_parcel CASCADE"
cd /tmp/sandbox/_pk7600009701_001; 7z  x -y /var/www/dl.digital-guard.org/d6bfda4f6ec70796d753b570ff04afc040ba6a2c438f116b301a977db3788b5e.zip "*lotes_fiscais*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31984"
cd /tmp/sandbox/_pk7600009701_001; shp2pgsql -D -W ISO-8859-1  -s 31984 "lotes_fiscais.shp" pk7600009701201_p2_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw2_pk7600009701201_p2_parcel AS SELECT gid, split_part(endereco,',',1) AS hnum, split_part(endereco,',',2) AS via, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/lotes_fiscais.shp','parcel_none','vw2_pk7600009701201_p2_parcel','7600009701201','d6bfda4f6ec70796d753b570ff04afc040ba6a2c438f116b301a977db3788b5e.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw2_pk7600009701201_p2_parcel"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600009701201_p2_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600009701_001/*lotes_fiscais.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-CE-Fortaleza','/var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600009701_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600009701_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/86c7283d4dc0351e397e72934f96141f55b92dc09112462cad3769649c0f8fec.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/86c7283d4dc0351e397e72934f96141f55b92dc09112462cad3769649c0f8fec.zip && sudo chmod 664 /var/www/dl.digital-guard.org/86c7283d4dc0351e397e72934f96141f55b92dc09112462cad3769649c0f8fec.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600009701301_p3_via CASCADE"
cd /tmp/sandbox/_pk7600009701_001; 7z  x -y /var/www/dl.digital-guard.org/86c7283d4dc0351e397e72934f96141f55b92dc09112462cad3769649c0f8fec.zip "*logradouros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31984"
cd /tmp/sandbox/_pk7600009701_001; shp2pgsql -D -W ISO-8859-1  -s 31984 "logradouros.shp" pk7600009701301_p3_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600009701_001/logradouros.shp','via_full','pk7600009701301_p3_via','7600009701301','86c7283d4dc0351e397e72934f96141f55b92dc09112462cad3769649c0f8fec.zip',array['gid', 'nome_compl as via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600009701301_p3_via CASCADE"
rm -f /tmp/sandbox/_pk7600009701_001/*logradouros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-CE-Fortaleza','/var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/CE/Fortaleza/_pk0097.01/via -type f -exec chmod 664 {} \;




