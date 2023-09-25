#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600007101_002 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007101_002
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar && sudo chmod 664 /var/www/dl.digital-guard.org/4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007101101_p1_block CASCADE"
cd /tmp/sandbox/_pk7600007101_002; 7z  x -y /var/www/dl.digital-guard.org/4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar "*OpenStreetMap_Shapefiles/QUADRAS*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "INSERT INTO spatial_ref_sys (srid, auth_name, auth_srid, proj4text, srtext) VALUES (952030,'carlos',952030,'+proj=tmerc +lat_0=0 +lon_0=-60 +k=0.999995 +x_0=400000 +y_0=5000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs +type=crs',null);"
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=952030"
cd /tmp/sandbox/_pk7600007101_002; shp2pgsql -D   -s 952030 "OpenStreetMap_Shapefiles/QUADRAS.shp" pk7600007101101_p1_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600007101_002/OpenStreetMap_Shapefiles/QUADRAS.shp','block_full','pk7600007101101_p1_block','7600007101101','4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007101101_p1_block CASCADE"
@echo "Delete SRID 952030 configurado via PROJ.4 string:"
@echo "+proj=tmerc +lat_0=0 +lon_0=-60 +k=0.999995 +x_0=400000 +y_0=5000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs +type=crs"
psql postgres://postgres@localhost/ingest1 -c "DELETE FROM spatial_ref_sys WHERE srid=952030;"
rm -f /tmp/sandbox/_pk7600007101_002/*OpenStreetMap_Shapefiles/QUADRAS.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-AM-Manaus','/var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/block -type f -exec chmod 664 {} \;

# layer building:
rm -rf /tmp/sandbox/_pk7600007101_002 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007101_002
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar && sudo chmod 664 /var/www/dl.digital-guard.org/4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007101101_p1_building CASCADE"
cd /tmp/sandbox/_pk7600007101_002; 7z  x -y /var/www/dl.digital-guard.org/4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar "*OpenStreetMap_Shapefiles/EDIFICACOES*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "INSERT INTO spatial_ref_sys (srid, auth_name, auth_srid, proj4text, srtext) VALUES (952030,'carlos',952030,'+proj=tmerc +lat_0=0 +lon_0=-60 +k=0.999995 +x_0=400000 +y_0=5000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs +type=crs',null);"
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=952030"
cd /tmp/sandbox/_pk7600007101_002; shp2pgsql -D   -s 952030 "OpenStreetMap_Shapefiles/EDIFICACOES.shp" pk7600007101101_p1_building | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600007101_002/OpenStreetMap_Shapefiles/EDIFICACOES.shp','building_none','pk7600007101101_p1_building','7600007101101','4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007101101_p1_building CASCADE"
@echo "Delete SRID 952030 configurado via PROJ.4 string:"
@echo "+proj=tmerc +lat_0=0 +lon_0=-60 +k=0.999995 +x_0=400000 +y_0=5000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs +type=crs"
psql postgres://postgres@localhost/ingest1 -c "DELETE FROM spatial_ref_sys WHERE srid=952030;"
rm -f /tmp/sandbox/_pk7600007101_002/*OpenStreetMap_Shapefiles/EDIFICACOES.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/building
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/building/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('building','BR-AM-Manaus','/var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/building','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/building
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/building -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/building -type f -exec chmod 664 {} \;




# layer geoaddress:
rm -rf /tmp/sandbox/_pk7600007101_002 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007101_002
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar && sudo chmod 664 /var/www/dl.digital-guard.org/4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007101101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk7600007101_002; 7z  x -y /var/www/dl.digital-guard.org/4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar "*OpenStreetMap_Shapefiles/NUMERACAO*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "INSERT INTO spatial_ref_sys (srid, auth_name, auth_srid, proj4text, srtext) VALUES (952030,'carlos',952030,'+proj=tmerc +lat_0=0 +lon_0=-60 +k=0.999995 +x_0=400000 +y_0=5000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs +type=crs',null);"
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=952030"
cd /tmp/sandbox/_pk7600007101_002; shp2pgsql -D   -s 952030 "OpenStreetMap_Shapefiles/NUMERACAO.shp" pk7600007101101_p1_geoaddress | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600007101101_p1_geoaddress AS SELECT gid, ENDEREÇO as via, NUMERACAO as hnum, geom FROM $(tabname) WHERE gid NOT IN (15703, 15767, 15780, 15879, 15937, 16211, 16395, 18290, 18420, 18449, 18450, 18704, 18874, 18931, 18932, 19198, 19199, 19203)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/OpenStreetMap_Shapefiles/NUMERACAO.shp','geoaddress_full','vw1_pk7600007101101_p1_geoaddress','7600007101101','4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar',array[]::text[],1,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600007101101_p1_geoaddress"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007101101_p1_geoaddress CASCADE"
@echo "Delete SRID 952030 configurado via PROJ.4 string:"
@echo "+proj=tmerc +lat_0=0 +lon_0=-60 +k=0.999995 +x_0=400000 +y_0=5000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs +type=crs"
psql postgres://postgres@localhost/ingest1 -c "DELETE FROM spatial_ref_sys WHERE srid=952030;"
rm -f /tmp/sandbox/_pk7600007101_002/*OpenStreetMap_Shapefiles/NUMERACAO.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','BR-AM-Manaus','/var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/geoaddress','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/geoaddress -type f -exec chmod 664 {} \;

# layer nsvia:
rm -rf /tmp/sandbox/_pk7600007101_002 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007101_002
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar && sudo chmod 664 /var/www/dl.digital-guard.org/4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007101101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk7600007101_002; 7z  x -y /var/www/dl.digital-guard.org/4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar "*OpenStreetMap_Shapefiles/BAIRROS*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "INSERT INTO spatial_ref_sys (srid, auth_name, auth_srid, proj4text, srtext) VALUES (952030,'carlos',952030,'+proj=tmerc +lat_0=0 +lon_0=-60 +k=0.999995 +x_0=400000 +y_0=5000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs +type=crs',null);"
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=952030"
cd /tmp/sandbox/_pk7600007101_002; shp2pgsql -D   -s 952030 "OpenStreetMap_Shapefiles/BAIRROS.shp" pk7600007101101_p1_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600007101_002/OpenStreetMap_Shapefiles/BAIRROS.shp','nsvia_full','pk7600007101101_p1_nsvia','7600007101101','4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar',array['gid', 'NOME_BAIRR as nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007101101_p1_nsvia CASCADE"
@echo "Delete SRID 952030 configurado via PROJ.4 string:"
@echo "+proj=tmerc +lat_0=0 +lon_0=-60 +k=0.999995 +x_0=400000 +y_0=5000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs +type=crs"
psql postgres://postgres@localhost/ingest1 -c "DELETE FROM spatial_ref_sys WHERE srid=952030;"
rm -f /tmp/sandbox/_pk7600007101_002/*OpenStreetMap_Shapefiles/BAIRROS.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-AM-Manaus','/var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600007101_002 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007101_002
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/92954f43c27c205f677dd707019bd34d7d47280e74d1eede9def964528671839.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/92954f43c27c205f677dd707019bd34d7d47280e74d1eede9def964528671839.rar && sudo chmod 664 /var/www/dl.digital-guard.org/92954f43c27c205f677dd707019bd34d7d47280e74d1eede9def964528671839.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007101201_p2_parcel CASCADE"
cd /tmp/sandbox/_pk7600007101_002; 7z  x -y /var/www/dl.digital-guard.org/92954f43c27c205f677dd707019bd34d7d47280e74d1eede9def964528671839.rar "*OSM_Lotes/shape/Lotes*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "INSERT INTO spatial_ref_sys (srid, auth_name, auth_srid, proj4text, srtext) VALUES (952030,'carlos',952030,'+proj=tmerc +lat_0=0 +lon_0=-60 +k=0.999995 +x_0=400000 +y_0=5000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs +type=crs',null);"
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=952030"
cd /tmp/sandbox/_pk7600007101_002; shp2pgsql -D   -s 952030 "OSM_Lotes/shape/Lotes.shp" pk7600007101201_p2_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw2_pk7600007101201_p2_parcel AS SELECT gid, LOG_TIPO ||' '|| LOG_NOME AS via, IMO_NUMERO as hnum, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/OSM_Lotes/shape/Lotes.shp','parcel_full','vw2_pk7600007101201_p2_parcel','7600007101201','92954f43c27c205f677dd707019bd34d7d47280e74d1eede9def964528671839.rar',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw2_pk7600007101201_p2_parcel"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007101201_p2_parcel CASCADE"
@echo "Delete SRID 952030 configurado via PROJ.4 string:"
@echo "+proj=tmerc +lat_0=0 +lon_0=-60 +k=0.999995 +x_0=400000 +y_0=5000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs +type=crs"
psql postgres://postgres@localhost/ingest1 -c "DELETE FROM spatial_ref_sys WHERE srid=952030;"
rm -f /tmp/sandbox/_pk7600007101_002/*OSM_Lotes/shape/Lotes.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-AM-Manaus','/var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600007101_002 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007101_002
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar && sudo chmod 664 /var/www/dl.digital-guard.org/4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007101101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600007101_002; 7z  x -y /var/www/dl.digital-guard.org/4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar "*OpenStreetMap_Shapefiles/LOGRADOUROS*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "INSERT INTO spatial_ref_sys (srid, auth_name, auth_srid, proj4text, srtext) VALUES (952030,'carlos',952030,'+proj=tmerc +lat_0=0 +lon_0=-60 +k=0.999995 +x_0=400000 +y_0=5000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs +type=crs',null);"
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=952030"
cd /tmp/sandbox/_pk7600007101_002; shp2pgsql -D   -s 952030 "OpenStreetMap_Shapefiles/LOGRADOUROS.shp" pk7600007101101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600007101101_p1_via AS SELECT gid, TIPO ||' '|| LOGRADOURO AS via, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/OpenStreetMap_Shapefiles/LOGRADOUROS.shp','via_full','vw1_pk7600007101101_p1_via','7600007101101','4134127ab8fe9d96a17d1cfb833437de98a0186e7121db4994ae4763ab4d542a.rar',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600007101101_p1_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007101101_p1_via CASCADE"
@echo "Delete SRID 952030 configurado via PROJ.4 string:"
@echo "+proj=tmerc +lat_0=0 +lon_0=-60 +k=0.999995 +x_0=400000 +y_0=5000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs +type=crs"
psql postgres://postgres@localhost/ingest1 -c "DELETE FROM spatial_ref_sys WHERE srid=952030;"
rm -f /tmp/sandbox/_pk7600007101_002/*OpenStreetMap_Shapefiles/LOGRADOUROS.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-AM-Manaus','/var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/AM/Manaus/_pk0071.01/via -type f -exec chmod 664 {} \;




