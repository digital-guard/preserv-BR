#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600002801_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002801_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/aa41214cef0417fb400b83c2e196fb01d7be3688a560c36cac6e2c54cfa0502a.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/aa41214cef0417fb400b83c2e196fb01d7be3688a560c36cac6e2c54cfa0502a.zip && sudo chmod 664 /var/www/dl.digital-guard.org/aa41214cef0417fb400b83c2e196fb01d7be3688a560c36cac6e2c54cfa0502a.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002801101_p1_block CASCADE"
cd /tmp/sandbox/_pk7600002801_001; 7z  x -y /var/www/dl.digital-guard.org/aa41214cef0417fb400b83c2e196fb01d7be3688a560c36cac6e2c54cfa0502a.zip "*Quadrascadastrais_Quadrascomplementares_sirgasUTM.gpkg*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
sudo docker run --rm --network host -v /tmp/sandbox:/tmp osgeo/gdal ogr2ogr -lco GEOMETRY_NAME=geom -overwrite -f "PostgreSQL" PG:" dbname='ingest1' host='localhost' port='5432' user='postgres' " "/tmp/Quadrascadastrais_Quadrascomplementares_sirgasUTM.gpkg"  -nln pk7600002801101_p1_block -a_srs EPSG:31983  

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('ogr2ogr','/tmp/sandbox/_pk7600002801_001/Quadrascadastrais_Quadrascomplementares_sirgasUTM.gpkg','block_none','pk7600002801101_p1_block','7600002801101','aa41214cef0417fb400b83c2e196fb01d7be3688a560c36cac6e2c54cfa0502a.zip',array['codquadra AS ref'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002801101_p1_block CASCADE"
rm -f /tmp/sandbox/_pk7600002801_001/*Quadrascadastrais_Quadrascomplementares_sirgasUTM.gpkg.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-SP-Osasco','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/block -type f -exec chmod 664 {} \;






# layer nsvia:
rm -rf /tmp/sandbox/_pk7600002801_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002801_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/0332a2f00b8cd344818b1b734859c44c7d6b7604d347ce1619455d9bf2629d64.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/0332a2f00b8cd344818b1b734859c44c7d6b7604d347ce1619455d9bf2629d64.zip && sudo chmod 664 /var/www/dl.digital-guard.org/0332a2f00b8cd344818b1b734859c44c7d6b7604d347ce1619455d9bf2629d64.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002801201_p2_nsvia CASCADE"
cd /tmp/sandbox/_pk7600002801_001; 7z  x -y /var/www/dl.digital-guard.org/0332a2f00b8cd344818b1b734859c44c7d6b7604d347ce1619455d9bf2629d64.zip "*bairros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600002801_001; shp2pgsql -D   -s 31983 "bairros.shp" pk7600002801201_p2_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600002801_001/bairros.shp','nsvia_full','pk7600002801201_p2_nsvia','7600002801201','0332a2f00b8cd344818b1b734859c44c7d6b7604d347ce1619455d9bf2629d64.zip',array['gid', 'nom_bairro AS nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002801201_p2_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600002801_001/*bairros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-SP-Osasco','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600002801_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002801_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/aa41214cef0417fb400b83c2e196fb01d7be3688a560c36cac6e2c54cfa0502a.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/aa41214cef0417fb400b83c2e196fb01d7be3688a560c36cac6e2c54cfa0502a.zip && sudo chmod 664 /var/www/dl.digital-guard.org/aa41214cef0417fb400b83c2e196fb01d7be3688a560c36cac6e2c54cfa0502a.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002801101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600002801_001; 7z  x -y /var/www/dl.digital-guard.org/aa41214cef0417fb400b83c2e196fb01d7be3688a560c36cac6e2c54cfa0502a.zip "*Lotecadastral_numpredial_jun2018_sirgasUTM.gpkg*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
sudo docker run --rm --network host -v /tmp/sandbox:/tmp osgeo/gdal ogr2ogr -lco GEOMETRY_NAME=geom -overwrite -f "PostgreSQL" PG:" dbname='ingest1' host='localhost' port='5432' user='postgres' " "/tmp/Lotecadastral_numpredial_jun2018_sirgasUTM.gpkg"  -nln pk7600002801101_p1_parcel -a_srs EPSG:31983  

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('ogr2ogr','/tmp/sandbox/_pk7600002801_001/Lotecadastral_numpredial_jun2018_sirgasUTM.gpkg','parcel_full','pk7600002801101_p1_parcel','7600002801101','aa41214cef0417fb400b83c2e196fb01d7be3688a560c36cac6e2c54cfa0502a.zip',array['gid', 'num_atual AS hnum', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002801101_p1_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600002801_001/*Lotecadastral_numpredial_jun2018_sirgasUTM.gpkg.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-SP-Osasco','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600002801_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600002801_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/aa41214cef0417fb400b83c2e196fb01d7be3688a560c36cac6e2c54cfa0502a.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/aa41214cef0417fb400b83c2e196fb01d7be3688a560c36cac6e2c54cfa0502a.zip && sudo chmod 664 /var/www/dl.digital-guard.org/aa41214cef0417fb400b83c2e196fb01d7be3688a560c36cac6e2c54cfa0502a.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002801101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600002801_001; 7z  x -y /var/www/dl.digital-guard.org/aa41214cef0417fb400b83c2e196fb01d7be3688a560c36cac6e2c54cfa0502a.zip "*Eixo_Logradouros_sirgasUTM.gpkg*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
sudo docker run --rm --network host -v /tmp/sandbox:/tmp osgeo/gdal ogr2ogr -lco GEOMETRY_NAME=geom -overwrite -f "PostgreSQL" PG:" dbname='ingest1' host='localhost' port='5432' user='postgres' " "/tmp/Eixo_Logradouros_sirgasUTM.gpkg"  -nln pk7600002801101_p1_via -a_srs EPSG:31983  

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('ogr2ogr','/tmp/sandbox/_pk7600002801_001/Eixo_Logradouros_sirgasUTM.gpkg','via_full','pk7600002801101_p1_via','7600002801101','aa41214cef0417fb400b83c2e196fb01d7be3688a560c36cac6e2c54cfa0502a.zip',array['gid', 'nome AS via', 'cep_correi AS postcode', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600002801101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk7600002801_001/*Eixo_Logradouros_sirgasUTM.gpkg.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-SP-Osasco','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/Osasco/_pk0028.01/via -type f -exec chmod 664 {} \;




