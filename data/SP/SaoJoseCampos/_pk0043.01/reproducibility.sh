#!/bin/bash








# layer nsvia:
rm -rf /tmp/sandbox/_pk7600004301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600004301_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/12fce79183bf495632c96e64708877eab12ffaf6f4f2d6f465d2cf7afff1369d.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/12fce79183bf495632c96e64708877eab12ffaf6f4f2d6f465d2cf7afff1369d.zip && sudo chmod 664 /var/www/dl.digital-guard.org/12fce79183bf495632c96e64708877eab12ffaf6f4f2d6f465d2cf7afff1369d.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600004301101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk7600004301_001; 7z  x -y /var/www/dl.digital-guard.org/12fce79183bf495632c96e64708877eab12ffaf6f4f2d6f465d2cf7afff1369d.zip "*BAIRROS*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600004301_001; shp2pgsql -D   -s 31983 "BAIRROS.shp" pk7600004301101_p1_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600004301_001/BAIRROS.shp','nsvia_full','pk7600004301101_p1_nsvia','7600004301101','12fce79183bf495632c96e64708877eab12ffaf6f4f2d6f465d2cf7afff1369d.zip',array['gid', 'bairro as nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600004301101_p1_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600004301_001/*BAIRROS.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoJoseCampos/_pk0043.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoJoseCampos/_pk0043.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "CALL ingest.ppublicating_geojsons('nsvia','BR-SP-SaoJoseCampos','/var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoJoseCampos/_pk0043.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoJoseCampos/_pk0043.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoJoseCampos/_pk0043.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoJoseCampos/_pk0043.01/nsvia -type f -exec chmod 664 {} \;


# layer via:
rm -rf /tmp/sandbox/_pk7600004301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600004301_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/6effb451da343480c3acca559cf55536315c104974fb00f9c9d46b6034e1b2aa.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/6effb451da343480c3acca559cf55536315c104974fb00f9c9d46b6034e1b2aa.zip && sudo chmod 664 /var/www/dl.digital-guard.org/6effb451da343480c3acca559cf55536315c104974fb00f9c9d46b6034e1b2aa.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600004301201_p2_via CASCADE"
cd /tmp/sandbox/_pk7600004301_001; 7z  x -y /var/www/dl.digital-guard.org/6effb451da343480c3acca559cf55536315c104974fb00f9c9d46b6034e1b2aa.zip "*LOGRADOUROS*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600004301_001; shp2pgsql -D   -s 31983 "LOGRADOUROS.shp" pk7600004301201_p2_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600004301_001/LOGRADOUROS.shp','via_full','pk7600004301201_p2_via','7600004301201','6effb451da343480c3acca559cf55536315c104974fb00f9c9d46b6034e1b2aa.zip',array['gid', 'nome as via', 'ref', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600004301201_p2_via CASCADE"
rm -f /tmp/sandbox/_pk7600004301_001/*LOGRADOUROS.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoJoseCampos/_pk0043.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoJoseCampos/_pk0043.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "CALL ingest.ppublicating_geojsons('via','BR-SP-SaoJoseCampos','/var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoJoseCampos/_pk0043.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoJoseCampos/_pk0043.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoJoseCampos/_pk0043.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoJoseCampos/_pk0043.01/via -type f -exec chmod 664 {} \;






