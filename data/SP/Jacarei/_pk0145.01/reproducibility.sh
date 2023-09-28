#!/bin/bash




# layer cadparcel:
rm -rf /tmp/sandbox/_pk7600014501_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600014501_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar && sudo chmod 664 /var/www/dl.digital-guard.org/16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk7600014501101_p1_cadparcel CASCADE"
cd /tmp/sandbox/_pk7600014501_001; 7z  x -y /var/www/dl.digital-guard.org/16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar "*AddressForAll/LOTES_COM_NUMERO_TODOS*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
xlsx2csv -i  "/tmp/sandbox/_pk7600014501_001/AddressForAll/LOTES_COM_NUMERO_TODOS.xlsx" "/tmp/sandbox/_pk7600014501_001/AddressForAll/LOTES_COM_NUMERO_TODOS.csv"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.fdw_generate_direct_csv( '/tmp/sandbox/_pk7600014501_001/AddressForAll/LOTES_COM_NUMERO_TODOS.csv', 'pk7600014501101_p1_cadparcel' )"

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600014501101_p1_cadparcel AS SELECT row_number() OVER () AS gid, trim(replace(\"Inscrição Imobiliária\",'.','')) AS insclote, trim(split_part(\"Endereço\", ',', 1)) AS via, trim(split_part(split_part(\"Endereço\", ',', 2),'-',1)) AS hnum, trim(split_part(regexp_replace (split_part(\"Endereço\", ',', 2),'\-', ';'),';',2)) AS nsvia FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('csv2sql','/tmp/sandbox/AddressForAll/LOTES_COM_NUMERO_TODOS.xlsx','cadparcel_cmpl','vw1_pk7600014501101_p1_cadparcel','7600014501101','16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600014501101_p1_cadparcel"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.cadastral_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk7600014501101_p1_cadparcel CASCADE"
rm -f /tmp/sandbox/_pk7600014501_001/*AddressForAll/LOTES_COM_NUMERO_TODOS.* || true




# layer nsvia:
rm -rf /tmp/sandbox/_pk7600014501_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600014501_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar && sudo chmod 664 /var/www/dl.digital-guard.org/16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600014501101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk7600014501_001; 7z  x -y /var/www/dl.digital-guard.org/16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar "*AddressForAll/Loteamentos_2017*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600014501_001; shp2pgsql -D   -s 31983 "AddressForAll/Loteamentos_2017.shp" pk7600014501101_p1_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600014501_001/AddressForAll/Loteamentos_2017.shp','nsvia_full','pk7600014501101_p1_nsvia','7600014501101','16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar',array['gid', 'LOTEAMENTO as nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600014501101_p1_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600014501_001/*AddressForAll/Loteamentos_2017.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jacarei/_pk0145.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jacarei/_pk0145.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-SP-Jacarei','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Jacarei/_pk0145.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jacarei/_pk0145.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jacarei/_pk0145.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jacarei/_pk0145.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600014501_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600014501_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar && sudo chmod 664 /var/www/dl.digital-guard.org/16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600014501101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600014501_001; 7z  x -y /var/www/dl.digital-guard.org/16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar "*AddressForAll/LOTES_2021*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600014501_001; shp2pgsql -D   -s 31983 "AddressForAll/LOTES_2021.shp" pk7600014501101_p1_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600014501_001/AddressForAll/LOTES_2021.shp','parcel_ext','pk7600014501101_p1_parcel','7600014501101','16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar',array['gid', 'INSCLOTE', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600014501101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600014501_001/*AddressForAll/LOTES_2021.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jacarei/_pk0145.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jacarei/_pk0145.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-SP-Jacarei','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Jacarei/_pk0145.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jacarei/_pk0145.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jacarei/_pk0145.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jacarei/_pk0145.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600014501_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600014501_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar && sudo chmod 664 /var/www/dl.digital-guard.org/16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600014501101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600014501_001; 7z  x -y /var/www/dl.digital-guard.org/16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar "*AddressForAll/Eixo_logradouros_nomes*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600014501_001; shp2pgsql -D   -s 31983 "AddressForAll/Eixo_logradouros_nomes.shp" pk7600014501101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600014501_001/AddressForAll/Eixo_logradouros_nomes.shp','via_full','pk7600014501101_p1_via','7600014501101','16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar',array['gid', 'Nome_LOG as via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600014501101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600014501_001/*AddressForAll/Eixo_logradouros_nomes.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jacarei/_pk0145.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jacarei/_pk0145.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-SP-Jacarei','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Jacarei/_pk0145.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jacarei/_pk0145.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jacarei/_pk0145.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Jacarei/_pk0145.01/via -type f -exec chmod 664 {} \;



# layer joining



psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.join('parcel_ext','insclote','16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar','cadparcel_cmpl','insclote','16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar')"

