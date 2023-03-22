#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600008401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600008401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/607ba1a0c854d6c93a0e57a95fa8851be3abe05b292b477ee5eb71ec245b1fae.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/607ba1a0c854d6c93a0e57a95fa8851be3abe05b292b477ee5eb71ec245b1fae.rar && sudo chmod 664 /var/www/dl.digital-guard.org/607ba1a0c854d6c93a0e57a95fa8851be3abe05b292b477ee5eb71ec245b1fae.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008401101_p1_block CASCADE"
cd /tmp/sandbox/_pk7600008401_001; 7z  x -y /var/www/dl.digital-guard.org/607ba1a0c854d6c93a0e57a95fa8851be3abe05b292b477ee5eb71ec245b1fae.rar "*GEO-SOCIAIS ADDRESSFORALL/QUADRAS*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600008401_001; shp2pgsql -D   -s 31982 "GEO-SOCIAIS ADDRESSFORALL/QUADRAS.shp" pk7600008401101_p1_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600008401101_p1_block AS SELECT gid, 'Q '|| num_qdr AS name, tp_bai ||' '|| nm_bai AS nsvia, num_bai AS nsref, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/GEO-SOCIAIS ADDRESSFORALL/QUADRAS.shp','block_full','vw1_pk7600008401101_p1_block','7600008401101','607ba1a0c854d6c93a0e57a95fa8851be3abe05b292b477ee5eb71ec245b1fae.rar',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600008401101_p1_block"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008401101_p1_block CASCADE"
rm -f /tmp/sandbox/_pk7600008401_001/*GEO-SOCIAIS ADDRESSFORALL/QUADRAS.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-GO-AparecidaGoiania','/var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/block -type f -exec chmod 664 {} \;






# layer nsvia:
rm -rf /tmp/sandbox/_pk7600008401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600008401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/607ba1a0c854d6c93a0e57a95fa8851be3abe05b292b477ee5eb71ec245b1fae.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/607ba1a0c854d6c93a0e57a95fa8851be3abe05b292b477ee5eb71ec245b1fae.rar && sudo chmod 664 /var/www/dl.digital-guard.org/607ba1a0c854d6c93a0e57a95fa8851be3abe05b292b477ee5eb71ec245b1fae.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008401101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk7600008401_001; 7z  x -y /var/www/dl.digital-guard.org/607ba1a0c854d6c93a0e57a95fa8851be3abe05b292b477ee5eb71ec245b1fae.rar "*GEO-SOCIAIS ADDRESSFORALL/BAIRROS*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600008401_001; shp2pgsql -D   -s 31982 "GEO-SOCIAIS ADDRESSFORALL/BAIRROS.shp" pk7600008401101_p1_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600008401_001/GEO-SOCIAIS ADDRESSFORALL/BAIRROS.shp','nsvia_full','pk7600008401101_p1_nsvia','7600008401101','607ba1a0c854d6c93a0e57a95fa8851be3abe05b292b477ee5eb71ec245b1fae.rar',array['gid', 'bairro_ful AS nsvia', 'num_bai AS ref', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008401101_p1_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600008401_001/*GEO-SOCIAIS ADDRESSFORALL/BAIRROS.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-GO-AparecidaGoiania','/var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600008401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600008401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/607ba1a0c854d6c93a0e57a95fa8851be3abe05b292b477ee5eb71ec245b1fae.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/607ba1a0c854d6c93a0e57a95fa8851be3abe05b292b477ee5eb71ec245b1fae.rar && sudo chmod 664 /var/www/dl.digital-guard.org/607ba1a0c854d6c93a0e57a95fa8851be3abe05b292b477ee5eb71ec245b1fae.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008401101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600008401_001; 7z  x -y /var/www/dl.digital-guard.org/607ba1a0c854d6c93a0e57a95fa8851be3abe05b292b477ee5eb71ec245b1fae.rar "*GEO-SOCIAIS ADDRESSFORALL/LOTES*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600008401_001; shp2pgsql -D   -s 31982 "GEO-SOCIAIS ADDRESSFORALL/LOTES.shp" pk7600008401101_p1_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600008401101_p1_parcel AS SELECT gid, ( CASE WHEN ((trim(num_qdr)  = '') IS FALSE) THEN 'Q '|| trim(num_qdr)  ELSE '?' END || ', ' || CASE WHEN ((trim(num_lot) = '') IS FALSE) THEN 'LT '|| trim(num_lot) ELSE '?' END ) AS sup, tp_bai ||' '|| nm_bai AS nsvia, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/GEO-SOCIAIS ADDRESSFORALL/LOTES.shp','parcel_none','vw1_pk7600008401101_p1_parcel','7600008401101','607ba1a0c854d6c93a0e57a95fa8851be3abe05b292b477ee5eb71ec245b1fae.rar',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600008401101_p1_parcel"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008401101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600008401_001/*GEO-SOCIAIS ADDRESSFORALL/LOTES.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-GO-AparecidaGoiania','/var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600008401_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600008401_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/607ba1a0c854d6c93a0e57a95fa8851be3abe05b292b477ee5eb71ec245b1fae.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/607ba1a0c854d6c93a0e57a95fa8851be3abe05b292b477ee5eb71ec245b1fae.rar && sudo chmod 664 /var/www/dl.digital-guard.org/607ba1a0c854d6c93a0e57a95fa8851be3abe05b292b477ee5eb71ec245b1fae.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008401101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600008401_001; 7z  x -y /var/www/dl.digital-guard.org/607ba1a0c854d6c93a0e57a95fa8851be3abe05b292b477ee5eb71ec245b1fae.rar "*GEO-SOCIAIS ADDRESSFORALL/LOGRADOUROS*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
cd /tmp/sandbox/_pk7600008401_001; shp2pgsql -D   -s 31982 "GEO-SOCIAIS ADDRESSFORALL/LOGRADOUROS.shp" pk7600008401101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600008401101_p1_via AS SELECT gid, tp_log ||' '|| nm_log AS via, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/GEO-SOCIAIS ADDRESSFORALL/LOGRADOUROS.shp','via_full','vw1_pk7600008401101_p1_via','7600008401101','607ba1a0c854d6c93a0e57a95fa8851be3abe05b292b477ee5eb71ec245b1fae.rar',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600008401101_p1_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600008401101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600008401_001/*GEO-SOCIAIS ADDRESSFORALL/LOGRADOUROS.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-GO-AparecidaGoiania','/var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/GO/AparecidaGoiania/_pk0084.01/via -type f -exec chmod 664 {} \;




