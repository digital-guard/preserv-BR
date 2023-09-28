#!/bin/bash







# layer geoaddress:
rm -rf /tmp/sandbox/_pk7600003001_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600003001_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/22ecd5ef4ca76adef213fa422d9b5e4198f0667df598c511c30e512bb10aaedd.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/22ecd5ef4ca76adef213fa422d9b5e4198f0667df598c511c30e512bb10aaedd.zip && sudo chmod 664 /var/www/dl.digital-guard.org/22ecd5ef4ca76adef213fa422d9b5e4198f0667df598c511c30e512bb10aaedd.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003001101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk7600003001_001; 7z  x -y /var/www/dl.digital-guard.org/22ecd5ef4ca76adef213fa422d9b5e4198f0667df598c511c30e512bb10aaedd.zip "*Q_Endereco_SBC*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600003001_001; shp2pgsql -D -W ISO-8859-1  -s 31983 "Q_Endereco_SBC.shp" pk7600003001101_p1_geoaddress | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600003001_001/Q_Endereco_SBC.shp','geoaddress_full','pk7600003001101_p1_geoaddress','7600003001101','22ecd5ef4ca76adef213fa422d9b5e4198f0667df598c511c30e512bb10aaedd.zip',array['gid', 'NOME_COMPL as via', 'Numero as hnum', 'geom'],1,2)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003001101_p1_geoaddress CASCADE"
rm -f /tmp/sandbox/_pk7600003001_001/*Q_Endereco_SBC.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','BR-SP-SaoBernardoCampo','/var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/geoaddress','2',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/geoaddress -type f -exec chmod 664 {} \;

# layer nsvia:
rm -rf /tmp/sandbox/_pk7600003001_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600003001_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/350b605174967b94ef49ce1bbac0352dd76e2175e5eae1b8e5b730cd9950d133.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/350b605174967b94ef49ce1bbac0352dd76e2175e5eae1b8e5b730cd9950d133.zip && sudo chmod 664 /var/www/dl.digital-guard.org/350b605174967b94ef49ce1bbac0352dd76e2175e5eae1b8e5b730cd9950d133.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003001401_p4_nsvia CASCADE"
cd /tmp/sandbox/_pk7600003001_001; 7z  x -y /var/www/dl.digital-guard.org/350b605174967b94ef49ce1bbac0352dd76e2175e5eae1b8e5b730cd9950d133.zip "*BAIRRO*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600003001_001; shp2pgsql -D -W ISO-8859-1  -s 31983 "BAIRRO.shp" pk7600003001401_p4_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600003001_001/BAIRRO.shp','nsvia_full','pk7600003001401_p4_nsvia','7600003001401','350b605174967b94ef49ce1bbac0352dd76e2175e5eae1b8e5b730cd9950d133.zip',array['gid', 'NOME as nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003001401_p4_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600003001_001/*BAIRRO.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-SP-SaoBernardoCampo','/var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600003001_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600003001_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/d4985405060cc1887962a4278b4d68ada6ffd3ed72f296bd72d65abc4897cd2d.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/d4985405060cc1887962a4278b4d68ada6ffd3ed72f296bd72d65abc4897cd2d.zip && sudo chmod 664 /var/www/dl.digital-guard.org/d4985405060cc1887962a4278b4d68ada6ffd3ed72f296bd72d65abc4897cd2d.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003001201_p2_parcel CASCADE"
cd /tmp/sandbox/_pk7600003001_001; 7z  x -y /var/www/dl.digital-guard.org/d4985405060cc1887962a4278b4d68ada6ffd3ed72f296bd72d65abc4897cd2d.zip "*LOTE*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600003001_001; shp2pgsql -D   -s 31983 "LOTE.shp" pk7600003001201_p2_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600003001_001/LOTE.shp','parcel_none','pk7600003001201_p2_parcel','7600003001201','d4985405060cc1887962a4278b4d68ada6ffd3ed72f296bd72d65abc4897cd2d.zip',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003001201_p2_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600003001_001/*LOTE.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-SP-SaoBernardoCampo','/var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600003001_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600003001_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/3269bacc09d450b4d7496a2bc749ece94b1f48462ba0aae70d902404256bc433.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/3269bacc09d450b4d7496a2bc749ece94b1f48462ba0aae70d902404256bc433.zip && sudo chmod 664 /var/www/dl.digital-guard.org/3269bacc09d450b4d7496a2bc749ece94b1f48462ba0aae70d902404256bc433.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003001301_p3_via CASCADE"
cd /tmp/sandbox/_pk7600003001_001; 7z  x -y /var/www/dl.digital-guard.org/3269bacc09d450b4d7496a2bc749ece94b1f48462ba0aae70d902404256bc433.zip "*LOGRADOURO*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600003001_001; shp2pgsql -D -W ISO-8859-1  -s 31983 "LOGRADOURO.shp" pk7600003001301_p3_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600003001_001/LOGRADOURO.shp','via_full','pk7600003001301_p3_via','7600003001301','3269bacc09d450b4d7496a2bc749ece94b1f48462ba0aae70d902404256bc433.zip',array['gid', 'NOME as via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600003001301_p3_via CASCADE"
rm -f /tmp/sandbox/_pk7600003001_001/*LOGRADOURO.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-SP-SaoBernardoCampo','/var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoBernardoCampo/_pk0030.01/via -type f -exec chmod 664 {} \;




