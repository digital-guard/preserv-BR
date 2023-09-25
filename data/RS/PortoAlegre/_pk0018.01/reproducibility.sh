#!/bin/bash







# layer geoaddress:
rm -rf /tmp/sandbox/_pk7600001801_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600001801_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/fbc62efdbd0f16a7db03b5b775c50c9425367a8dee8a85d9b53e4475bbdb99d2.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/fbc62efdbd0f16a7db03b5b775c50c9425367a8dee8a85d9b53e4475bbdb99d2.zip && sudo chmod 664 /var/www/dl.digital-guard.org/fbc62efdbd0f16a7db03b5b775c50c9425367a8dee8a85d9b53e4475bbdb99d2.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001801101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk7600001801_001; 7z  x -y /var/www/dl.digital-guard.org/fbc62efdbd0f16a7db03b5b775c50c9425367a8dee8a85d9b53e4475bbdb99d2.zip "*NRO_IMOVEL*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "INSERT INTO spatial_ref_sys (srid, auth_name, auth_srid, proj4text, srtext) VALUES (952071,'carlos',952071,'+proj=tmerc +lat_0=0 +lon_0=-51 +k=0.999995 +x_0=300000 +y_0=5000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs',null);"
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=952071"
cd /tmp/sandbox/_pk7600001801_001; shp2pgsql -D   -s 952071 "NRO_IMOVEL.shp" pk7600001801101_p1_geoaddress | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600001801101_p1_geoaddress AS SELECT gid, textstring AS hnum, setor, last_edi_1 AS dateModified, ST_Centroid(geom) AS geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/NRO_IMOVEL.shp','geoaddress_none','vw1_pk7600001801101_p1_geoaddress','7600001801101','fbc62efdbd0f16a7db03b5b775c50c9425367a8dee8a85d9b53e4475bbdb99d2.zip',array[]::text[],1,2)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600001801101_p1_geoaddress"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001801101_p1_geoaddress CASCADE"
@echo "Delete SRID 952071 configurado via PROJ.4 string:"
@echo "+proj=tmerc +lat_0=0 +lon_0=-51 +k=0.999995 +x_0=300000 +y_0=5000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"
psql postgres://postgres@localhost/ingest1 -c "DELETE FROM spatial_ref_sys WHERE srid=952071;"
rm -f /tmp/sandbox/_pk7600001801_001/*NRO_IMOVEL.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/PortoAlegre/_pk0018.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/PortoAlegre/_pk0018.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','BR-RS-PortoAlegre','/var/gits/_dg/preservCutGeo-BR2021/data/RS/PortoAlegre/_pk0018.01/geoaddress','2',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/PortoAlegre/_pk0018.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/PortoAlegre/_pk0018.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/PortoAlegre/_pk0018.01/geoaddress -type f -exec chmod 664 {} \;

# layer nsvia:
rm -rf /tmp/sandbox/_pk7600001801_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600001801_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/258772459588f7941ac6eeda7c6839df02d58741cf6bc3e48825aecd60418251.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/258772459588f7941ac6eeda7c6839df02d58741cf6bc3e48825aecd60418251.zip && sudo chmod 664 /var/www/dl.digital-guard.org/258772459588f7941ac6eeda7c6839df02d58741cf6bc3e48825aecd60418251.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001801201_p2_nsvia CASCADE"
cd /tmp/sandbox/_pk7600001801_001; 7z  x -y /var/www/dl.digital-guard.org/258772459588f7941ac6eeda7c6839df02d58741cf6bc3e48825aecd60418251.zip "*Bairros_LC12112_16*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "INSERT INTO spatial_ref_sys (srid, auth_name, auth_srid, proj4text, srtext) VALUES (952071,'carlos',952071,'+proj=tmerc +lat_0=0 +lon_0=-51 +k=0.999995 +x_0=300000 +y_0=5000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs',null);"
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=952071"
cd /tmp/sandbox/_pk7600001801_001; shp2pgsql -D   -s 952071 "Bairros_LC12112_16.shp" pk7600001801201_p2_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw2_pk7600001801201_p2_nsvia AS SELECT row_number() OVER () as gid, * \
FROM ( \
  SELECT upper(trim(nome)) as nome, count(*) n, round(sum(st_area(geom))) area, \
         max(data_edica) dateModified, ST_UNION(geom) as geom \
  FROM $(tabname) \
  GROUP BY 1 ORDER BY 1 \
) t"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/Bairros_LC12112_16.shp','nsvia_full','vw2_pk7600001801201_p2_nsvia','7600001801201','258772459588f7941ac6eeda7c6839df02d58741cf6bc3e48825aecd60418251.zip',array[]::text[],4,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw2_pk7600001801201_p2_nsvia"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001801201_p2_nsvia CASCADE"
@echo "Delete SRID 952071 configurado via PROJ.4 string:"
@echo "+proj=tmerc +lat_0=0 +lon_0=-51 +k=0.999995 +x_0=300000 +y_0=5000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"
psql postgres://postgres@localhost/ingest1 -c "DELETE FROM spatial_ref_sys WHERE srid=952071;"
rm -f /tmp/sandbox/_pk7600001801_001/*Bairros_LC12112_16.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/PortoAlegre/_pk0018.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/PortoAlegre/_pk0018.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-RS-PortoAlegre','/var/gits/_dg/preservCutGeo-BR2021/data/RS/PortoAlegre/_pk0018.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/PortoAlegre/_pk0018.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/PortoAlegre/_pk0018.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/PortoAlegre/_pk0018.01/nsvia -type f -exec chmod 664 {} \;


# layer via:
rm -rf /tmp/sandbox/_pk7600001801_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600001801_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/c35e3b2825d3da122a74c6c8dd5f3157a3bd6201208d2a6d13dec433a6ded9fc.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/c35e3b2825d3da122a74c6c8dd5f3157a3bd6201208d2a6d13dec433a6ded9fc.zip && sudo chmod 664 /var/www/dl.digital-guard.org/c35e3b2825d3da122a74c6c8dd5f3157a3bd6201208d2a6d13dec433a6ded9fc.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001801301_p3_via CASCADE"
cd /tmp/sandbox/_pk7600001801_001; 7z  x -y /var/www/dl.digital-guard.org/c35e3b2825d3da122a74c6c8dd5f3157a3bd6201208d2a6d13dec433a6ded9fc.zip "*EixosLogradouros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "INSERT INTO spatial_ref_sys (srid, auth_name, auth_srid, proj4text, srtext) VALUES (952071,'carlos',952071,'+proj=tmerc +lat_0=0 +lon_0=-51 +k=0.999995 +x_0=300000 +y_0=5000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs',null);"
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=952071"
cd /tmp/sandbox/_pk7600001801_001; shp2pgsql -D   -s 952071 "EixosLogradouros.shp" pk7600001801301_p3_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw3_pk7600001801301_p3_via AS SELECT gid, CDIDECAT || iif(NMIDEPRE>'',' ' || NMIDEPRE,''::text) || ' ' || NMIDELOG AS via,\
       NRIMPINI, NRIMPFIN, NRPARINI, NRPARFIN, geom \
FROM $(tabname) \
WHERE CDIDECAT NOT IN ('AR','CN','I','LAGO','RIO') AND NOT(CDIDECAT='LE' AND NMIDELOG ='LIMITE DE PROPRIEDADE')"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/EixosLogradouros.shp','via_full','vw3_pk7600001801301_p3_via','7600001801301','c35e3b2825d3da122a74c6c8dd5f3157a3bd6201208d2a6d13dec433a6ded9fc.zip',array[]::text[],4,2)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw3_pk7600001801301_p3_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600001801301_p3_via CASCADE"
@echo "Delete SRID 952071 configurado via PROJ.4 string:"
@echo "+proj=tmerc +lat_0=0 +lon_0=-51 +k=0.999995 +x_0=300000 +y_0=5000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"
psql postgres://postgres@localhost/ingest1 -c "DELETE FROM spatial_ref_sys WHERE srid=952071;"
rm -f /tmp/sandbox/_pk7600001801_001/*EixosLogradouros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/RS/PortoAlegre/_pk0018.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/RS/PortoAlegre/_pk0018.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-RS-PortoAlegre','/var/gits/_dg/preservCutGeo-BR2021/data/RS/PortoAlegre/_pk0018.01/via','2',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/RS/PortoAlegre/_pk0018.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/PortoAlegre/_pk0018.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/RS/PortoAlegre/_pk0018.01/via -type f -exec chmod 664 {} \;




