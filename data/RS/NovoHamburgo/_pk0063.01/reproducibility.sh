#!/bin/bash



# layer building:
rm -rf /tmp/sandbox/_pk7600006301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600006301_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/830b546ac5cdc4290fdcdb04654f731704b494f474e5dded78acfd651139f3a5.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/830b546ac5cdc4290fdcdb04654f731704b494f474e5dded78acfd651139f3a5.zip && sudo chmod 664 /var/www/dl.digital-guard.org/830b546ac5cdc4290fdcdb04654f731704b494f474e5dded78acfd651139f3a5.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006301101_p1_building CASCADE"
cd /tmp/sandbox/_pk7600006301_001; 7z  x -y /var/www/dl.digital-guard.org/830b546ac5cdc4290fdcdb04654f731704b494f474e5dded78acfd651139f3a5.zip "*edificacoes*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600006301_001; shp2pgsql -D   -s 31982 "edificacoes.shp" pk7600006301101_p1_building | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600006301101_p1_building AS SELECT gid, 'yes' AS building, tx_numero AS hnum, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/edificacoes.shp','building_full','vw1_pk7600006301101_p1_building','7600006301101','830b546ac5cdc4290fdcdb04654f731704b494f474e5dded78acfd651139f3a5.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600006301101_p1_building"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006301101_p1_building CASCADE"
rm -f /tmp/sandbox/_pk7600006301_001/*edificacoes.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/building
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/building/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('building','BR-RS-NovoHamburgo','/var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/building','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/building
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/building -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/building -type f -exec chmod 664 {} \;





# layer nsvia:
rm -rf /tmp/sandbox/_pk7600006301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600006301_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/375a3906c90abe84e3dc3a6e7dbc81d985dc3779b00e4c3cebf35bcc6ff2067f.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/375a3906c90abe84e3dc3a6e7dbc81d985dc3779b00e4c3cebf35bcc6ff2067f.zip && sudo chmod 664 /var/www/dl.digital-guard.org/375a3906c90abe84e3dc3a6e7dbc81d985dc3779b00e4c3cebf35bcc6ff2067f.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006301201_p2_nsvia CASCADE"
cd /tmp/sandbox/_pk7600006301_001; 7z  x -y /var/www/dl.digital-guard.org/375a3906c90abe84e3dc3a6e7dbc81d985dc3779b00e4c3cebf35bcc6ff2067f.zip "*bairros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600006301_001; shp2pgsql -D   -s 31982 "bairros.shp" pk7600006301201_p2_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600006301_001/bairros.shp','nsvia_full','pk7600006301201_p2_nsvia','7600006301201','375a3906c90abe84e3dc3a6e7dbc81d985dc3779b00e4c3cebf35bcc6ff2067f.zip',array['gid', 'chave as nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006301201_p2_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600006301_001/*bairros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-RS-NovoHamburgo','/var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600006301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600006301_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/eb69ff81ddacf4fc1c1eb0a099102f365646d8bd4d227f27d930ad78c22ff9b5.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/eb69ff81ddacf4fc1c1eb0a099102f365646d8bd4d227f27d930ad78c22ff9b5.zip && sudo chmod 664 /var/www/dl.digital-guard.org/eb69ff81ddacf4fc1c1eb0a099102f365646d8bd4d227f27d930ad78c22ff9b5.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006301401_p4_parcel CASCADE"
cd /tmp/sandbox/_pk7600006301_001; 7z  x -y /var/www/dl.digital-guard.org/eb69ff81ddacf4fc1c1eb0a099102f365646d8bd4d227f27d930ad78c22ff9b5.zip "*lotes*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600006301_001; shp2pgsql -D   -s 31982 "lotes.shp" pk7600006301401_p4_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600006301_001/lotes.shp','parcel_none','pk7600006301401_p4_parcel','7600006301401','eb69ff81ddacf4fc1c1eb0a099102f365646d8bd4d227f27d930ad78c22ff9b5.zip',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006301401_p4_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600006301_001/*lotes.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-RS-NovoHamburgo','/var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600006301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600006301_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/920d3a2f5e1c031a965f94ea48b243018780712c21a02903e7d0cec4d7cea06f.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/920d3a2f5e1c031a965f94ea48b243018780712c21a02903e7d0cec4d7cea06f.zip && sudo chmod 664 /var/www/dl.digital-guard.org/920d3a2f5e1c031a965f94ea48b243018780712c21a02903e7d0cec4d7cea06f.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006301301_p3_via CASCADE"
cd /tmp/sandbox/_pk7600006301_001; 7z  x -y /var/www/dl.digital-guard.org/920d3a2f5e1c031a965f94ea48b243018780712c21a02903e7d0cec4d7cea06f.zip "*logradouros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600006301_001; shp2pgsql -D   -s 31982 "logradouros.shp" pk7600006301301_p3_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600006301_001/logradouros.shp','via_full','pk7600006301301_p3_via','7600006301301','920d3a2f5e1c031a965f94ea48b243018780712c21a02903e7d0cec4d7cea06f.zip',array['gid', 'nome AS via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006301301_p3_via CASCADE"
rm -f /tmp/sandbox/_pk7600006301_001/*logradouros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-RS-NovoHamburgo','/var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/NovoHamburgo/_pk0063.01/via -type f -exec chmod 664 {} \;




