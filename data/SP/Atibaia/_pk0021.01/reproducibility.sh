#!/bin/bash



# layer building:
rm -rf /tmp/sandbox/_pk7600002101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/6d741572b6c31ffd82cf004b92fa98056545df805bcb64afba5e7b26e32b62ab.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/6d741572b6c31ffd82cf004b92fa98056545df805bcb64afba5e7b26e32b62ab.zip && sudo chmod 664 /var/www/dl.digital-guard.org/6d741572b6c31ffd82cf004b92fa98056545df805bcb64afba5e7b26e32b62ab.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002101301_p3_building CASCADE"
cd /tmp/sandbox/_pk7600002101_001; 7z  x -y /var/www/dl.digital-guard.org/6d741572b6c31ffd82cf004b92fa98056545df805bcb64afba5e7b26e32b62ab.zip "*edificacoes/edificacoes*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=3857"
cd /tmp/sandbox/_pk7600002101_001; shp2pgsql -D -W UTF-8  -s 3857 "edificacoes/edificacoes.shp" pk7600002101301_p3_building | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw3_pk7600002101301_p3_building AS SELECT gid, 'yes' AS building, numero as hnum, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/edificacoes/edificacoes.shp','building_full','vw3_pk7600002101301_p3_building','7600002101301','6d741572b6c31ffd82cf004b92fa98056545df805bcb64afba5e7b26e32b62ab.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw3_pk7600002101301_p3_building"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002101301_p3_building CASCADE"
rm -f /tmp/sandbox/_pk7600002101_001/*edificacoes/edificacoes.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/building
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/building/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('building','BR-SP-Atibaia','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/building','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/building
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/building -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/building -type f -exec chmod 664 {} \;






# layer parcel:
rm -rf /tmp/sandbox/_pk7600002101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/b6221fa57754ec8c4db284591a6ceeea7acf986eb215b2e521647e32fb175488.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/b6221fa57754ec8c4db284591a6ceeea7acf986eb215b2e521647e32fb175488.zip && sudo chmod 664 /var/www/dl.digital-guard.org/b6221fa57754ec8c4db284591a6ceeea7acf986eb215b2e521647e32fb175488.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002101201_p2_parcel CASCADE"
cd /tmp/sandbox/_pk7600002101_001; 7z  x -y /var/www/dl.digital-guard.org/b6221fa57754ec8c4db284591a6ceeea7acf986eb215b2e521647e32fb175488.zip "*lotes/lotes*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=29193"
cd /tmp/sandbox/_pk7600002101_001; shp2pgsql -D   -s 29193 "lotes/lotes.shp" pk7600002101201_p2_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600002101_001/lotes/lotes.shp','parcel_none','pk7600002101201_p2_parcel','7600002101201','b6221fa57754ec8c4db284591a6ceeea7acf986eb215b2e521647e32fb175488.zip',array['gid', 'num as hnum', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002101201_p2_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600002101_001/*lotes/lotes.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-SP-Atibaia','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600002101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/0a7fedd6e8e30541f706fa7f77166a183a3cc43d2b1d3d3d0a8d3fb7f077e804.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/0a7fedd6e8e30541f706fa7f77166a183a3cc43d2b1d3d3d0a8d3fb7f077e804.zip && sudo chmod 664 /var/www/dl.digital-guard.org/0a7fedd6e8e30541f706fa7f77166a183a3cc43d2b1d3d3d0a8d3fb7f077e804.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002101101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600002101_001; 7z  x -y /var/www/dl.digital-guard.org/0a7fedd6e8e30541f706fa7f77166a183a3cc43d2b1d3d3d0a8d3fb7f077e804.zip "*logradouros/CAD_LOG*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=29193"
cd /tmp/sandbox/_pk7600002101_001; shp2pgsql -D   -s 29193 "logradouros/CAD_LOG.shp" pk7600002101101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600002101_001/logradouros/CAD_LOG.shp','via_full','pk7600002101101_p1_via','7600002101101','0a7fedd6e8e30541f706fa7f77166a183a3cc43d2b1d3d3d0a8d3fb7f077e804.zip',array['gid', 'log_nome_c as via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002101101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600002101_001/*logradouros/CAD_LOG.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-SP-Atibaia','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/via -type f -exec chmod 664 {} \;




