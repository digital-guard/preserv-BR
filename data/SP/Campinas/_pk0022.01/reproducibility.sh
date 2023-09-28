#!/bin/bash







# layer geoaddress:
rm -rf /tmp/sandbox/_pk7600002201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/6bb020e023ffd10570d887f907fdad909eecde1003c8911ef64ac63d48f5fe8b.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/6bb020e023ffd10570d887f907fdad909eecde1003c8911ef64ac63d48f5fe8b.zip && sudo chmod 664 /var/www/dl.digital-guard.org/6bb020e023ffd10570d887f907fdad909eecde1003c8911ef64ac63d48f5fe8b.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002201201_p2_geoaddress CASCADE"
cd /tmp/sandbox/_pk7600002201_001; 7z  x -y /var/www/dl.digital-guard.org/6bb020e023ffd10570d887f907fdad909eecde1003c8911ef64ac63d48f5fe8b.zip "*256b0041-6e29-1649-4b2b-00006944c8fb*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600002201_001; shp2pgsql -D   -s 31983 "256b0041-6e29-1649-4b2b-00006944c8fb.shp" pk7600002201201_p2_geoaddress | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600002201_001/256b0041-6e29-1649-4b2b-00006944c8fb.shp','geoaddress_none','pk7600002201201_p2_geoaddress','7600002201201','6bb020e023ffd10570d887f907fdad909eecde1003c8911ef64ac63d48f5fe8b.zip',array['gid', 'geom'],1,2)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002201201_p2_geoaddress CASCADE"
rm -f /tmp/sandbox/_pk7600002201_001/*256b0041-6e29-1649-4b2b-00006944c8fb.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Campinas/_pk0022.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Campinas/_pk0022.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','BR-SP-Campinas','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Campinas/_pk0022.01/geoaddress','2',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Campinas/_pk0022.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Campinas/_pk0022.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Campinas/_pk0022.01/geoaddress -type f -exec chmod 664 {} \;



# layer via:
rm -rf /tmp/sandbox/_pk7600002201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/b594f8717d9912e25938029f8ac55eb5842b561ff29d9768c5b77489945a9c1c.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/b594f8717d9912e25938029f8ac55eb5842b561ff29d9768c5b77489945a9c1c.zip && sudo chmod 664 /var/www/dl.digital-guard.org/b594f8717d9912e25938029f8ac55eb5842b561ff29d9768c5b77489945a9c1c.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002201101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600002201_001; 7z  x -y /var/www/dl.digital-guard.org/b594f8717d9912e25938029f8ac55eb5842b561ff29d9768c5b77489945a9c1c.zip "*5486431b-c7fe-aec8-ab9c-00004b294da9*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600002201_001; shp2pgsql -D   -s 31983 "5486431b-c7fe-aec8-ab9c-00004b294da9.shp" pk7600002201101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600002201_001/5486431b-c7fe-aec8-ab9c-00004b294da9.shp','via_none','pk7600002201101_p1_via','7600002201101','b594f8717d9912e25938029f8ac55eb5842b561ff29d9768c5b77489945a9c1c.zip',array['gid', 'LOGRADOURO AS via', 'geom'],5,2)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002201101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600002201_001/*5486431b-c7fe-aec8-ab9c-00004b294da9.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Campinas/_pk0022.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Campinas/_pk0022.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-SP-Campinas','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Campinas/_pk0022.01/via','2',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Campinas/_pk0022.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Campinas/_pk0022.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Campinas/_pk0022.01/via -type f -exec chmod 664 {} \;




