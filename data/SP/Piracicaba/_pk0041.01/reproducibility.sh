#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600004101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600004101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/23f703b7d1611ea29f53fe3bd2617a5939fe96d21453004838d7fe61064dae45.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/23f703b7d1611ea29f53fe3bd2617a5939fe96d21453004838d7fe61064dae45.zip && sudo chmod 664 /var/www/dl.digital-guard.org/23f703b7d1611ea29f53fe3bd2617a5939fe96d21453004838d7fe61064dae45.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600004101201_p2_block CASCADE"
cd /tmp/sandbox/_pk7600004101_001; 7z  x -y /var/www/dl.digital-guard.org/23f703b7d1611ea29f53fe3bd2617a5939fe96d21453004838d7fe61064dae45.zip "*Quadras*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
cd /tmp/sandbox/_pk7600004101_001; shp2pgsql -D -W ISO-8859-1  -s 4326 "Quadras.shp" pk7600004101201_p2_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600004101_001/Quadras.shp','block_none','pk7600004101201_p2_block','7600004101201','23f703b7d1611ea29f53fe3bd2617a5939fe96d21453004838d7fe61064dae45.zip',array['gid', 'chave_qd', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600004101201_p2_block CASCADE"
rm -f /tmp/sandbox/_pk7600004101_001/*Quadras.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Piracicaba/_pk0041.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Piracicaba/_pk0041.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-SP-Piracicaba','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Piracicaba/_pk0041.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Piracicaba/_pk0041.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Piracicaba/_pk0041.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Piracicaba/_pk0041.01/block -type f -exec chmod 664 {} \;






# layer nsvia:
rm -rf /tmp/sandbox/_pk7600004101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600004101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/2137f68df828ce00c276a38b969cd651efcc2f8300f9fb4a716b6fd10019862f.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/2137f68df828ce00c276a38b969cd651efcc2f8300f9fb4a716b6fd10019862f.zip && sudo chmod 664 /var/www/dl.digital-guard.org/2137f68df828ce00c276a38b969cd651efcc2f8300f9fb4a716b6fd10019862f.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600004101301_p3_nsvia CASCADE"
cd /tmp/sandbox/_pk7600004101_001; 7z  x -y /var/www/dl.digital-guard.org/2137f68df828ce00c276a38b969cd651efcc2f8300f9fb4a716b6fd10019862f.zip "*Bairros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
cd /tmp/sandbox/_pk7600004101_001; shp2pgsql -D -W ISO-8859-1  -s 4326 "Bairros.shp" pk7600004101301_p3_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600004101_001/Bairros.shp','nsvia_none','pk7600004101301_p3_nsvia','7600004101301','2137f68df828ce00c276a38b969cd651efcc2f8300f9fb4a716b6fd10019862f.zip',array['gid', 'bairro AS nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600004101301_p3_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600004101_001/*Bairros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Piracicaba/_pk0041.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Piracicaba/_pk0041.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-SP-Piracicaba','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Piracicaba/_pk0041.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Piracicaba/_pk0041.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Piracicaba/_pk0041.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Piracicaba/_pk0041.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600004101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600004101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/f40eeaa6fe4f78e52be084392cc9c04d07a95112f7fb2acaf3210fd23fbdf4a8.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/f40eeaa6fe4f78e52be084392cc9c04d07a95112f7fb2acaf3210fd23fbdf4a8.zip && sudo chmod 664 /var/www/dl.digital-guard.org/f40eeaa6fe4f78e52be084392cc9c04d07a95112f7fb2acaf3210fd23fbdf4a8.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600004101101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600004101_001; 7z  x -y /var/www/dl.digital-guard.org/f40eeaa6fe4f78e52be084392cc9c04d07a95112f7fb2acaf3210fd23fbdf4a8.zip "*Cadastro de Imoveis*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
cd /tmp/sandbox/_pk7600004101_001; shp2pgsql -D -W ISO-8859-1  -s 4326 "Cadastro de Imoveis.shp" pk7600004101101_p1_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600004101_001/Cadastro de Imoveis.shp','parcel_full','pk7600004101101_p1_parcel','7600004101101','f40eeaa6fe4f78e52be084392cc9c04d07a95112f7fb2acaf3210fd23fbdf4a8.zip',array['gid', 'bairro_imo AS nsvia', 'cep_imovel AS postcode', 'logradouro AS via', 'numero_imo AS hnum', 'unidades', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600004101101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600004101_001/*Cadastro de Imoveis.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Piracicaba/_pk0041.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Piracicaba/_pk0041.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-SP-Piracicaba','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Piracicaba/_pk0041.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Piracicaba/_pk0041.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Piracicaba/_pk0041.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Piracicaba/_pk0041.01/parcel -type f -exec chmod 664 {} \;





