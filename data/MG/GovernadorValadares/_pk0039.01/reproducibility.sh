#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600003901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600003901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/2bcdbd6a2ddf4fd810147a106616f404c69a9c38bc02531fe3fa9f27acab25a6.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/2bcdbd6a2ddf4fd810147a106616f404c69a9c38bc02531fe3fa9f27acab25a6.zip && sudo chmod 664 /var/www/dl.digital-guard.org/2bcdbd6a2ddf4fd810147a106616f404c69a9c38bc02531fe3fa9f27acab25a6.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003901301_p3_block CASCADE"
cd /tmp/sandbox/_pk7600003901_001; 7z  x -y /var/www/dl.digital-guard.org/2bcdbd6a2ddf4fd810147a106616f404c69a9c38bc02531fe3fa9f27acab25a6.zip "*st_quadraPolygon*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31984"
cd /tmp/sandbox/_pk7600003901_001; shp2pgsql -D   -s 31984 "st_quadraPolygon.shp" pk7600003901301_p3_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600003901_001/st_quadraPolygon.shp','block_none','pk7600003901301_p3_block','7600003901301','2bcdbd6a2ddf4fd810147a106616f404c69a9c38bc02531fe3fa9f27acab25a6.zip',array['gid', 'id_quadra AS ref', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003901301_p3_block CASCADE"
rm -f /tmp/sandbox/_pk7600003901_001/*st_quadraPolygon.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-MG-GovernadorValadares','/var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/block -type f -exec chmod 664 {} \;


# layer cadparcel:
rm -rf /tmp/sandbox/_pk7600003901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600003901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/2e79fdf013a8de68e071c2f2a9911bc98196254bc9b9f39482cb0941a146b485.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/2e79fdf013a8de68e071c2f2a9911bc98196254bc9b9f39482cb0941a146b485.zip && sudo chmod 664 /var/www/dl.digital-guard.org/2e79fdf013a8de68e071c2f2a9911bc98196254bc9b9f39482cb0941a146b485.zip
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk7600003901101_p1_cadparcel CASCADE"
cd /tmp/sandbox/_pk7600003901_001; 7z  x -y /var/www/dl.digital-guard.org/2e79fdf013a8de68e071c2f2a9911bc98196254bc9b9f39482cb0941a146b485.zip "*Logradouros - Gov. Valadares*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31984"
xlsx2csv -i  "/tmp/sandbox/_pk7600003901_001/Logradouros - Gov. Valadares.xlsx" "/tmp/sandbox/_pk7600003901_001/Logradouros - Gov. Valadares.csv"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.fdw_generate_direct_csv( '/tmp/sandbox/_pk7600003901_001/Logradouros - Gov. Valadares.csv', 'pk7600003901101_p1_cadparcel' )"

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600003901101_p1_cadparcel AS SELECT row_number() OVER () AS gid, \"Logradouro\" AS via, \"Número\" AS hnum, \"Distrito\" || \"Setor\" || \"Quadra\" || \"Lote\" AS ref FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('csv2sql','/tmp/sandbox/Logradouros - Gov. Valadares.xlsx','cadparcel_cmpl','vw1_pk7600003901101_p1_cadparcel','7600003901101','2e79fdf013a8de68e071c2f2a9911bc98196254bc9b9f39482cb0941a146b485.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600003901101_p1_cadparcel"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.cadastral_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk7600003901101_p1_cadparcel CASCADE"
rm -f /tmp/sandbox/_pk7600003901_001/*Logradouros - Gov. Valadares.* || true




# layer nsvia:
rm -rf /tmp/sandbox/_pk7600003901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600003901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/0cc1b05163361968a5681e971c8ab1395fcca1ba4b48150a7522a90b836727e3.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/0cc1b05163361968a5681e971c8ab1395fcca1ba4b48150a7522a90b836727e3.zip && sudo chmod 664 /var/www/dl.digital-guard.org/0cc1b05163361968a5681e971c8ab1395fcca1ba4b48150a7522a90b836727e3.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003901401_p4_nsvia CASCADE"
cd /tmp/sandbox/_pk7600003901_001; 7z  x -y /var/www/dl.digital-guard.org/0cc1b05163361968a5681e971c8ab1395fcca1ba4b48150a7522a90b836727e3.zip "*st_bairroPolygon*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31984"
cd /tmp/sandbox/_pk7600003901_001; shp2pgsql -D   -s 31984 "st_bairroPolygon.shp" pk7600003901401_p4_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600003901_001/st_bairroPolygon.shp','nsvia_none','pk7600003901401_p4_nsvia','7600003901401','0cc1b05163361968a5681e971c8ab1395fcca1ba4b48150a7522a90b836727e3.zip',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003901401_p4_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600003901_001/*st_bairroPolygon.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-MG-GovernadorValadares','/var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600003901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600003901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/98248f643e60829689b398b2852981cfd12b11799a640d93b27223dfc4346948.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/98248f643e60829689b398b2852981cfd12b11799a640d93b27223dfc4346948.rar && sudo chmod 664 /var/www/dl.digital-guard.org/98248f643e60829689b398b2852981cfd12b11799a640d93b27223dfc4346948.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003901201_p2_parcel CASCADE"
cd /tmp/sandbox/_pk7600003901_001; 7z  x -y /var/www/dl.digital-guard.org/98248f643e60829689b398b2852981cfd12b11799a640d93b27223dfc4346948.rar "*lote_inscricao_geometria/lote_inscricao_geometriaPolygon*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31984"
cd /tmp/sandbox/_pk7600003901_001; shp2pgsql -D   -s 31984 "lote_inscricao_geometria/lote_inscricao_geometriaPolygon.shp" pk7600003901201_p2_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600003901_001/lote_inscricao_geometria/lote_inscricao_geometriaPolygon.shp','parcel_ext','pk7600003901201_p2_parcel','7600003901201','98248f643e60829689b398b2852981cfd12b11799a640d93b27223dfc4346948.rar',array['gid', 'cd_distrit || cd_setor || nr_quadra || nr_lote AS ref', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003901201_p2_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600003901_001/*lote_inscricao_geometria/lote_inscricao_geometriaPolygon.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-MG-GovernadorValadares','/var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600003901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600003901_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/437a5012420b1bdc748ea571eabfa0aee6154c41196fe898c383d76e61a5c5db.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/437a5012420b1bdc748ea571eabfa0aee6154c41196fe898c383d76e61a5c5db.zip && sudo chmod 664 /var/www/dl.digital-guard.org/437a5012420b1bdc748ea571eabfa0aee6154c41196fe898c383d76e61a5c5db.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003901501_p5_via CASCADE"
cd /tmp/sandbox/_pk7600003901_001; 7z  x -y /var/www/dl.digital-guard.org/437a5012420b1bdc748ea571eabfa0aee6154c41196fe898c383d76e61a5c5db.zip "*view_st_logradouro_eixoLine*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31984"
cd /tmp/sandbox/_pk7600003901_001; shp2pgsql -D -W ISO-8859-1  -s 31984 "view_st_logradouro_eixoLine.shp" pk7600003901501_p5_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600003901_001/view_st_logradouro_eixoLine.shp','via_full','pk7600003901501_p5_via','7600003901501','437a5012420b1bdc748ea571eabfa0aee6154c41196fe898c383d76e61a5c5db.zip',array['gid', 'descricao AS via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003901501_p5_via CASCADE"
rm -f /tmp/sandbox/_pk7600003901_001/*view_st_logradouro_eixoLine.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-MG-GovernadorValadares','/var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/MG/GovernadorValadares/_pk0039.01/via -type f -exec chmod 664 {} \;



# layer joining



psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.join('parcel_ext','ref','98248f643e60829689b398b2852981cfd12b11799a640d93b27223dfc4346948.rar','cadparcel_cmpl','ref','2e79fdf013a8de68e071c2f2a9911bc98196254bc9b9f39482cb0941a146b485.zip')"

