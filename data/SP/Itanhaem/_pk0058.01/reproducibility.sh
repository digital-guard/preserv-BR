#!/bin/bash







# layer geoaddress:
rm -rf /tmp/sandbox/_pk7600005801_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600005801_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/78f10da32c1dfab83bdbb448884731fffba15a36c88337b122bc6e896a841302.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/78f10da32c1dfab83bdbb448884731fffba15a36c88337b122bc6e896a841302.zip && sudo chmod 664 /var/www/dl.digital-guard.org/78f10da32c1dfab83bdbb448884731fffba15a36c88337b122bc6e896a841302.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005801101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk7600005801_001; 7z  x -y /var/www/dl.digital-guard.org/78f10da32c1dfab83bdbb448884731fffba15a36c88337b122bc6e896a841302.zip "*CENTROIDES*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600005801_001; shp2pgsql -D   -s 31983 "CENTROIDES.shp" pk7600005801101_p1_geoaddress | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600005801_001/CENTROIDES.shp','geoaddress_full','pk7600005801101_p1_geoaddress','7600005801101','78f10da32c1dfab83bdbb448884731fffba15a36c88337b122bc6e896a841302.zip',array['gid', 'Cadastro_7 as via', 'Cadastro_8 as hnum', 'geom'],1,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005801101_p1_geoaddress CASCADE"
rm -f /tmp/sandbox/_pk7600005801_001/*CENTROIDES.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','BR-SP-Itanhaem','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/geoaddress','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/geoaddress -type f -exec chmod 664 {} \;

# layer nsvia:
rm -rf /tmp/sandbox/_pk7600005801_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600005801_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/023071f87e4bb37e46d42cee7841f3a2119b8f65d2778604af3644f279cf89f1.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/023071f87e4bb37e46d42cee7841f3a2119b8f65d2778604af3644f279cf89f1.zip && sudo chmod 664 /var/www/dl.digital-guard.org/023071f87e4bb37e46d42cee7841f3a2119b8f65d2778604af3644f279cf89f1.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005801201_p2_nsvia CASCADE"
cd /tmp/sandbox/_pk7600005801_001; 7z  x -y /var/www/dl.digital-guard.org/023071f87e4bb37e46d42cee7841f3a2119b8f65d2778604af3644f279cf89f1.zip "*ABAIRRAMENTO*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600005801_001; shp2pgsql -D   -s 31983 "ABAIRRAMENTO.shp" pk7600005801201_p2_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600005801_001/ABAIRRAMENTO.shp','nsvia_full','pk7600005801201_p2_nsvia','7600005801201','023071f87e4bb37e46d42cee7841f3a2119b8f65d2778604af3644f279cf89f1.zip',array['gid', 'NOME as nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005801201_p2_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600005801_001/*ABAIRRAMENTO.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-SP-Itanhaem','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600005801_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600005801_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/7e8269d4c80f9a03cc999a44f028c00dd296868ee26b61f012dc53211e760417.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/7e8269d4c80f9a03cc999a44f028c00dd296868ee26b61f012dc53211e760417.zip && sudo chmod 664 /var/www/dl.digital-guard.org/7e8269d4c80f9a03cc999a44f028c00dd296868ee26b61f012dc53211e760417.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005801301_p3_parcel CASCADE"
cd /tmp/sandbox/_pk7600005801_001; 7z  x -y /var/www/dl.digital-guard.org/7e8269d4c80f9a03cc999a44f028c00dd296868ee26b61f012dc53211e760417.zip "*LOTES_2020*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=29193"
cd /tmp/sandbox/_pk7600005801_001; shp2pgsql -D -W UTF-8  -s 29193 "LOTES_2020.shp" pk7600005801301_p3_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600005801_001/LOTES_2020.shp','parcel_full','pk7600005801301_p3_parcel','7600005801301','7e8269d4c80f9a03cc999a44f028c00dd296868ee26b61f012dc53211e760417.zip',array['gid', 'Cadastro_7 as via', 'Cadastro_8 as hnum', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005801301_p3_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600005801_001/*LOTES_2020.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-SP-Itanhaem','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600005801_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600005801_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/3137911874246d45f025f2b98066f1e7a31543332e175e83f433005d131c40fe.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/3137911874246d45f025f2b98066f1e7a31543332e175e83f433005d131c40fe.zip && sudo chmod 664 /var/www/dl.digital-guard.org/3137911874246d45f025f2b98066f1e7a31543332e175e83f433005d131c40fe.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005801401_p4_via CASCADE"
cd /tmp/sandbox/_pk7600005801_001; 7z  x -y /var/www/dl.digital-guard.org/3137911874246d45f025f2b98066f1e7a31543332e175e83f433005d131c40fe.zip "*ARRUAMENTO*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600005801_001; shp2pgsql -D   -s 31983 "ARRUAMENTO.shp" pk7600005801401_p4_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw4_pk7600005801401_p4_via AS SELECT gid, tr_tipo || ' ' || tr_descric AS via, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/ARRUAMENTO.shp','via_full','vw4_pk7600005801401_p4_via','7600005801401','3137911874246d45f025f2b98066f1e7a31543332e175e83f433005d131c40fe.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw4_pk7600005801401_p4_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600005801401_p4_via CASCADE"
rm -f /tmp/sandbox/_pk7600005801_001/*ARRUAMENTO.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-SP-Itanhaem','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Itanhaem/_pk0058.01/via -type f -exec chmod 664 {} \;




