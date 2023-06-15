#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk7600007201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/31081d4d9daf71ca3e0b11d06b228fd62d8eb326c889cc41af699d1d57f4c23e.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/31081d4d9daf71ca3e0b11d06b228fd62d8eb326c889cc41af699d1d57f4c23e.zip && sudo chmod 664 /var/www/dl.digital-guard.org/31081d4d9daf71ca3e0b11d06b228fd62d8eb326c889cc41af699d1d57f4c23e.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007201401_p4_block CASCADE"
cd /tmp/sandbox/_pk7600007201_001; 7z  x -y /var/www/dl.digital-guard.org/31081d4d9daf71ca3e0b11d06b228fd62d8eb326c889cc41af699d1d57f4c23e.zip "*quadras_gerais*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31985"
cd /tmp/sandbox/_pk7600007201_001; shp2pgsql -D   -s 31985 "quadras_gerais.shp" pk7600007201401_p4_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600007201_001/quadras_gerais.shp','block_full','pk7600007201401_p4_block','7600007201401','31081d4d9daf71ca3e0b11d06b228fd62d8eb326c889cc41af699d1d57f4c23e.zip',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007201401_p4_block CASCADE"
rm -f /tmp/sandbox/_pk7600007201_001/*quadras_gerais.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/block
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','BR-PB-JoaoPessoa','/var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/block
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/block -type f -exec chmod 664 {} \;






# layer nsvia:
rm -rf /tmp/sandbox/_pk7600007201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/07c8aa95c98efecaa6e0a1e4667f4c2452f519477011cba4355f294c07d465c1.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/07c8aa95c98efecaa6e0a1e4667f4c2452f519477011cba4355f294c07d465c1.zip && sudo chmod 664 /var/www/dl.digital-guard.org/07c8aa95c98efecaa6e0a1e4667f4c2452f519477011cba4355f294c07d465c1.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007201101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk7600007201_001; 7z  x -y /var/www/dl.digital-guard.org/07c8aa95c98efecaa6e0a1e4667f4c2452f519477011cba4355f294c07d465c1.zip "*Bairros*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31985"
cd /tmp/sandbox/_pk7600007201_001; shp2pgsql -D   -s 31985 "Bairros.shp" pk7600007201101_p1_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600007201_001/Bairros.shp','nsvia_full','pk7600007201101_p1_nsvia','7600007201101','07c8aa95c98efecaa6e0a1e4667f4c2452f519477011cba4355f294c07d465c1.zip',array['gid', 'N_BAIRRO as nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007201101_p1_nsvia CASCADE"
rm -f /tmp/sandbox/_pk7600007201_001/*Bairros.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','BR-PB-JoaoPessoa','/var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk7600007201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/ccb4e51a2caca195e8fd260de69d07ffc2d0cbbb80e4455806d7c89f2932948c.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/ccb4e51a2caca195e8fd260de69d07ffc2d0cbbb80e4455806d7c89f2932948c.zip && sudo chmod 664 /var/www/dl.digital-guard.org/ccb4e51a2caca195e8fd260de69d07ffc2d0cbbb80e4455806d7c89f2932948c.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007201301_p3_parcel CASCADE"
cd /tmp/sandbox/_pk7600007201_001; 7z  x -y /var/www/dl.digital-guard.org/ccb4e51a2caca195e8fd260de69d07ffc2d0cbbb80e4455806d7c89f2932948c.zip "*Lotes*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31985"
cd /tmp/sandbox/_pk7600007201_001; shp2pgsql -D   -s 31985 "Lotes.shp" pk7600007201301_p3_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600007201_001/Lotes.shp','parcel_none','pk7600007201301_p3_parcel','7600007201301','ccb4e51a2caca195e8fd260de69d07ffc2d0cbbb80e4455806d7c89f2932948c.zip',array['gid', 'Nume_Imov as hnum', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007201301_p3_parcel CASCADE"
rm -f /tmp/sandbox/_pk7600007201_001/*Lotes.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','BR-PB-JoaoPessoa','/var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/parcel
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk7600007201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600007201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/393dc287ca1b626ecb180b40d6c9ec2ebc74a3364444a4418d77e7225c32f3f7.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/393dc287ca1b626ecb180b40d6c9ec2ebc74a3364444a4418d77e7225c32f3f7.zip && sudo chmod 664 /var/www/dl.digital-guard.org/393dc287ca1b626ecb180b40d6c9ec2ebc74a3364444a4418d77e7225c32f3f7.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007201201_p2_via CASCADE"
cd /tmp/sandbox/_pk7600007201_001; 7z  x -y /var/www/dl.digital-guard.org/393dc287ca1b626ecb180b40d6c9ec2ebc74a3364444a4418d77e7225c32f3f7.zip "*Logradouro_gerais*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31985"
cd /tmp/sandbox/_pk7600007201_001; shp2pgsql -D   -s 31985 "Logradouro_gerais.shp" pk7600007201201_p2_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk7600007201_001/Logradouro_gerais.shp','via_full','pk7600007201201_p2_via','7600007201201','393dc287ca1b626ecb180b40d6c9ec2ebc74a3364444a4418d77e7225c32f3f7.zip',array['gid', 'NOME_LOGR as via', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600007201201_p2_via CASCADE"
rm -f /tmp/sandbox/_pk7600007201_001/*Logradouro_gerais.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR-PB-JoaoPessoa','/var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PB/JoaoPessoa/_pk0072.01/via -type f -exec chmod 664 {} \;




