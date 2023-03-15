#!/bin/bash








# layer nsvia:
rm -rf /tmp/sandbox/_pk7600010601_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600010601_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/e5b42971d89614a91b1f503345be4248b73cee7528a93a3b0bbd519ed972ce91.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/e5b42971d89614a91b1f503345be4248b73cee7528a93a3b0bbd519ed972ce91.rar && sudo chmod 664 /var/www/dl.digital-guard.org/e5b42971d89614a91b1f503345be4248b73cee7528a93a3b0bbd519ed972ce91.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600010601201_p2_nsvia CASCADE"
cd /tmp/sandbox/_pk7600010601_001; 7z  x -y /var/www/dl.digital-guard.org/e5b42971d89614a91b1f503345be4248b73cee7528a93a3b0bbd519ed972ce91.rar "*LIM_Bairros_V1*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600010601_001; shp2pgsql -D   -s 31982 "LIM_Bairros_V1.shp" pk7600010601201_p2_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600010601_001/LIM_Bairros_V1.shp','nsvia_full','pk7600010601201_p2_nsvia','7600010601201','e5b42971d89614a91b1f503345be4248b73cee7528a93a3b0bbd519ed972ce91.rar',array['BAIRROS as nsvia'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600010601201_p2_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600010601_001/*LIM_Bairros_V1.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PR/Londrina/_pk0106.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PR/Londrina/_pk0106.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-PR-Londrina','/var/gits/_dg/preservCutGeo-BR2021/data/PR/Londrina/_pk0106.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PR/Londrina/_pk0106.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Londrina/_pk0106.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Londrina/_pk0106.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600010601_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600010601_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/8826fc166ad990ec171f0671ee193f79d2a5f35dbc93c227cd7097e7fe19b525.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/8826fc166ad990ec171f0671ee193f79d2a5f35dbc93c227cd7097e7fe19b525.rar && sudo chmod 664 /var/www/dl.digital-guard.org/8826fc166ad990ec171f0671ee193f79d2a5f35dbc93c227cd7097e7fe19b525.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600010601301_p3_parcel CASCADE"
cd /tmp/sandbox/_pk7600010601_001; 7z  x -y /var/www/dl.digital-guard.org/8826fc166ad990ec171f0671ee193f79d2a5f35dbc93c227cd7097e7fe19b525.rar "*shp/bclotes*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600010601_001; shp2pgsql -D   -s 31982 "shp/bclotes.shp" pk7600010601301_p3_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600010601_001/shp/bclotes.shp','parcel_none','pk7600010601301_p3_parcel','7600010601301','8826fc166ad990ec171f0671ee193f79d2a5f35dbc93c227cd7097e7fe19b525.rar',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600010601301_p3_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600010601_001/*shp/bclotes.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PR/Londrina/_pk0106.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PR/Londrina/_pk0106.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-PR-Londrina','/var/gits/_dg/preservCutGeo-BR2021/data/PR/Londrina/_pk0106.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PR/Londrina/_pk0106.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Londrina/_pk0106.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Londrina/_pk0106.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600010601_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600010601_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/b1cc16e9070aa2c624d1eeebde8a00e4b9bea471fb76a79c4f8ec5902c250c3e.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/b1cc16e9070aa2c624d1eeebde8a00e4b9bea471fb76a79c4f8ec5902c250c3e.rar && sudo chmod 664 /var/www/dl.digital-guard.org/b1cc16e9070aa2c624d1eeebde8a00e4b9bea471fb76a79c4f8ec5902c250c3e.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600010601101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600010601_001; 7z  x -y /var/www/dl.digital-guard.org/b1cc16e9070aa2c624d1eeebde8a00e4b9bea471fb76a79c4f8ec5902c250c3e.rar "*Export_Output*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600010601_001; shp2pgsql -D   -s 31982 "Export_Output.shp" pk7600010601101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600010601_001/Export_Output.shp','via_full','pk7600010601101_p1_via','7600010601101','b1cc16e9070aa2c624d1eeebde8a00e4b9bea471fb76a79c4f8ec5902c250c3e.rar',array['NOME as via'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600010601101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600010601_001/*Export_Output.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PR/Londrina/_pk0106.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PR/Londrina/_pk0106.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-PR-Londrina','/var/gits/_dg/preservCutGeo-BR2021/data/PR/Londrina/_pk0106.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PR/Londrina/_pk0106.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Londrina/_pk0106.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/Londrina/_pk0106.01/via -type f -exec chmod 664 {} \;




