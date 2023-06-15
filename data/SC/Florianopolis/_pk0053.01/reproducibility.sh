#!/bin/bash





# layer cadvia:
rm -rf /tmp/sandbox/_pk7600005301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600005301_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/49c6dd8968a97b80ddd50f37db3204ae63278f7a9cda94fa35b03429d53a96a6.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/49c6dd8968a97b80ddd50f37db3204ae63278f7a9cda94fa35b03429d53a96a6.rar && sudo chmod 664 /var/www/dl.digital-guard.org/49c6dd8968a97b80ddd50f37db3204ae63278f7a9cda94fa35b03429d53a96a6.rar
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk7600005301101_p1_cadvia CASCADE"
cd /tmp/sandbox/_pk7600005301_001; 7z  x -y /var/www/dl.digital-guard.org/49c6dd8968a97b80ddd50f37db3204ae63278f7a9cda94fa35b03429d53a96a6.rar "*atributo_logradouro*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
iconv -f ISO-8859-15 -t UTF-8 /tmp/sandbox/_pk7600005301_001/atributo_logradouro.csv | dos2unix > /tmp/sandbox/_pk7600005301_001/atributo_logradouro.unix_utf8.csv
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.fdw_generate_direct_csv( '/tmp/sandbox/_pk7600005301_001/atributo_logradouro.unix_utf8.csv', 'pk7600005301101_p1_cadvia' )"

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600005301101_p1_cadvia AS SELECT row_number() OVER () AS gid, cd_atrb, nm_atrb, nm_descricao  FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('csv2sql','/tmp/sandbox/atributo_logradouro.csv','cadvia_noid','vw1_pk7600005301101_p1_cadvia','7600005301101','49c6dd8968a97b80ddd50f37db3204ae63278f7a9cda94fa35b03429d53a96a6.rar',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600005301101_p1_cadvia"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.cadastral_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk7600005301101_p1_cadvia CASCADE"
rm -f /tmp/sandbox/_pk7600005301_001/*atributo_logradouro.* || true



# layer nsvia:
rm -rf /tmp/sandbox/_pk7600005301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600005301_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/49c6dd8968a97b80ddd50f37db3204ae63278f7a9cda94fa35b03429d53a96a6.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/49c6dd8968a97b80ddd50f37db3204ae63278f7a9cda94fa35b03429d53a96a6.rar && sudo chmod 664 /var/www/dl.digital-guard.org/49c6dd8968a97b80ddd50f37db3204ae63278f7a9cda94fa35b03429d53a96a6.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005301101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk7600005301_001; 7z  x -y /var/www/dl.digital-guard.org/49c6dd8968a97b80ddd50f37db3204ae63278f7a9cda94fa35b03429d53a96a6.rar "*bairro*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600005301_001; shp2pgsql -D   -s 31982 "bairro.shp" pk7600005301101_p1_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600005301_001/bairro.shp','nsvia_full','pk7600005301101_p1_nsvia','7600005301101','49c6dd8968a97b80ddd50f37db3204ae63278f7a9cda94fa35b03429d53a96a6.rar',array['gid', 'nm_bairro', 'label AS nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005301101_p1_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600005301_001/*bairro.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SC/Florianopolis/_pk0053.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SC/Florianopolis/_pk0053.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-SC-Florianopolis','/var/gits/_dg/preservCutGeo-BR2021/data/SC/Florianopolis/_pk0053.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SC/Florianopolis/_pk0053.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Florianopolis/_pk0053.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Florianopolis/_pk0053.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600005301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600005301_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/cb4f94bedbafd003b4791954e07b05a591a36bbace9cd6ca6576ed840b32bd8c.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/cb4f94bedbafd003b4791954e07b05a591a36bbace9cd6ca6576ed840b32bd8c.zip && sudo chmod 664 /var/www/dl.digital-guard.org/cb4f94bedbafd003b4791954e07b05a591a36bbace9cd6ca6576ed840b32bd8c.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005301201_p2_parcel CASCADE"
cd /tmp/sandbox/_pk7600005301_001; 7z  x -y /var/www/dl.digital-guard.org/cb4f94bedbafd003b4791954e07b05a591a36bbace9cd6ca6576ed840b32bd8c.zip "*view_cotr_imobliario_filtro*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600005301_001; shp2pgsql -D   -s 31982 "view_cotr_imobliario_filtro.shp" pk7600005301201_p2_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw2_pk7600005301201_p2_parcel AS SELECT gid, split_part(logradouro, ',', 1) AS via, split_part(logradouro, ',', 2) AS hnum, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/view_cotr_imobliario_filtro.shp','parcel_full','vw2_pk7600005301201_p2_parcel','7600005301201','cb4f94bedbafd003b4791954e07b05a591a36bbace9cd6ca6576ed840b32bd8c.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw2_pk7600005301201_p2_parcel"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005301201_p2_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600005301_001/*view_cotr_imobliario_filtro.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SC/Florianopolis/_pk0053.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SC/Florianopolis/_pk0053.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-SC-Florianopolis','/var/gits/_dg/preservCutGeo-BR2021/data/SC/Florianopolis/_pk0053.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SC/Florianopolis/_pk0053.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Florianopolis/_pk0053.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Florianopolis/_pk0053.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600005301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600005301_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/49c6dd8968a97b80ddd50f37db3204ae63278f7a9cda94fa35b03429d53a96a6.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/49c6dd8968a97b80ddd50f37db3204ae63278f7a9cda94fa35b03429d53a96a6.rar && sudo chmod 664 /var/www/dl.digital-guard.org/49c6dd8968a97b80ddd50f37db3204ae63278f7a9cda94fa35b03429d53a96a6.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005301101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600005301_001; 7z  x -y /var/www/dl.digital-guard.org/49c6dd8968a97b80ddd50f37db3204ae63278f7a9cda94fa35b03429d53a96a6.rar "*logradouros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600005301_001; shp2pgsql -D   -s 31982 "logradouros.shp" pk7600005301101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600005301_001/logradouros.shp','via_full','pk7600005301101_p1_via','7600005301101','49c6dd8968a97b80ddd50f37db3204ae63278f7a9cda94fa35b03429d53a96a6.rar',array['gid', 'cd_logr', 'nome AS via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005301101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600005301_001/*logradouros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SC/Florianopolis/_pk0053.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SC/Florianopolis/_pk0053.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-SC-Florianopolis','/var/gits/_dg/preservCutGeo-BR2021/data/SC/Florianopolis/_pk0053.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SC/Florianopolis/_pk0053.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Florianopolis/_pk0053.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SC/Florianopolis/_pk0053.01/via -type f -exec chmod 664 {} \;




