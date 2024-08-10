#!/bin/bash



# layer building:
rm -rf /tmp/sandbox/_pk7600000601_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600000601_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/58d1d77cd2dd760f6a57bfda746da7f2658fe8a1f23f6d371ed5a8e230ac30cf.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/58d1d77cd2dd760f6a57bfda746da7f2658fe8a1f23f6d371ed5a8e230ac30cf.zip && sudo chmod 664 /var/www/dl.digital-guard.org/58d1d77cd2dd760f6a57bfda746da7f2658fe8a1f23f6d371ed5a8e230ac30cf.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000601201_p2_building CASCADE"
cd /tmp/sandbox/_pk7600000601_001; 7z  x -y /var/www/dl.digital-guard.org/58d1d77cd2dd760f6a57bfda746da7f2658fe8a1f23f6d371ed5a8e230ac30cf.zip "*edificacao*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31999"
cd /tmp/sandbox/_pk7600000601_001; shp2pgsql -D   -s 31999 "edificacao.shp" pk7600000601201_p2_building | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw2_pk7600000601201_p2_building AS SELECT gid, 'yes' AS building, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/edificacao.shp','building_full','vw2_pk7600000601201_p2_building','7600000601201','58d1d77cd2dd760f6a57bfda746da7f2658fe8a1f23f6d371ed5a8e230ac30cf.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw2_pk7600000601201_p2_building"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000601201_p2_building CASCADE"
rm -f /tmp/sandbox/_pk7600000601_001/*edificacao.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/building
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/building/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('building','BR-ES-Vitoria','/var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/building','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/building
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/building -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/building -type f -exec chmod 664 {} \;





# layer nsvia:
rm -rf /tmp/sandbox/_pk7600000601_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600000601_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/307f158ccd7d9ff8f7ec9767de719595fde4ea759c14316d478da176c23303fe.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/307f158ccd7d9ff8f7ec9767de719595fde4ea759c14316d478da176c23303fe.zip && sudo chmod 664 /var/www/dl.digital-guard.org/307f158ccd7d9ff8f7ec9767de719595fde4ea759c14316d478da176c23303fe.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000601101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk7600000601_001; 7z  x -y /var/www/dl.digital-guard.org/307f158ccd7d9ff8f7ec9767de719595fde4ea759c14316d478da176c23303fe.zip "*bairros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31999"
cd /tmp/sandbox/_pk7600000601_001; shp2pgsql -D   -s 31999 "bairros.shp" pk7600000601101_p1_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600000601_001/bairros.shp','nsvia_full','pk7600000601101_p1_nsvia','7600000601101','307f158ccd7d9ff8f7ec9767de719595fde4ea759c14316d478da176c23303fe.zip',array['gid', 'BAIRRO as nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000601101_p1_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600000601_001/*bairros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-ES-Vitoria','/var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600000601_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600000601_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/3a92899e5a7e87acb92cca7198cc0e894bac9ac96c2192b12b668d1e1d598898.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/3a92899e5a7e87acb92cca7198cc0e894bac9ac96c2192b12b668d1e1d598898.zip && sudo chmod 664 /var/www/dl.digital-guard.org/3a92899e5a7e87acb92cca7198cc0e894bac9ac96c2192b12b668d1e1d598898.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000601401_p4_parcel CASCADE"
cd /tmp/sandbox/_pk7600000601_001; 7z  x -y /var/www/dl.digital-guard.org/3a92899e5a7e87acb92cca7198cc0e894bac9ac96c2192b12b668d1e1d598898.zip "*lote*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31999"
cd /tmp/sandbox/_pk7600000601_001; shp2pgsql -D   -s 31999 "lote.shp" pk7600000601401_p4_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600000601_001/lote.shp','parcel_full','pk7600000601401_p4_parcel','7600000601401','3a92899e5a7e87acb92cca7198cc0e894bac9ac96c2192b12b668d1e1d598898.zip',array['gid', 'numero as hnum', 'logradouro as via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000601401_p4_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600000601_001/*lote.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-ES-Vitoria','/var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600000601_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600000601_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/252f2228f3400be3f6fdbef5a99b3aacf1ed0232ab73675ed918f9b5f8743752.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/252f2228f3400be3f6fdbef5a99b3aacf1ed0232ab73675ed918f9b5f8743752.zip && sudo chmod 664 /var/www/dl.digital-guard.org/252f2228f3400be3f6fdbef5a99b3aacf1ed0232ab73675ed918f9b5f8743752.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000601301_p3_via CASCADE"
cd /tmp/sandbox/_pk7600000601_001; 7z  x -y /var/www/dl.digital-guard.org/252f2228f3400be3f6fdbef5a99b3aacf1ed0232ab73675ed918f9b5f8743752.zip "*eixo_logradouro*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31999"
cd /tmp/sandbox/_pk7600000601_001; shp2pgsql -D   -s 31999 "eixo_logradouro.shp" pk7600000601301_p3_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600000601_001/eixo_logradouro.shp','via_full','pk7600000601301_p3_via','7600000601301','252f2228f3400be3f6fdbef5a99b3aacf1ed0232ab73675ed918f9b5f8743752.zip',array['gid', 'Nome as via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000601301_p3_via CASCADE"
rm -f /tmp/sandbox/_pk7600000601_001/*eixo_logradouro.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-ES-Vitoria','/var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/ES/Vitoria/_pk0006.01/via -type f -exec chmod 664 {} \;




