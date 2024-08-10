#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600000901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600000901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar && sudo chmod 664 /var/www/dl.digital-guard.org/058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000901101_p1_block CASCADE"
cd /tmp/sandbox/_pk7600000901_001; 7z  x -y /var/www/dl.digital-guard.org/058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar "*OpenStreetMap.gdb*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
sudo docker run --rm --network host -v /tmp/sandbox:/tmp osgeo/gdal ogr2ogr -lco GEOMETRY_NAME=geom -overwrite -f "PostgreSQL" PG:" dbname='ingest1' host='localhost' port='5432' user='postgres' " "/tmp/OpenStreetMap.gdb" Quadras -nln pk7600000901101_p1_block -a_srs EPSG:31983  
dd if=/dev/random of='/tmp/sandbox/OpenStreetMap.gdb/random_data_file' bs=1M count=1
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('gdb2sql','/tmp/sandbox/_pk7600000901_001/OpenStreetMap.gdb/timestamps','block_full','pk7600000901101_p1_block','7600000901101','058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar',array['OBJECTID AS gid', 'QUADRA AS ref', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000901101_p1_block CASCADE"
rm -f /tmp/sandbox/_pk7600000901_001/*OpenStreetMap.gdb.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-MG-Contagem','/var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/block -type f -exec chmod 664 {} \;





# layer geoaddress:
rm -rf /tmp/sandbox/_pk7600000901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600000901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar && sudo chmod 664 /var/www/dl.digital-guard.org/058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000901101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk7600000901_001; 7z  x -y /var/www/dl.digital-guard.org/058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar "*OpenStreetMap.gdb*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
sudo docker run --rm --network host -v /tmp/sandbox:/tmp osgeo/gdal ogr2ogr -lco GEOMETRY_NAME=geom -overwrite -f "PostgreSQL" PG:" dbname='ingest1' host='localhost' port='5432' user='postgres' " "/tmp/OpenStreetMap.gdb" Endereco -nln pk7600000901101_p1_geoaddress -a_srs EPSG:31983  
dd if=/dev/random of='/tmp/sandbox/OpenStreetMap.gdb/random_data_file' bs=1M count=1
psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600000901101_p1_geoaddress AS SELECT OBJECTID AS gid, Nome_logra AS via, Num_imovel AS hnum, geom FROM $(tabname) WHERE OBJECTID NOT IN (103847)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('gdb2sql','/tmp/sandbox/OpenStreetMap.gdb/random_data_file','geoaddress_full','vw1_pk7600000901101_p1_geoaddress','7600000901101','058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar',array[]::text[],1,2)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600000901101_p1_geoaddress"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000901101_p1_geoaddress CASCADE"
rm -f /tmp/sandbox/_pk7600000901_001/*OpenStreetMap.gdb.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','BR-MG-Contagem','/var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/geoaddress','2',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/geoaddress -type f -exec chmod 664 {} \;

# layer nsvia:
rm -rf /tmp/sandbox/_pk7600000901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600000901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar && sudo chmod 664 /var/www/dl.digital-guard.org/058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000901101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk7600000901_001; 7z  x -y /var/www/dl.digital-guard.org/058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar "*OpenStreetMap.gdb*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=3857"
sudo docker run --rm --network host -v /tmp/sandbox:/tmp osgeo/gdal ogr2ogr -lco GEOMETRY_NAME=geom -overwrite -f "PostgreSQL" PG:" dbname='ingest1' host='localhost' port='5432' user='postgres' " "/tmp/OpenStreetMap.gdb" Bairros -nln pk7600000901101_p1_nsvia -a_srs EPSG:3857  
dd if=/dev/random of='/tmp/sandbox/OpenStreetMap.gdb/random_data_file' bs=1M count=1
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('gdb2sql','/tmp/sandbox/_pk7600000901_001/OpenStreetMap.gdb/timestamps','nsvia_full','pk7600000901101_p1_nsvia','7600000901101','058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar',array['OBJECTID AS gid', 'Teste2_P_1 AS nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000901101_p1_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600000901_001/*OpenStreetMap.gdb.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-MG-Contagem','/var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600000901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600000901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar && sudo chmod 664 /var/www/dl.digital-guard.org/058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000901101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600000901_001; 7z  x -y /var/www/dl.digital-guard.org/058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar "*OpenStreetMap.gdb*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
sudo docker run --rm --network host -v /tmp/sandbox:/tmp osgeo/gdal ogr2ogr -lco GEOMETRY_NAME=geom -overwrite -f "PostgreSQL" PG:" dbname='ingest1' host='localhost' port='5432' user='postgres' " "/tmp/OpenStreetMap.gdb" Lotes -nln pk7600000901101_p1_parcel -a_srs EPSG:31983  
dd if=/dev/random of='/tmp/sandbox/OpenStreetMap.gdb/random_data_file' bs=1M count=1
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('gdb2sql','/tmp/sandbox/_pk7600000901_001/OpenStreetMap.gdb/timestamps','parcel_ext','pk7600000901101_p1_parcel','7600000901101','058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar',array['OBJECTID AS gid', 'BAIRRO AS nsvia', 'geom'],5,2)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000901101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600000901_001/*OpenStreetMap.gdb.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-MG-Contagem','/var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/parcel','2',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600000901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600000901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar && sudo chmod 664 /var/www/dl.digital-guard.org/058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000901101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600000901_001; 7z  x -y /var/www/dl.digital-guard.org/058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar "*OpenStreetMap.gdb*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
sudo docker run --rm --network host -v /tmp/sandbox:/tmp osgeo/gdal ogr2ogr -lco GEOMETRY_NAME=geom -overwrite -f "PostgreSQL" PG:" dbname='ingest1' host='localhost' port='5432' user='postgres' " "/tmp/OpenStreetMap.gdb" Logradouros -nln pk7600000901101_p1_via -a_srs EPSG:31983  
dd if=/dev/random of='/tmp/sandbox/OpenStreetMap.gdb/random_data_file' bs=1M count=1
psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600000901101_p1_via AS SELECT OBJECTID AS gid, TIPO_LOGRA || ' ' || NOME_LOGRA AS via, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('gdb2sql','/tmp/sandbox/OpenStreetMap.gdb/random_data_file','via_full','vw1_pk7600000901101_p1_via','7600000901101','058a6022054e8b3f9ba81f25f7511b58cbd4ad616b0510033b917f3f7f9f23d5.rar',array[]::text[],5,2)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600000901101_p1_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000901101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600000901_001/*OpenStreetMap.gdb.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-MG-Contagem','/var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/via','2',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/Contagem/_pk0009.01/via -type f -exec chmod 664 {} \;




