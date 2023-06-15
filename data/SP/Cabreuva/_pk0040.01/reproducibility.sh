#!/bin/bash




# layer cadparcel:
rm -rf /tmp/sandbox/_pk7600004001_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600004001_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/28ad2bab16b023135e52a101d2e1ddf3337806de3922599a10598b9f2131e3d2.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/28ad2bab16b023135e52a101d2e1ddf3337806de3922599a10598b9f2131e3d2.zip && sudo chmod 664 /var/www/dl.digital-guard.org/28ad2bab16b023135e52a101d2e1ddf3337806de3922599a10598b9f2131e3d2.zip
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk7600004001101_p1_cadparcel CASCADE"
cd /tmp/sandbox/_pk7600004001_001; 7z  x -y /var/www/dl.digital-guard.org/28ad2bab16b023135e52a101d2e1ddf3337806de3922599a10598b9f2131e3d2.zip "*relação_*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
iconv -f ISO-8859-1 -t UTF-8 /tmp/sandbox/_pk7600004001_001/relação_.csv | dos2unix > /tmp/sandbox/_pk7600004001_001/relação_.unix_utf8.csv
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.fdw_generate_direct_csv( '/tmp/sandbox/_pk7600004001_001/relação_.unix_utf8.csv', 'pk7600004001101_p1_cadparcel',';' )"

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600004001101_p1_cadparcel AS SELECT row_number() OVER () AS gid, \"Logradouro\" AS via, CASE WHEN 'Nº Imóvel' like '%S/N%' THEN NULL ELSE 'Nº Imóvel' END  as hnum  FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('csv2sql','/tmp/sandbox/relação_.csv','cadparcel_cmpl','vw1_pk7600004001101_p1_cadparcel','7600004001101','28ad2bab16b023135e52a101d2e1ddf3337806de3922599a10598b9f2131e3d2.zip',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600004001101_p1_cadparcel"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.cadastral_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP FOREIGN TABLE IF EXISTS pk7600004001101_p1_cadparcel CASCADE"
rm -f /tmp/sandbox/_pk7600004001_001/*relação_.* || true










