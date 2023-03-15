#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600006801_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600006801_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/0e5c2d6d8728b11d7a89ada7fb7639756e479761c57b1aa23d9f4bcdec8d480d.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/0e5c2d6d8728b11d7a89ada7fb7639756e479761c57b1aa23d9f4bcdec8d480d.zip && sudo chmod 664 /var/www/dl.digital-guard.org/0e5c2d6d8728b11d7a89ada7fb7639756e479761c57b1aa23d9f4bcdec8d480d.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006801401_p4_block CASCADE"
cd /tmp/sandbox/_pk7600006801_001; 7z  x -y /var/www/dl.digital-guard.org/0e5c2d6d8728b11d7a89ada7fb7639756e479761c57b1aa23d9f4bcdec8d480d.zip "*Quadras*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600006801_001; shp2pgsql -D   -s 31983 "Quadras.shp" pk7600006801401_p4_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600006801_001/Quadras.shp','block_full','pk7600006801401_p4_block','7600006801401','0e5c2d6d8728b11d7a89ada7fb7639756e479761c57b1aa23d9f4bcdec8d480d.zip',array['gid', 'sde_siturb AS ref', 'sde_situ_1 AS nsref', 'sde_situ_2 AS ra_name', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006801401_p4_block CASCADE"
rm -f /tmp/sandbox/_pk7600006801_001/*Quadras.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-DF-Brasilia','/var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/block -type f -exec chmod 664 {} \;

# layer building:
rm -rf /tmp/sandbox/_pk7600006801_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600006801_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/c9aca8c68c827c3a73598b677dc217fd8af5df1b8f53349e37b00ae13bcd46bd.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/c9aca8c68c827c3a73598b677dc217fd8af5df1b8f53349e37b00ae13bcd46bd.zip && sudo chmod 664 /var/www/dl.digital-guard.org/c9aca8c68c827c3a73598b677dc217fd8af5df1b8f53349e37b00ae13bcd46bd.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006801101_p1_building CASCADE"
cd /tmp/sandbox/_pk7600006801_001; 7z  x -y /var/www/dl.digital-guard.org/c9aca8c68c827c3a73598b677dc217fd8af5df1b8f53349e37b00ae13bcd46bd.zip "*edificacoes*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600006801_001; shp2pgsql -D   -s 31983 "edificacoes.shp" pk7600006801101_p1_building | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600006801_001/edificacoes.shp','building_full','pk7600006801101_p1_building','7600006801101','c9aca8c68c827c3a73598b677dc217fd8af5df1b8f53349e37b00ae13bcd46bd.zip',array['gid', 'nome AS name', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006801101_p1_building CASCADE"
rm -f /tmp/sandbox/_pk7600006801_001/*edificacoes.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/building
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/building/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('building','BR-DF-Brasilia','/var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/building','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/building
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/building -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/building -type f -exec chmod 664 {} \;





# layer nsvia:
rm -rf /tmp/sandbox/_pk7600006801_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600006801_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/12a8253e85ad740a408c73dc73224b5b939d8125fdbdf73ae8355338d1250730.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/12a8253e85ad740a408c73dc73224b5b939d8125fdbdf73ae8355338d1250730.zip && sudo chmod 664 /var/www/dl.digital-guard.org/12a8253e85ad740a408c73dc73224b5b939d8125fdbdf73ae8355338d1250730.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006801301_p3_nsvia CASCADE"
cd /tmp/sandbox/_pk7600006801_001; 7z  x -y /var/www/dl.digital-guard.org/12a8253e85ad740a408c73dc73224b5b939d8125fdbdf73ae8355338d1250730.zip "*Setor*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600006801_001; shp2pgsql -D   -s 31983 "Setor.shp" pk7600006801301_p3_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600006801_001/Setor.shp','nsvia_full','pk7600006801301_p3_nsvia','7600006801301','12a8253e85ad740a408c73dc73224b5b939d8125fdbdf73ae8355338d1250730.zip',array['gid', 'sde_siturb AS ref', 'sde_situ_1 AS ra_name', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006801301_p3_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600006801_001/*Setor.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-DF-Brasilia','/var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600006801_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600006801_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/b55567b8f4b77e16eb7805ac2883ffed63b67ec7d39aed103e914bbea0d94750.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/b55567b8f4b77e16eb7805ac2883ffed63b67ec7d39aed103e914bbea0d94750.zip && sudo chmod 664 /var/www/dl.digital-guard.org/b55567b8f4b77e16eb7805ac2883ffed63b67ec7d39aed103e914bbea0d94750.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006801201_p2_parcel CASCADE"
cd /tmp/sandbox/_pk7600006801_001; 7z  x -y /var/www/dl.digital-guard.org/b55567b8f4b77e16eb7805ac2883ffed63b67ec7d39aed103e914bbea0d94750.zip "*Lotes Registrados*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600006801_001; shp2pgsql -D   -s 31983 "Lotes Registrados.shp" pk7600006801201_p2_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw2_pk7600006801201_p2_parcel AS SELECT row_number() OVER () AS gid, ciu AS ref, lote AS pnum, conjunto AS set, quadra AS blref, trim((regexp_match(end_cart, '(.*)'||quadra || ' ' || conjunto || ' ' || lote))[1]) AS nsvia, ra_nome AS ra_name, end_cart AS address, projeto, norma_ante, padrao_cor, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/Lotes Registrados.shp','parcel_full','vw2_pk7600006801201_p2_parcel','7600006801201','b55567b8f4b77e16eb7805ac2883ffed63b67ec7d39aed103e914bbea0d94750.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw2_pk7600006801201_p2_parcel"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600006801201_p2_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600006801_001/*Lotes Registrados.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-DF-Brasilia','/var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/DF/Brasilia/_pk0068.01/parcel -type f -exec chmod 664 {} \;





