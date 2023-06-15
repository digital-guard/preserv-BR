#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600004201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600004201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/73d02ba0ae4b0a994a629f7d06f0a027259f5c1d97e53f9b771fecd345c2a02b.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/73d02ba0ae4b0a994a629f7d06f0a027259f5c1d97e53f9b771fecd345c2a02b.zip && sudo chmod 664 /var/www/dl.digital-guard.org/73d02ba0ae4b0a994a629f7d06f0a027259f5c1d97e53f9b771fecd345c2a02b.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600004201201_p2_block CASCADE"
cd /tmp/sandbox/_pk7600004201_001; 7z  x -y /var/www/dl.digital-guard.org/73d02ba0ae4b0a994a629f7d06f0a027259f5c1d97e53f9b771fecd345c2a02b.zip "*rb_20201111/quadras*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=32719"
cd /tmp/sandbox/_pk7600004201_001; shp2pgsql -D   -s 32719 "rb_20201111/quadras.shp" pk7600004201201_p2_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600004201_001/rb_20201111/quadras.shp','block_full','pk7600004201201_p2_block','7600004201201','73d02ba0ae4b0a994a629f7d06f0a027259f5c1d97e53f9b771fecd345c2a02b.zip',array['gid', 'iq AS ref', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600004201201_p2_block CASCADE"
rm -f /tmp/sandbox/_pk7600004201_001/*rb_20201111/quadras.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-AC-RioBranco','/var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/block -type f -exec chmod 664 {} \;






# layer nsvia:
rm -rf /tmp/sandbox/_pk7600004201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600004201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/73d02ba0ae4b0a994a629f7d06f0a027259f5c1d97e53f9b771fecd345c2a02b.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/73d02ba0ae4b0a994a629f7d06f0a027259f5c1d97e53f9b771fecd345c2a02b.zip && sudo chmod 664 /var/www/dl.digital-guard.org/73d02ba0ae4b0a994a629f7d06f0a027259f5c1d97e53f9b771fecd345c2a02b.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600004201201_p2_nsvia CASCADE"
cd /tmp/sandbox/_pk7600004201_001; 7z  x -y /var/www/dl.digital-guard.org/73d02ba0ae4b0a994a629f7d06f0a027259f5c1d97e53f9b771fecd345c2a02b.zip "*rb_20201111/bairros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=32719"
cd /tmp/sandbox/_pk7600004201_001; shp2pgsql -D   -s 32719 "rb_20201111/bairros.shp" pk7600004201201_p2_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600004201_001/rb_20201111/bairros.shp','nsvia_full','pk7600004201201_p2_nsvia','7600004201201','73d02ba0ae4b0a994a629f7d06f0a027259f5c1d97e53f9b771fecd345c2a02b.zip',array['gid', 'name AS nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600004201201_p2_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600004201_001/*rb_20201111/bairros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-AC-RioBranco','/var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600004201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600004201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/d96f47270e22336cf4660f742ae4dba5694f15c6833363167c91d9fc9929871b.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/d96f47270e22336cf4660f742ae4dba5694f15c6833363167c91d9fc9929871b.zip && sudo chmod 664 /var/www/dl.digital-guard.org/d96f47270e22336cf4660f742ae4dba5694f15c6833363167c91d9fc9929871b.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600004201101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600004201_001; 7z  x -y /var/www/dl.digital-guard.org/d96f47270e22336cf4660f742ae4dba5694f15c6833363167c91d9fc9929871b.zip "*rb_20201116/lotes*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=32719"
cd /tmp/sandbox/_pk7600004201_001; shp2pgsql -D   -s 32719 "rb_20201116/lotes.shp" pk7600004201101_p1_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600004201_001/rb_20201116/lotes.shp','parcel_full','pk7600004201101_p1_parcel','7600004201101','d96f47270e22336cf4660f742ae4dba5694f15c6833363167c91d9fc9929871b.zip',array['gid', 'nomelog AS via', 'endereco_n AS hnum'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600004201101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600004201_001/*rb_20201116/lotes.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-AC-RioBranco','/var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600004201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600004201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/29d68e5ce006079b06b710cc2df3aa08d6cb6934f32bc0b29fc46d3e8272ff77.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/29d68e5ce006079b06b710cc2df3aa08d6cb6934f32bc0b29fc46d3e8272ff77.rar && sudo chmod 664 /var/www/dl.digital-guard.org/29d68e5ce006079b06b710cc2df3aa08d6cb6934f32bc0b29fc46d3e8272ff77.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600004201301_p3_via CASCADE"
cd /tmp/sandbox/_pk7600004201_001; 7z  x -y /var/www/dl.digital-guard.org/29d68e5ce006079b06b710cc2df3aa08d6cb6934f32bc0b29fc46d3e8272ff77.rar "*logradouros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=32719"
cd /tmp/sandbox/_pk7600004201_001; shp2pgsql -D   -s 32719 "logradouros.shp" pk7600004201301_p3_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw3_pk7600004201301_p3_via AS SELECT gid, tipo ||' '|| Nome AS via,  geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/logradouros.shp','via_full','vw3_pk7600004201301_p3_via','7600004201301','29d68e5ce006079b06b710cc2df3aa08d6cb6934f32bc0b29fc46d3e8272ff77.rar',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw3_pk7600004201301_p3_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600004201301_p3_via CASCADE"
rm -f /tmp/sandbox/_pk7600004201_001/*logradouros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-AC-RioBranco','/var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/AC/RioBranco/_pk0042.01/via -type f -exec chmod 664 {} \;




