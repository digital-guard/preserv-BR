#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600000501_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600000501_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/b18fc8ebe8bccc2cfdbbbd5f4896d5f6573033ebfa80061d1d86550c5ae8521d.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/b18fc8ebe8bccc2cfdbbbd5f4896d5f6573033ebfa80061d1d86550c5ae8521d.zip && sudo chmod 664 /var/www/dl.digital-guard.org/b18fc8ebe8bccc2cfdbbbd5f4896d5f6573033ebfa80061d1d86550c5ae8521d.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000501101_p1_block CASCADE"
cd /tmp/sandbox/_pk7600000501_001; 7z  x -y /var/www/dl.digital-guard.org/b18fc8ebe8bccc2cfdbbbd5f4896d5f6573033ebfa80061d1d86550c5ae8521d.zip "*2018-01-05.gdb*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31984"
sudo docker run --rm --network host -v /tmp/sandbox:/tmp osgeo/gdal ogr2ogr -lco GEOMETRY_NAME=geom -overwrite -f "PostgreSQL" PG:" dbname='ingest1' host='localhost' port='5432' user='postgres' " "/tmp/2018-01-05.gdb" Quadra -nln pk7600000501101_p1_block -a_srs EPSG:31984  -nlt POLYGON
dd if=/dev/random of='/tmp/sandbox/2018-01-05.gdb/random_data_file' bs=1M count=1
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('gdb2sql','/tmp/sandbox/_pk7600000501_001/2018-01-05.gdb/timestamps','block_none','pk7600000501101_p1_block','7600000501101','b18fc8ebe8bccc2cfdbbbd5f4896d5f6573033ebfa80061d1d86550c5ae8521d.zip',array['OBJECTID AS gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000501101_p1_block CASCADE"
rm -f /tmp/sandbox/_pk7600000501_001/*2018-01-05.gdb.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-ES-Serra','/var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/block -type f -exec chmod 664 {} \;






# layer nsvia:
rm -rf /tmp/sandbox/_pk7600000501_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600000501_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/b18fc8ebe8bccc2cfdbbbd5f4896d5f6573033ebfa80061d1d86550c5ae8521d.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/b18fc8ebe8bccc2cfdbbbd5f4896d5f6573033ebfa80061d1d86550c5ae8521d.zip && sudo chmod 664 /var/www/dl.digital-guard.org/b18fc8ebe8bccc2cfdbbbd5f4896d5f6573033ebfa80061d1d86550c5ae8521d.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000501101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk7600000501_001; 7z  x -y /var/www/dl.digital-guard.org/b18fc8ebe8bccc2cfdbbbd5f4896d5f6573033ebfa80061d1d86550c5ae8521d.zip "*2018-01-05.gdb*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31984"
sudo docker run --rm --network host -v /tmp/sandbox:/tmp osgeo/gdal ogr2ogr -lco GEOMETRY_NAME=geom -overwrite -f "PostgreSQL" PG:" dbname='ingest1' host='localhost' port='5432' user='postgres' " "/tmp/2018-01-05.gdb" Bairro -nln pk7600000501101_p1_nsvia -a_srs EPSG:31984  
dd if=/dev/random of='/tmp/sandbox/2018-01-05.gdb/random_data_file' bs=1M count=1
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('gdb2sql','/tmp/sandbox/_pk7600000501_001/2018-01-05.gdb/timestamps','nsvia_full','pk7600000501101_p1_nsvia','7600000501101','b18fc8ebe8bccc2cfdbbbd5f4896d5f6573033ebfa80061d1d86550c5ae8521d.zip',array['OBJECTID_1 AS gid', 'TX_BAIRRO AS nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000501101_p1_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600000501_001/*2018-01-05.gdb.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-ES-Serra','/var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600000501_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600000501_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/b18fc8ebe8bccc2cfdbbbd5f4896d5f6573033ebfa80061d1d86550c5ae8521d.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/b18fc8ebe8bccc2cfdbbbd5f4896d5f6573033ebfa80061d1d86550c5ae8521d.zip && sudo chmod 664 /var/www/dl.digital-guard.org/b18fc8ebe8bccc2cfdbbbd5f4896d5f6573033ebfa80061d1d86550c5ae8521d.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000501101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600000501_001; 7z  x -y /var/www/dl.digital-guard.org/b18fc8ebe8bccc2cfdbbbd5f4896d5f6573033ebfa80061d1d86550c5ae8521d.zip "*2018-01-05.gdb*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31984"
sudo docker run --rm --network host -v /tmp/sandbox:/tmp osgeo/gdal ogr2ogr -lco GEOMETRY_NAME=geom -overwrite -f "PostgreSQL" PG:" dbname='ingest1' host='localhost' port='5432' user='postgres' " "/tmp/2018-01-05.gdb" ParcelamentoSolo -nln pk7600000501101_p1_parcel -a_srs EPSG:31984  -nlt POLYGON
dd if=/dev/random of='/tmp/sandbox/2018-01-05.gdb/random_data_file' bs=1M count=1
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('gdb2sql','/tmp/sandbox/_pk7600000501_001/2018-01-05.gdb/timestamps','parcel_none','pk7600000501101_p1_parcel','7600000501101','b18fc8ebe8bccc2cfdbbbd5f4896d5f6573033ebfa80061d1d86550c5ae8521d.zip',array['OBJECTID AS gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000501101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600000501_001/*2018-01-05.gdb.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-ES-Serra','/var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600000501_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600000501_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/b18fc8ebe8bccc2cfdbbbd5f4896d5f6573033ebfa80061d1d86550c5ae8521d.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/b18fc8ebe8bccc2cfdbbbd5f4896d5f6573033ebfa80061d1d86550c5ae8521d.zip && sudo chmod 664 /var/www/dl.digital-guard.org/b18fc8ebe8bccc2cfdbbbd5f4896d5f6573033ebfa80061d1d86550c5ae8521d.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000501101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600000501_001; 7z  x -y /var/www/dl.digital-guard.org/b18fc8ebe8bccc2cfdbbbd5f4896d5f6573033ebfa80061d1d86550c5ae8521d.zip "*2018-01-05.gdb*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31984"
sudo docker run --rm --network host -v /tmp/sandbox:/tmp osgeo/gdal ogr2ogr -lco GEOMETRY_NAME=geom -overwrite -f "PostgreSQL" PG:" dbname='ingest1' host='localhost' port='5432' user='postgres' " "/tmp/2018-01-05.gdb" Arruamento -nln pk7600000501101_p1_via -a_srs EPSG:31984  -nlt CONVERT_TO_LINEAR -nlt PROMOTE_TO_MULTI
dd if=/dev/random of='/tmp/sandbox/2018-01-05.gdb/random_data_file' bs=1M count=1
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('gdb2sql','/tmp/sandbox/_pk7600000501_001/2018-01-05.gdb/timestamps','via_full','pk7600000501101_p1_via','7600000501101','b18fc8ebe8bccc2cfdbbbd5f4896d5f6573033ebfa80061d1d86550c5ae8521d.zip',array['OBJECTID AS gid', 'TX_TOPONIMIA_EXTENSO AS via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000501101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600000501_001/*2018-01-05.gdb.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-ES-Serra','/var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/Serra/_pk0005.01/via -type f -exec chmod 664 {} \;




