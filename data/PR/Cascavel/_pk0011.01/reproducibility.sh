#!/bin/bash








# layer nsvia:
rm -rf /tmp/sandbox/_pk7600001101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600001101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/305df61c61e90caef0a0409a09b7d01a56beb6e107ae4430188617c7058f02a1.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/305df61c61e90caef0a0409a09b7d01a56beb6e107ae4430188617c7058f02a1.zip && sudo chmod 664 /var/www/dl.digital-guard.org/305df61c61e90caef0a0409a09b7d01a56beb6e107ae4430188617c7058f02a1.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001101101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk7600001101_001; 7z  x -y /var/www/dl.digital-guard.org/305df61c61e90caef0a0409a09b7d01a56beb6e107ae4430188617c7058f02a1.zip "*Bairros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600001101_001; shp2pgsql -D -W ISO-8859-1  -s 31982 "Bairros.shp" pk7600001101101_p1_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600001101_001/Bairros.shp','nsvia_full','pk7600001101101_p1_nsvia','7600001101101','305df61c61e90caef0a0409a09b7d01a56beb6e107ae4430188617c7058f02a1.zip',array['gid', 'nmbairro AS nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001101101_p1_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600001101_001/*Bairros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PR/Cascavel/_pk0011.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PR/Cascavel/_pk0011.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-PR-Cascavel','/var/gits/_dg/preservCutGeo-BR2021/data/PR/Cascavel/_pk0011.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PR/Cascavel/_pk0011.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Cascavel/_pk0011.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Cascavel/_pk0011.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600001101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600001101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/ae8dc027fe9e0983b553508c3a313061f7f466c50d66124c86c96254f70c4c15.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/ae8dc027fe9e0983b553508c3a313061f7f466c50d66124c86c96254f70c4c15.zip && sudo chmod 664 /var/www/dl.digital-guard.org/ae8dc027fe9e0983b553508c3a313061f7f466c50d66124c86c96254f70c4c15.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001101301_p3_parcel CASCADE"
cd /tmp/sandbox/_pk7600001101_001; 7z  x -y /var/www/dl.digital-guard.org/ae8dc027fe9e0983b553508c3a313061f7f466c50d66124c86c96254f70c4c15.zip "*Lotes*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600001101_001; shp2pgsql -D -W ISO-8859-1  -s 31982 "Lotes.shp" pk7600001101301_p3_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600001101_001/Lotes.shp','parcel_full','pk7600001101301_p3_parcel','7600001101301','ae8dc027fe9e0983b553508c3a313061f7f466c50d66124c86c96254f70c4c15.zip',array['gid', 'logradouro AS via', 'numerologr AS hnum', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001101301_p3_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600001101_001/*Lotes.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PR/Cascavel/_pk0011.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PR/Cascavel/_pk0011.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-PR-Cascavel','/var/gits/_dg/preservCutGeo-BR2021/data/PR/Cascavel/_pk0011.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PR/Cascavel/_pk0011.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Cascavel/_pk0011.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Cascavel/_pk0011.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600001101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600001101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/f4fe1f604f927b1d07ae56ec11ea9e3c4c64a4d02c01ce80ad041beadab165dc.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/f4fe1f604f927b1d07ae56ec11ea9e3c4c64a4d02c01ce80ad041beadab165dc.zip && sudo chmod 664 /var/www/dl.digital-guard.org/f4fe1f604f927b1d07ae56ec11ea9e3c4c64a4d02c01ce80ad041beadab165dc.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001101201_p2_via CASCADE"
cd /tmp/sandbox/_pk7600001101_001; 7z  x -y /var/www/dl.digital-guard.org/f4fe1f604f927b1d07ae56ec11ea9e3c4c64a4d02c01ce80ad041beadab165dc.zip "*Logradouros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600001101_001; shp2pgsql -D   -s 31982 "Logradouros.shp" pk7600001101201_p2_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw2_pk7600001101201_p2_via AS SELECT gid, tipolograd || ' ' || nmlogradou AS via, geom  FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/Logradouros.shp','via_full','vw2_pk7600001101201_p2_via','7600001101201','f4fe1f604f927b1d07ae56ec11ea9e3c4c64a4d02c01ce80ad041beadab165dc.zip',array[]::text[],5,2)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw2_pk7600001101201_p2_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001101201_p2_via CASCADE"
rm -f /tmp/sandbox/_pk7600001101_001/*Logradouros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PR/Cascavel/_pk0011.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PR/Cascavel/_pk0011.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-PR-Cascavel','/var/gits/_dg/preservCutGeo-BR2021/data/PR/Cascavel/_pk0011.01/via','2',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PR/Cascavel/_pk0011.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Cascavel/_pk0011.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Cascavel/_pk0011.01/via -type f -exec chmod 664 {} \;




