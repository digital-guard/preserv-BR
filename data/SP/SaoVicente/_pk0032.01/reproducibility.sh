#!/bin/bash







# layer geoaddress:
rm -rf /tmp/sandbox/_pk7600003201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600003201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/3d5bc83bbbfd7e28857d36e6cf9df06bcd1d9de257018d684a3dd91608c55742.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/3d5bc83bbbfd7e28857d36e6cf9df06bcd1d9de257018d684a3dd91608c55742.zip && sudo chmod 664 /var/www/dl.digital-guard.org/3d5bc83bbbfd7e28857d36e6cf9df06bcd1d9de257018d684a3dd91608c55742.zip
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk7600003201101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk7600003201_001; 7z  x -y /var/www/dl.digital-guard.org/3d5bc83bbbfd7e28857d36e6cf9df06bcd1d9de257018d684a3dd91608c55742.zip "*SaoVicente-Oficial*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=29193"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.fdw_generate_direct_csv( '/tmp/sandbox/_pk7600003201_001/SaoVicente-Oficial.csv', 'pk7600003201101_p1_geoaddress' )"

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600003201101_p1_geoaddress AS SELECT row_number() OVER () as gid, \"HouseNumber\" AS hnum, \
     ST_GeomFromText(\"SRID_29193\",$(srid)) as geom \
FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('csv2sql','/tmp/sandbox/SaoVicente-Oficial.csv','geoaddress_full','vw1_pk7600003201101_p1_geoaddress','7600003201101','3d5bc83bbbfd7e28857d36e6cf9df06bcd1d9de257018d684a3dd91608c55742.zip',array[]::text[],1,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600003201101_p1_geoaddress"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk7600003201101_p1_geoaddress CASCADE"
rm -f /tmp/sandbox/_pk7600003201_001/*SaoVicente-Oficial.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoVicente/_pk0032.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoVicente/_pk0032.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','BR-SP-SaoVicente','/var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoVicente/_pk0032.01/geoaddress','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoVicente/_pk0032.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoVicente/_pk0032.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/SP/SaoVicente/_pk0032.01/geoaddress -type f -exec chmod 664 {} \;







