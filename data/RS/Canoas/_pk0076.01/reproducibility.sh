#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600007601_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007601_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/23916aea28282c1c2485ff18fa561728bcfc087c2999d9a9575658e32a66f782.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/23916aea28282c1c2485ff18fa561728bcfc087c2999d9a9575658e32a66f782.zip && sudo chmod 664 /var/www/dl.digital-guard.org/23916aea28282c1c2485ff18fa561728bcfc087c2999d9a9575658e32a66f782.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007601101_p1_block CASCADE"
cd /tmp/sandbox/_pk7600007601_001; 7z  x -y /var/www/dl.digital-guard.org/23916aea28282c1c2485ff18fa561728bcfc087c2999d9a9575658e32a66f782.zip "*quadra*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600007601_001; shp2pgsql -D   -s 31982 "quadra.shp" pk7600007601101_p1_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600007601_001/quadra.shp','block_full','pk7600007601101_p1_block','7600007601101','23916aea28282c1c2485ff18fa561728bcfc087c2999d9a9575658e32a66f782.zip',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007601101_p1_block CASCADE"
rm -f /tmp/sandbox/_pk7600007601_001/*quadra.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-RS-Canoas','/var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/block -type f -exec chmod 664 {} \;

# layer building:
rm -rf /tmp/sandbox/_pk7600007601_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007601_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/6536687209661fd36ce85976660e736b76cb2597c9a6402df810fe623aa2e569.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/6536687209661fd36ce85976660e736b76cb2597c9a6402df810fe623aa2e569.zip && sudo chmod 664 /var/www/dl.digital-guard.org/6536687209661fd36ce85976660e736b76cb2597c9a6402df810fe623aa2e569.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007601201_p2_building CASCADE"
cd /tmp/sandbox/_pk7600007601_001; 7z  x -y /var/www/dl.digital-guard.org/6536687209661fd36ce85976660e736b76cb2597c9a6402df810fe623aa2e569.zip "*Edificacao*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600007601_001; shp2pgsql -D   -s 31982 "Edificacao.shp" pk7600007601201_p2_building | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600007601_001/Edificacao.shp','building_full','pk7600007601201_p2_building','7600007601201','6536687209661fd36ce85976660e736b76cb2597c9a6402df810fe623aa2e569.zip',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007601201_p2_building CASCADE"
rm -f /tmp/sandbox/_pk7600007601_001/*Edificacao.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/building
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/building/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('building','BR-RS-Canoas','/var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/building','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/building
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/building -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/building -type f -exec chmod 664 {} \;





# layer nsvia:
rm -rf /tmp/sandbox/_pk7600007601_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007601_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/62972bc1f5accf55c5ea97f9154f246a111cde13c4da881798668e12b0a03a41.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/62972bc1f5accf55c5ea97f9154f246a111cde13c4da881798668e12b0a03a41.zip && sudo chmod 664 /var/www/dl.digital-guard.org/62972bc1f5accf55c5ea97f9154f246a111cde13c4da881798668e12b0a03a41.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007601301_p3_nsvia CASCADE"
cd /tmp/sandbox/_pk7600007601_001; 7z  x -y /var/www/dl.digital-guard.org/62972bc1f5accf55c5ea97f9154f246a111cde13c4da881798668e12b0a03a41.zip "*LIMITE_BAIRROS*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600007601_001; shp2pgsql -D   -s 31982 "LIMITE_BAIRROS.shp" pk7600007601301_p3_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw3_pk7600007601301_p3_nsvia AS SELECT gid, 'Bairro' AS nsvia, ST_MakePolygon(ST_LineMerge(geom)) AS geom FROM $(tabname) WHERE ST_IsClosed(geom) IS TRUE"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/LIMITE_BAIRROS.shp','nsvia_full','vw3_pk7600007601301_p3_nsvia','7600007601301','62972bc1f5accf55c5ea97f9154f246a111cde13c4da881798668e12b0a03a41.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw3_pk7600007601301_p3_nsvia"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007601301_p3_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600007601_001/*LIMITE_BAIRROS.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-RS-Canoas','/var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600007601_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007601_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/4f5971ab149c0d936a315fff94fdd8ee5fb2410f2a472b3eaf0d33666ee1043d.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/4f5971ab149c0d936a315fff94fdd8ee5fb2410f2a472b3eaf0d33666ee1043d.zip && sudo chmod 664 /var/www/dl.digital-guard.org/4f5971ab149c0d936a315fff94fdd8ee5fb2410f2a472b3eaf0d33666ee1043d.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007601401_p4_parcel CASCADE"
cd /tmp/sandbox/_pk7600007601_001; 7z  x -y /var/www/dl.digital-guard.org/4f5971ab149c0d936a315fff94fdd8ee5fb2410f2a472b3eaf0d33666ee1043d.zip "*lote_com_rua*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600007601_001; shp2pgsql -D   -s 31982 "lote_com_rua.shp" pk7600007601401_p4_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600007601_001/lote_com_rua.shp','parcel_full','pk7600007601401_p4_parcel','7600007601401','4f5971ab149c0d936a315fff94fdd8ee5fb2410f2a472b3eaf0d33666ee1043d.zip',array['gid', 'LOGRNOME as via', 'ECONUMERO as hnum', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007601401_p4_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600007601_001/*lote_com_rua.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-RS-Canoas','/var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600007601_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007601_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/8dd9b6e7e03435fd0adb687313f754cfd76488f13a4b3cfdcc17a4b8c317be87.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/8dd9b6e7e03435fd0adb687313f754cfd76488f13a4b3cfdcc17a4b8c317be87.zip && sudo chmod 664 /var/www/dl.digital-guard.org/8dd9b6e7e03435fd0adb687313f754cfd76488f13a4b3cfdcc17a4b8c317be87.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007601501_p5_via CASCADE"
cd /tmp/sandbox/_pk7600007601_001; 7z  x -y /var/www/dl.digital-guard.org/8dd9b6e7e03435fd0adb687313f754cfd76488f13a4b3cfdcc17a4b8c317be87.zip "*sistema_viario_atualizado*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600007601_001; shp2pgsql -D   -s 31982 "sistema_viario_atualizado.shp" pk7600007601501_p5_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600007601_001/sistema_viario_atualizado.shp','via_full','pk7600007601501_p5_via','7600007601501','8dd9b6e7e03435fd0adb687313f754cfd76488f13a4b3cfdcc17a4b8c317be87.zip',array['gid', 'ds_logrado as via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007601501_p5_via CASCADE"
rm -f /tmp/sandbox/_pk7600007601_001/*sistema_viario_atualizado.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-RS-Canoas','/var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/Canoas/_pk0076.01/via -type f -exec chmod 664 {} \;




