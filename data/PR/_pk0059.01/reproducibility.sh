#!/bin/bash









# layer parcel:
rm -rf /tmp/sandbox/_pk7600005901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600005901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/47dca17c620c1c34ac091dac19afb8851f1d8f9a907094a0f40a0310e774445d.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/47dca17c620c1c34ac091dac19afb8851f1d8f9a907094a0f40a0310e774445d.zip && sudo chmod 664 /var/www/dl.digital-guard.org/47dca17c620c1c34ac091dac19afb8851f1d8f9a907094a0f40a0310e774445d.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005901101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600005901_001; 7z  x -y /var/www/dl.digital-guard.org/47dca17c620c1c34ac091dac19afb8851f1d8f9a907094a0f40a0310e774445d.zip "*New File Geodatabase (2).gdb*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
sudo docker run --rm --network host -v /tmp/sandbox:/tmp osgeo/gdal ogr2ogr -lco GEOMETRY_NAME=geom -overwrite -f "PostgreSQL" PG:" dbname='ingest1' host='localhost' port='5432' user='postgres' " "/tmp/New File Geodatabase (2).gdb" LOTES_PR -nln pk7600005901101_p1_parcel -a_srs EPSG:31982  
dd if=/dev/random of='/tmp/sandbox/New File Geodatabase (2).gdb/random_data_file' bs=1M count=1
psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600005901101_p1_parcel AS SELECT objectid AS gid, nrpredial AS hnum, NmMunicipio, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "CALL ingest.any_load_loop('gdb2sql','/tmp/sandbox/New File Geodatabase (2).gdb/random_data_file','parcel_none','vw1_pk7600005901101_p1_parcel','7600005901101','47dca17c620c1c34ac091dac19afb8851f1d8f9a907094a0f40a0310e774445d.zip',array[]::text[],5,1,false,'geom',true,'NmMunicipio')"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600005901101_p1_parcel"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005901101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600005901_001/*New File Geodatabase (2).gdb.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PR/_pk0059.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PR/_pk0059.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-PR','/var/gits/_dg/preservCutGeo-BR2021/data/PR/_pk0059.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PR/_pk0059.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/_pk0059.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PR/_pk0059.01/parcel -type f -exec chmod 664 {} \;





