#!/bin/bash




# layer cadparcel:
rm -rf /tmp/sandbox/_pk7600001601_002 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600001601_002
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/39d34950c7c61a89cfc2b4d70b0b34a85b346b41741331009205de0f06c86805.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/39d34950c7c61a89cfc2b4d70b0b34a85b346b41741331009205de0f06c86805.zip && sudo chmod 664 /var/www/dl.digital-guard.org/39d34950c7c61a89cfc2b4d70b0b34a85b346b41741331009205de0f06c86805.zip
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk7600001601401_p4_cadparcel CASCADE"
cd /tmp/sandbox/_pk7600001601_002; 7z  x -y /var/www/dl.digital-guard.org/39d34950c7c61a89cfc2b4d70b0b34a85b346b41741331009205de0f06c86805.zip "*Solicitação0710_InscTec_LogNPorBairro*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
xlsx2csv -i  "/tmp/sandbox/_pk7600001601_002/Solicitação0710_InscTec_LogNPorBairro.xlsx" "/tmp/sandbox/_pk7600001601_002/Solicitação0710_InscTec_LogNPorBairro.csv"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.fdw_generate_direct_csv( '/tmp/sandbox/_pk7600001601_002/Solicitação0710_InscTec_LogNPorBairro.csv', 'pk7600001601401_p4_cadparcel' )"

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('csv2sql','/tmp/sandbox/_pk7600001601_002/Solicitação0710_InscTec_LogNPorBairro.xlsx','cadparcel_cmpl','pk7600001601401_p4_cadparcel','7600001601401','39d34950c7c61a89cfc2b4d70b0b34a85b346b41741331009205de0f06c86805.zip',array['tx_insctec', 'tx_lgrd_no AS via', 'nm_lgrd_nr AS hnum', 'nm_cd_bair AS nsvia'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.cadastral_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk7600001601401_p4_cadparcel CASCADE"
rm -f /tmp/sandbox/_pk7600001601_002/*Solicitação0710_InscTec_LogNPorBairro.* || true




# layer nsvia:
rm -rf /tmp/sandbox/_pk7600001601_002 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600001601_002
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/fd0fcfd937ee3d20620862cce6e870679518f4756063f3045c7f65e6b9ca9981.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/fd0fcfd937ee3d20620862cce6e870679518f4756063f3045c7f65e6b9ca9981.zip && sudo chmod 664 /var/www/dl.digital-guard.org/fd0fcfd937ee3d20620862cce6e870679518f4756063f3045c7f65e6b9ca9981.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001601301_p3_nsvia CASCADE"
cd /tmp/sandbox/_pk7600001601_002; 7z  x -y /var/www/dl.digital-guard.org/fd0fcfd937ee3d20620862cce6e870679518f4756063f3045c7f65e6b9ca9981.zip "*Limite_de_Bairros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
cd /tmp/sandbox/_pk7600001601_002; shp2pgsql -D   -s 4326 "Limite_de_Bairros.shp" pk7600001601301_p3_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600001601_002/Limite_de_Bairros.shp','nsvia_ext','pk7600001601301_p3_nsvia','7600001601301','fd0fcfd937ee3d20620862cce6e870679518f4756063f3045c7f65e6b9ca9981.zip',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001601301_p3_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600001601_002/*Limite_de_Bairros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RJ/Niteroi/_pk0016.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RJ/Niteroi/_pk0016.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-RJ-Niteroi','/var/gits/_dg/preservCutGeo-BR2021/data/RJ/Niteroi/_pk0016.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RJ/Niteroi/_pk0016.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RJ/Niteroi/_pk0016.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RJ/Niteroi/_pk0016.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600001601_002 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600001601_002
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/4bde69d0057c0785598f98963fdae3dc90420fb8f163652d70b659210da0ae2b.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/4bde69d0057c0785598f98963fdae3dc90420fb8f163652d70b659210da0ae2b.zip && sudo chmod 664 /var/www/dl.digital-guard.org/4bde69d0057c0785598f98963fdae3dc90420fb8f163652d70b659210da0ae2b.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001601101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600001601_002; 7z  x -y /var/www/dl.digital-guard.org/4bde69d0057c0785598f98963fdae3dc90420fb8f163652d70b659210da0ae2b.zip "*Lotes*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
cd /tmp/sandbox/_pk7600001601_002; shp2pgsql -D   -s 4326 "Lotes.shp" pk7600001601101_p1_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600001601_002/Lotes.shp','parcel_ext','pk7600001601101_p1_parcel','7600001601101','4bde69d0057c0785598f98963fdae3dc90420fb8f163652d70b659210da0ae2b.zip',array['gid', 'tx_insct', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001601101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600001601_002/*Lotes.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RJ/Niteroi/_pk0016.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RJ/Niteroi/_pk0016.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-RJ-Niteroi','/var/gits/_dg/preservCutGeo-BR2021/data/RJ/Niteroi/_pk0016.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RJ/Niteroi/_pk0016.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RJ/Niteroi/_pk0016.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RJ/Niteroi/_pk0016.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600001601_002 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600001601_002
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/5f7e5ecf8e15a9c13323cb9f4fddadee80eb3e253bcc270dc8c134400af3a8b2.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/5f7e5ecf8e15a9c13323cb9f4fddadee80eb3e253bcc270dc8c134400af3a8b2.zip && sudo chmod 664 /var/www/dl.digital-guard.org/5f7e5ecf8e15a9c13323cb9f4fddadee80eb3e253bcc270dc8c134400af3a8b2.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001601201_p2_via CASCADE"
cd /tmp/sandbox/_pk7600001601_002; 7z  x -y /var/www/dl.digital-guard.org/5f7e5ecf8e15a9c13323cb9f4fddadee80eb3e253bcc270dc8c134400af3a8b2.zip "*Logradouro*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
cd /tmp/sandbox/_pk7600001601_002; shp2pgsql -D   -s 4326 "Logradouro.shp" pk7600001601201_p2_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw2_pk7600001601201_p2_via AS SELECT gid, ST_TYPE || ' ' || ST_NO AS via, CMTY_L AS nsvia_left, CMTY_R AS nsvia_right, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/Logradouro.shp','via_full','vw2_pk7600001601201_p2_via','7600001601201','5f7e5ecf8e15a9c13323cb9f4fddadee80eb3e253bcc270dc8c134400af3a8b2.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw2_pk7600001601201_p2_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001601201_p2_via CASCADE"
rm -f /tmp/sandbox/_pk7600001601_002/*Logradouro.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RJ/Niteroi/_pk0016.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RJ/Niteroi/_pk0016.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-RJ-Niteroi','/var/gits/_dg/preservCutGeo-BR2021/data/RJ/Niteroi/_pk0016.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RJ/Niteroi/_pk0016.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RJ/Niteroi/_pk0016.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RJ/Niteroi/_pk0016.01/via -type f -exec chmod 664 {} \;



# layer joining



psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.join('parcel_ext','tx_insct','4bde69d0057c0785598f98963fdae3dc90420fb8f163652d70b659210da0ae2b.zip','cadparcel_cmpl','tx_insctec','39d34950c7c61a89cfc2b4d70b0b34a85b346b41741331009205de0f06c86805.zip')"

