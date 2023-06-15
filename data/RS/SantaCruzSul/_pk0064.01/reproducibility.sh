#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600006401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600006401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/a3eab1ae42ce304d9bbd119ebb769b6c93c40f04b1f09c6e0e9ec322320da7ff.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/a3eab1ae42ce304d9bbd119ebb769b6c93c40f04b1f09c6e0e9ec322320da7ff.zip && sudo chmod 664 /var/www/dl.digital-guard.org/a3eab1ae42ce304d9bbd119ebb769b6c93c40f04b1f09c6e0e9ec322320da7ff.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006401101_p1_block CASCADE"
cd /tmp/sandbox/_pk7600006401_001; 7z  x -y /var/www/dl.digital-guard.org/a3eab1ae42ce304d9bbd119ebb769b6c93c40f04b1f09c6e0e9ec322320da7ff.zip "*santa_cruz_do_sul_rs_quadras*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600006401_001; shp2pgsql -D   -s 31982 "santa_cruz_do_sul_rs_quadras.shp" pk7600006401101_p1_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600006401_001/santa_cruz_do_sul_rs_quadras.shp','block_full','pk7600006401101_p1_block','7600006401101','a3eab1ae42ce304d9bbd119ebb769b6c93c40f04b1f09c6e0e9ec322320da7ff.zip',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006401101_p1_block CASCADE"
rm -f /tmp/sandbox/_pk7600006401_001/*santa_cruz_do_sul_rs_quadras.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-RS-SantaCruzSul','/var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/block -type f -exec chmod 664 {} \;






# layer nsvia:
rm -rf /tmp/sandbox/_pk7600006401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600006401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/8cfffc8d4ab052dd653748fd22c52ad708609e8c3c30283f57a7b2627fbf8aca.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/8cfffc8d4ab052dd653748fd22c52ad708609e8c3c30283f57a7b2627fbf8aca.zip && sudo chmod 664 /var/www/dl.digital-guard.org/8cfffc8d4ab052dd653748fd22c52ad708609e8c3c30283f57a7b2627fbf8aca.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006401201_p2_nsvia CASCADE"
cd /tmp/sandbox/_pk7600006401_001; 7z  x -y /var/www/dl.digital-guard.org/8cfffc8d4ab052dd653748fd22c52ad708609e8c3c30283f57a7b2627fbf8aca.zip "*santa_cruz_do_sul_rs_bairros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600006401_001; shp2pgsql -D   -s 31982 "santa_cruz_do_sul_rs_bairros.shp" pk7600006401201_p2_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600006401_001/santa_cruz_do_sul_rs_bairros.shp','nsvia_full','pk7600006401201_p2_nsvia','7600006401201','8cfffc8d4ab052dd653748fd22c52ad708609e8c3c30283f57a7b2627fbf8aca.zip',array['gid', 'NAME1_ as nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006401201_p2_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600006401_001/*santa_cruz_do_sul_rs_bairros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-RS-SantaCruzSul','/var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600006401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600006401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/3b4634f38fafd4d3a779b1f7a1075ab2fd6b951509290849f26813319920b2fa.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/3b4634f38fafd4d3a779b1f7a1075ab2fd6b951509290849f26813319920b2fa.zip && sudo chmod 664 /var/www/dl.digital-guard.org/3b4634f38fafd4d3a779b1f7a1075ab2fd6b951509290849f26813319920b2fa.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006401301_p3_parcel CASCADE"
cd /tmp/sandbox/_pk7600006401_001; 7z  x -y /var/www/dl.digital-guard.org/3b4634f38fafd4d3a779b1f7a1075ab2fd6b951509290849f26813319920b2fa.zip "*rs_scs_lotes_com_ceps_e_numeracao*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600006401_001; shp2pgsql -D   -s 31982 "rs_scs_lotes_com_ceps_e_numeracao.shp" pk7600006401301_p3_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600006401_001/rs_scs_lotes_com_ceps_e_numeracao.shp','parcel_full','pk7600006401301_p3_parcel','7600006401301','3b4634f38fafd4d3a779b1f7a1075ab2fd6b951509290849f26813319920b2fa.zip',array['gid', 'logradouro as via', 'numeracao as hnum', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006401301_p3_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600006401_001/*rs_scs_lotes_com_ceps_e_numeracao.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-RS-SantaCruzSul','/var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600006401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600006401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/5c7bc9d5d753681db743235e647cb653efe34404aad61b040af89cc2ec68bbe2.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/5c7bc9d5d753681db743235e647cb653efe34404aad61b040af89cc2ec68bbe2.zip && sudo chmod 664 /var/www/dl.digital-guard.org/5c7bc9d5d753681db743235e647cb653efe34404aad61b040af89cc2ec68bbe2.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006401401_p4_via CASCADE"
cd /tmp/sandbox/_pk7600006401_001; 7z  x -y /var/www/dl.digital-guard.org/5c7bc9d5d753681db743235e647cb653efe34404aad61b040af89cc2ec68bbe2.zip "*santa_cruz_do_sul_rs_eixos*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600006401_001; shp2pgsql -D   -s 31982 "santa_cruz_do_sul_rs_eixos.shp" pk7600006401401_p4_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600006401_001/santa_cruz_do_sul_rs_eixos.shp','via_full','pk7600006401401_p4_via','7600006401401','5c7bc9d5d753681db743235e647cb653efe34404aad61b040af89cc2ec68bbe2.zip',array['gid', 'logradouro as via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006401401_p4_via CASCADE"
rm -f /tmp/sandbox/_pk7600006401_001/*santa_cruz_do_sul_rs_eixos.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-RS-SantaCruzSul','/var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/SantaCruzSul/_pk0064.01/via -type f -exec chmod 664 {} \;




