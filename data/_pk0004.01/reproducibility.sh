#!/bin/bash







# layer geoaddress:
rm -rf /tmp/sandbox/_pk7600000401_003 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600000401_003
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/befb1a28910b56920b7c10b7ae1a25d5d32f1b13931463076adebc4ab33db114.pbf
sudo chown postgres:www-data /var/www/dl.digital-guard.org/befb1a28910b56920b7c10b7ae1a25d5d32f1b13931463076adebc4ab33db114.pbf && sudo chmod 664 /var/www/dl.digital-guard.org/befb1a28910b56920b7c10b7ae1a25d5d32f1b13931463076adebc4ab33db114.pbf
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000401101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk7600000401_003; cp /var/www/dl.digital-guard.org/befb1a28910b56920b7c10b7ae1a25d5d32f1b13931463076adebc4ab33db114.pbf "brazil-latest.osm.pbf" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600000401101_p1_geoaddress AS SELECT way, tags - ARRAY['addr:housenumber','addr:street'] || jsonb_objslice(ARRAY['addr:housenumber','addr:street'], tags, ARRAY['hnum','via']) AS tags FROM jplanet_osm_point WHERE tags ?| ARRAY['addr:housenumber','addr:street'] AND country_id = 76::smallint UNION ALL SELECT ST_PointOnSurface(way) AS way, tags - ARRAY['addr:housenumber','addr:street'] || jsonb_objslice(ARRAY['addr:housenumber','addr:street'], tags, ARRAY['hnum','via']) AS tags FROM jplanet_osm_polygon WHERE tags ?| ARRAY['addr:housenumber','addr:street'] AND tags ?& ARRAY['building'] AND country_id = 76::smallint "
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.osm_load('/tmp/sandbox/_pk7600000401_003/brazil-latest.osm.pbf','geoaddress_full','vw1_pk7600000401101_p1_geoaddress','7600000401101','befb1a28910b56920b7c10b7ae1a25d5d32f1b13931463076adebc4ab33db114.pbf',array[]::text[],1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600000401101_p1_geoaddress"
rm -f /tmp/sandbox/_pk7600000401_003/*brazil-latest.osm.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/_pk0004.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/_pk0004.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','BR','/var/gits/_dg/preservCutGeo-BR2021/data/_pk0004.01/geoaddress','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/_pk0004.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/_pk0004.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/_pk0004.01/geoaddress -type f -exec chmod 664 {} \;



# layer via:
rm -rf /tmp/sandbox/_pk7600000401_003 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600000401_003
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/befb1a28910b56920b7c10b7ae1a25d5d32f1b13931463076adebc4ab33db114.pbf
sudo chown postgres:www-data /var/www/dl.digital-guard.org/befb1a28910b56920b7c10b7ae1a25d5d32f1b13931463076adebc4ab33db114.pbf && sudo chmod 664 /var/www/dl.digital-guard.org/befb1a28910b56920b7c10b7ae1a25d5d32f1b13931463076adebc4ab33db114.pbf
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk7600000401101_p1_via CASCADE"
cd /tmp/sandbox/_pk7600000401_003; cp /var/www/dl.digital-guard.org/befb1a28910b56920b7c10b7ae1a25d5d32f1b13931463076adebc4ab33db114.pbf "brazil-latest.osm.pbf" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600000401101_p1_via AS SELECT way, tags - ARRAY['name'] || jsonb_objslice(ARRAY['name'], tags, ARRAY['via']) AS tags FROM jplanet_osm_line WHERE tags->>'highway' IN ('residential','unclassified','tertiary','secondary','primary','trunk','motorway') AND country_id = 76::smallint "
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.osm_load('/tmp/sandbox/_pk7600000401_003/brazil-latest.osm.pbf','via_full','vw1_pk7600000401101_p1_via','7600000401101','befb1a28910b56920b7c10b7ae1a25d5d32f1b13931463076adebc4ab33db114.pbf',array[]::text[],5)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600000401101_p1_via"
rm -f /tmp/sandbox/_pk7600000401_003/*brazil-latest.osm.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/_pk0004.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/_pk0004.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','BR','/var/gits/_dg/preservCutGeo-BR2021/data/_pk0004.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-BR2021/data/_pk0004.01/via
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/_pk0004.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-BR2021/data/_pk0004.01/via -type f -exec chmod 664 {} \;


# layer openstreetmap:
rm -rf /tmp/sandbox/_pk7600000401_003 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600000401_003
mkdir -p /tmp/pg_io
cp -s  /var/www/dl.digital-guard.org/ /tmp/sandbox/_pk4.1_003
osm2pgsql -E 4326 -c -d ingest1 -U postgres -H localhost --slim --hstore --extra-attributes --hstore-add-index --multi-geometry --number-processes 4 --style /usr/share/osm2pgsql/empty.style /tmp/sandbox/_pk4.1_003/
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.jplanet_inserts_and_drops(76::smallint,true);"
rm -f /tmp/sandbox/_pk7600000401_003/*.* || true


