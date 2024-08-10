#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600003301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600003301_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/0f724350c2511ec58873a9dcaeec51a6756f9258b2b4ecd953884198e0350cbc.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/0f724350c2511ec58873a9dcaeec51a6756f9258b2b4ecd953884198e0350cbc.zip && sudo chmod 664 /var/www/dl.digital-guard.org/0f724350c2511ec58873a9dcaeec51a6756f9258b2b4ecd953884198e0350cbc.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003301501_p5_block CASCADE"
cd /tmp/sandbox/_pk7600003301_001; 7z  x -y /var/www/dl.digital-guard.org/0f724350c2511ec58873a9dcaeec51a6756f9258b2b4ecd953884198e0350cbc.zip "*SIRGAS_SHP_quadraviariaed/SIRGAS_SHP_quadraviariaed_polygon*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600003301_001; shp2pgsql -D   -s 31983 "SIRGAS_SHP_quadraviariaed/SIRGAS_SHP_quadraviariaed_polygon.shp" pk7600003301501_p5_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600003301_001/SIRGAS_SHP_quadraviariaed/SIRGAS_SHP_quadraviariaed_polygon.shp','block_none','pk7600003301501_p5_block','7600003301501','0f724350c2511ec58873a9dcaeec51a6756f9258b2b4ecd953884198e0350cbc.zip',array['gid', 'qe_id AS ref', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003301501_p5_block CASCADE"
rm -f /tmp/sandbox/_pk7600003301_001/*SIRGAS_SHP_quadraviariaed/SIRGAS_SHP_quadraviariaed_polygon.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-SP-SaoPaulo','/var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/block -type f -exec chmod 664 {} \;

# layer building:
rm -rf /tmp/sandbox/_pk7600003301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600003301_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/8e7be760f94bb385bb1b6a47feee3afce9c0fcf48317b554834a5ac30bc5a0cf.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/8e7be760f94bb385bb1b6a47feee3afce9c0fcf48317b554834a5ac30bc5a0cf.zip && sudo chmod 664 /var/www/dl.digital-guard.org/8e7be760f94bb385bb1b6a47feee3afce9c0fcf48317b554834a5ac30bc5a0cf.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003301101_p1_building CASCADE"
cd /tmp/sandbox/_pk7600003301_001; 7z  x -y /var/www/dl.digital-guard.org/8e7be760f94bb385bb1b6a47feee3afce9c0fcf48317b554834a5ac30bc5a0cf.zip "*SHP_edificacao*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600003301_001; 7z x -y "*SHP_edificacao*" ; chmod -R a+rx . > /dev/null

cd /tmp/sandbox/_pk7600003301_001; find /tmp/sandbox/_pk7600003301_001 -path "*SIRGAS_SHP_edificacao*.shp" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c 'DROP TABLE IF EXISTS pk7600003301101_p1_building'; shp2pgsql -D -W ISO-8859-1  -s 31983 '{}' pk7600003301101_p1_building | psql -q postgres://postgres@localhost/ingest1 ; psql postgres://postgres@localhost/ingest1 -c \"CREATE VIEW vw1_pk7600003301101_p1_building AS SELECT gid, 'yes' AS building, geom FROM $(tabname)\" | psql postgres://postgres@localhost/ingest1 -c \"SELECT ingest.any_load('shp2sql','$$(find /tmp/sandbox/_pk7600003301_001 -path "*SIRGAS_SHP_edificacao*.shp" | head -n 1)','building_none','vw1_pk7600003301101_p1_building','7600003301101','8e7be760f94bb385bb1b6a47feee3afce9c0fcf48317b554834a5ac30bc5a0cf.zip',array[]::text[],5,1,false)\" | psql postgres://postgres@localhost/ingest1 -c \"DROP VIEW vw1_pk7600003301101_p1_building\" " \;
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load_assign('$$(find /tmp/sandbox/_pk7600003301_001 -path "*SIRGAS_SHP_edificacao*.shp" | head -n 1)','building_none','7600003301101' )"
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003301101_p1_building CASCADE"
rm -f /tmp/sandbox/_pk7600003301_001/*SHP_edificacao.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/building
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/building/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('building','BR-SP-SaoPaulo','/var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/building','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/building
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/building -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/building -type f -exec chmod 664 {} \;

# layer cadparcel:
rm -rf /tmp/sandbox/_pk7600003301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600003301_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/75c003ca72fd92a2cd2146518c8bd69b6396dd1ee70d5e94c81107e27b498c12.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/75c003ca72fd92a2cd2146518c8bd69b6396dd1ee70d5e94c81107e27b498c12.zip && sudo chmod 664 /var/www/dl.digital-guard.org/75c003ca72fd92a2cd2146518c8bd69b6396dd1ee70d5e94c81107e27b498c12.zip
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk7600003301301_p3_cadparcel CASCADE"
cd /tmp/sandbox/_pk7600003301_001; 7z  x -y /var/www/dl.digital-guard.org/75c003ca72fd92a2cd2146518c8bd69b6396dd1ee70d5e94c81107e27b498c12.zip "*IPTU_2020*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
iconv -f ISO-8859-1 -t UTF-8 /tmp/sandbox/_pk7600003301_001/IPTU_2020.csv | dos2unix > /tmp/sandbox/_pk7600003301_001/IPTU_2020.unix_utf8.csv
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.fdw_generate_direct_csv( '/tmp/sandbox/_pk7600003301_001/IPTU_2020.unix_utf8.csv', 'pk7600003301301_p3_cadparcel',';' )"

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw3_pk7600003301301_p3_cadparcel AS SELECT row_number() OVER () AS gid, split_part(\"NUMERO DO CONTRIBUINTE\", '-', 1) AS ref, \"NOME DE LOGRADOURO DO IMOVEL\" AS via, \"NUMERO DO IMOVEL\" AS hnum, \"BAIRRO DO IMOVEL\" AS nsvia, \"CEP DO IMOVEL\" AS postcode FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('csv2sql','/tmp/sandbox/IPTU_2020.csv','cadparcel_cmpl','vw3_pk7600003301301_p3_cadparcel','7600003301301','75c003ca72fd92a2cd2146518c8bd69b6396dd1ee70d5e94c81107e27b498c12.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw3_pk7600003301301_p3_cadparcel"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.cadastral_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk7600003301301_p3_cadparcel CASCADE"
rm -f /tmp/sandbox/_pk7600003301_001/*IPTU_2020.* || true





# layer parcel:
rm -rf /tmp/sandbox/_pk7600003301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600003301_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/bae2054448855305db0fc855d2852cd5a7b369481cc03aeb809a0c3c162a2c04.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/bae2054448855305db0fc855d2852cd5a7b369481cc03aeb809a0c3c162a2c04.zip && sudo chmod 664 /var/www/dl.digital-guard.org/bae2054448855305db0fc855d2852cd5a7b369481cc03aeb809a0c3c162a2c04.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003301201_p2_parcel CASCADE"
cd /tmp/sandbox/_pk7600003301_001; 7z  x -y /var/www/dl.digital-guard.org/bae2054448855305db0fc855d2852cd5a7b369481cc03aeb809a0c3c162a2c04.zip "*SIRGAS_SHP_LOTES*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600003301_001; 7z x -y "*SIRGAS_SHP_LOTES*" ; chmod -R a+rx . > /dev/null

cd /tmp/sandbox/_pk7600003301_001; find /tmp/sandbox/_pk7600003301_001 -path "*SIRGAS_SHP_LOTES*.shp" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c 'DROP TABLE IF EXISTS pk7600003301201_p2_parcel'; shp2pgsql -D -W ISO-8859-1  -s 31983 '{}' pk7600003301201_p2_parcel | psql -q postgres://postgres@localhost/ingest1 ; psql postgres://postgres@localhost/ingest1 -c \"SELECT ingest.any_load('shp2sql','$$(find /tmp/sandbox/_pk7600003301_001 -path "*SIRGAS_SHP_LOTES*.shp" | head -n 1)','parcel_ext','pk7600003301201_p2_parcel','7600003301201','bae2054448855305db0fc855d2852cd5a7b369481cc03aeb809a0c3c162a2c04.zip',array['gid', 'lo_setor || lo_quadra || lo_lote AS ref', 'geom'],5,1,false)\" " \;
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load_assign('$$(find /tmp/sandbox/_pk7600003301_001 -path "*SIRGAS_SHP_LOTES*.shp" | head -n 1)','parcel_ext','7600003301201' )"
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003301201_p2_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600003301_001/*SIRGAS_SHP_LOTES.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-SP-SaoPaulo','/var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600003301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600003301_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/ef12421332aca1f53484084ab50bdca48d243ba1d9593ebfd873a1af2ab86556.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/ef12421332aca1f53484084ab50bdca48d243ba1d9593ebfd873a1af2ab86556.zip && sudo chmod 664 /var/www/dl.digital-guard.org/ef12421332aca1f53484084ab50bdca48d243ba1d9593ebfd873a1af2ab86556.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003301401_p4_via CASCADE"
cd /tmp/sandbox/_pk7600003301_001; 7z  x -y /var/www/dl.digital-guard.org/ef12421332aca1f53484084ab50bdca48d243ba1d9593ebfd873a1af2ab86556.zip "*SIRGAS_SHP_logradouronbl/SIRGAS_SHP_logradouronbl*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600003301_001; shp2pgsql -D   -s 31983 "SIRGAS_SHP_logradouronbl/SIRGAS_SHP_logradouronbl.shp" pk7600003301401_p4_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw4_pk7600003301401_p4_via AS SELECT row_number() OVER () as gid, lg_tipo || ' ' || lg_nome AS via, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/SIRGAS_SHP_logradouronbl/SIRGAS_SHP_logradouronbl.shp','via_full','vw4_pk7600003301401_p4_via','7600003301401','ef12421332aca1f53484084ab50bdca48d243ba1d9593ebfd873a1af2ab86556.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw4_pk7600003301401_p4_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003301401_p4_via CASCADE"
rm -f /tmp/sandbox/_pk7600003301_001/*SIRGAS_SHP_logradouronbl/SIRGAS_SHP_logradouronbl.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-SP-SaoPaulo','/var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoPaulo/_pk0033.01/via -type f -exec chmod 664 {} \;



# layer joining



psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.join('parcel_ext','ref','bae2054448855305db0fc855d2852cd5a7b369481cc03aeb809a0c3c162a2c04.zip','cadparcel_cmpl','ref','75c003ca72fd92a2cd2146518c8bd69b6396dd1ee70d5e94c81107e27b498c12.zip')"

