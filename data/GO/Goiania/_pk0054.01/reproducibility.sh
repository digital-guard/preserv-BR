#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600005401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600005401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/1fd83fa52b1a8b9179f8e38703b1a33a30256f68994794404acde1ad786dac7e.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/1fd83fa52b1a8b9179f8e38703b1a33a30256f68994794404acde1ad786dac7e.zip && sudo chmod 664 /var/www/dl.digital-guard.org/1fd83fa52b1a8b9179f8e38703b1a33a30256f68994794404acde1ad786dac7e.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005401201_p2_block CASCADE"
cd /tmp/sandbox/_pk7600005401_001; 7z  x -y /var/www/dl.digital-guard.org/1fd83fa52b1a8b9179f8e38703b1a33a30256f68994794404acde1ad786dac7e.zip "*QDR*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600005401_001; shp2pgsql -D   -s 31982 "QDR.shp" pk7600005401201_p2_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600005401_001/QDR.shp','block_none','pk7600005401201_p2_block','7600005401201','1fd83fa52b1a8b9179f8e38703b1a33a30256f68994794404acde1ad786dac7e.zip',array['gid', 'nm_qdr', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005401201_p2_block CASCADE"
rm -f /tmp/sandbox/_pk7600005401_001/*QDR.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-GO-Goiania','/var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/block -type f -exec chmod 664 {} \;






# layer nsvia:
rm -rf /tmp/sandbox/_pk7600005401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600005401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/981d55ac26d0131ff4040aeca1444ad2310e20b89ceeac70c9d4ca12caf5151b.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/981d55ac26d0131ff4040aeca1444ad2310e20b89ceeac70c9d4ca12caf5151b.zip && sudo chmod 664 /var/www/dl.digital-guard.org/981d55ac26d0131ff4040aeca1444ad2310e20b89ceeac70c9d4ca12caf5151b.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005401301_p3_nsvia CASCADE"
cd /tmp/sandbox/_pk7600005401_001; 7z  x -y /var/www/dl.digital-guard.org/981d55ac26d0131ff4040aeca1444ad2310e20b89ceeac70c9d4ca12caf5151b.zip "*BAI*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600005401_001; shp2pgsql -D   -s 31982 "BAI.shp" pk7600005401301_p3_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600005401_001/BAI.shp','nsvia_full','pk7600005401301_p3_nsvia','7600005401301','981d55ac26d0131ff4040aeca1444ad2310e20b89ceeac70c9d4ca12caf5151b.zip',array['gid', 'nm AS nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005401301_p3_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600005401_001/*BAI.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-GO-Goiania','/var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600005401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600005401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/db2d3b64a2494ff53212d276645986490890025d2b5d1fc5a1b90af7e7bbdf39.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/db2d3b64a2494ff53212d276645986490890025d2b5d1fc5a1b90af7e7bbdf39.zip && sudo chmod 664 /var/www/dl.digital-guard.org/db2d3b64a2494ff53212d276645986490890025d2b5d1fc5a1b90af7e7bbdf39.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005401101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600005401_001; 7z  x -y /var/www/dl.digital-guard.org/db2d3b64a2494ff53212d276645986490890025d2b5d1fc5a1b90af7e7bbdf39.zip "*LOT*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600005401_001; shp2pgsql -D   -s 31982 "LOT.shp" pk7600005401101_p1_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600005401_001/LOT.shp','parcel_none','pk7600005401101_p1_parcel','7600005401101','db2d3b64a2494ff53212d276645986490890025d2b5d1fc5a1b90af7e7bbdf39.zip',array['gid', 'id', 'nm_lot', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005401101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600005401_001/*LOT.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-GO-Goiania','/var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600005401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600005401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/926566fc01aa45a22ede663e66e371ce9e70e730e7f4e28b10b3bdf19d67fd38.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/926566fc01aa45a22ede663e66e371ce9e70e730e7f4e28b10b3bdf19d67fd38.zip && sudo chmod 664 /var/www/dl.digital-guard.org/926566fc01aa45a22ede663e66e371ce9e70e730e7f4e28b10b3bdf19d67fd38.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005401401_p4_via CASCADE"
cd /tmp/sandbox/_pk7600005401_001; 7z  x -y /var/www/dl.digital-guard.org/926566fc01aa45a22ede663e66e371ce9e70e730e7f4e28b10b3bdf19d67fd38.zip "*SEG*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600005401_001; shp2pgsql -D   -s 31982 "SEG.shp" pk7600005401401_p4_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw4_pk7600005401401_p4_via AS SELECT gid, tp_log || ' ' || nm_log AS via, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/SEG.shp','via_full','vw4_pk7600005401401_p4_via','7600005401401','926566fc01aa45a22ede663e66e371ce9e70e730e7f4e28b10b3bdf19d67fd38.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw4_pk7600005401401_p4_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005401401_p4_via CASCADE"
rm -f /tmp/sandbox/_pk7600005401_001/*SEG.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-GO-Goiania','/var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/GO/Goiania/_pk0054.01/via -type f -exec chmod 664 {} \;




