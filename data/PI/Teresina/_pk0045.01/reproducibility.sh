#!/bin/bash







# layer geoaddress:
rm -rf /tmp/sandbox/_pk7600004501_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600004501_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/6d00a6246765ac93ce682e94282ecc0ed38cfdc1e7a6e936f53341414fd5269a.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/6d00a6246765ac93ce682e94282ecc0ed38cfdc1e7a6e936f53341414fd5269a.zip && sudo chmod 664 /var/www/dl.digital-guard.org/6d00a6246765ac93ce682e94282ecc0ed38cfdc1e7a6e936f53341414fd5269a.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600004501101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk7600004501_001; 7z  x -y /var/www/dl.digital-guard.org/6d00a6246765ac93ce682e94282ecc0ed38cfdc1e7a6e936f53341414fd5269a.zip "*Lotes_endereco*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600004501_001; shp2pgsql -D   -s 31983 "Lotes_endereco.shp" pk7600004501101_p1_geoaddress | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600004501101_p1_geoaddress AS SELECT gid, \"tipo de lo\" || ' ' || logradouro AS via, \"numero do\" AS hnum, geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/Lotes_endereco.shp','geoaddress_full','vw1_pk7600004501101_p1_geoaddress','7600004501101','6d00a6246765ac93ce682e94282ecc0ed38cfdc1e7a6e936f53341414fd5269a.zip',array[]::text[],1,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600004501101_p1_geoaddress"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600004501101_p1_geoaddress CASCADE"
rm -f /tmp/sandbox/_pk7600004501_001/*Lotes_endereco.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PI/Teresina/_pk0045.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PI/Teresina/_pk0045.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','BR-PI-Teresina','/var/gits/_dg/preservCutGeo-BR2021/data/PI/Teresina/_pk0045.01/geoaddress','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/PI/Teresina/_pk0045.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PI/Teresina/_pk0045.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/PI/Teresina/_pk0045.01/geoaddress -type f -exec chmod 664 {} \;







