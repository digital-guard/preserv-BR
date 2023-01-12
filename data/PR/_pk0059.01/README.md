<aside>
<table align="right" style="padding: 1em">
<tr><td>Pacote <a target="_git" title="link canônico para o git deste pacote" href="http://git.digital-guard.org/preserv-BR/blob/main/data/PR/_pk0059.01"><big><b>pk0059.01</b></big></a> de <small><a target="_osmcodes" title="Jurisdição" href="https://osm.codes/BR-PR">BR-PR</a></small>
</td></tr>
<tr><td>
Doador: <a rel="external" target="_doador" href="http://www.paranacidade.org.br/">Serviço Social Autônomo Paranacidade</a><br/>
<small>cnpj:01.450.804/0001-55</small> • Wikidata <a rel="external" target="_doador" title="link descritor Wikidata do doador" href="https://www.wikidata.org/wiki/Q104848282">Q104848282</a></small><br/>

Obtido via <i>email</i> em <b>2020-12-08</b> por:<br/>
 Avaliação técnica: <a rel="external" target="_gitPerson" title="usuário Git" href="https://github.com/IgorEliezer">IgorEliezer</a><br/>
 Representação institucional: <a rel="external" target="_gitPerson" title="usuário Git" href="https://github.com/ThierryAJean">ThierryAJean</a><br/>
</td></tr>
<tr><td>Camadas: <a title="parcel" href="#-parcel"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-parcel.png" alt="parcel" width="20"/></a> </td></tr>
<tr><td><a href="http://git.digital-guard.org/preservCutGeo-BR2021/tree/main/data/PR/_pk0059.01">Dados publicados</a></td></tr>
</table>
</aside>

<section>

Este repositório de metadados descreve um pacote de arquivos doado para o domínio público. Ele está sendo preservado pela Digital Guard: para maiores detalhes consulte a [documentação sobre o processo de registro e preservação](https://git.digital-guard.org/preserv/tree/main/docs).

Nota. O presente documento README foi gerado por software a partir das informações contidas no arquivo [`make_conf.yaml`](make_conf.yaml) deste pacote, e informações adicionais dos catálogos de [doadores](https://git.digital-guard.org/preserv-BR/blob/main/data/donor.csv) e de [pacotes](https://git.digital-guard.org/preserv-BR/blob/main/data/donatedPack.csv).

# Camadas de dados

Os arquivos contém "camadas de dados" temáticas. Os metadados também descrevem como cada camada foi avaliada e seus dados filtrados de forma padronizada.

## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-parcel.png" alt="parcel" width="20"/> parcel

Nome do arquivo: `New File Geodatabase (2).gdb`.<br/>*Download* e integridade: [47dca17c620c1c34ac091dac19afb8851f1d8f9a907094a0f40a0310e774445d.zip](http://dl.digital-guard.org/47dca17c620c1c34ac091dac19afb8851f1d8f9a907094a0f40a0310e774445d.zip)<br/>Descrição: Lotes<br/>Tamanho do arquivo: 193516287 bytes (184.55 <abbr title="mebibyte">MiB</abbr>)<br/>Formato: gdb<br/>SRID: 31982

#### Dados relevantes
* `nrpredial` (house_number)

#### Outros dados relevantes
* `NmMunicipio`: Nome do município

#### Dados publicados
[http://git.digital-guard.org/preservCutGeo-BR2021/tree/main/data/PR/_pk0059.01/parcel](http://git.digital-guard.org/preservCutGeo-BR2021/tree/main/data/PR/_pk0059.01/parcel)<br/>470094182 bytes (448.32 <abbr title="mebibyte">MiB</abbr>)<br/>2546286 polígonos com 2589.18 <abbr title="quilômetros quadrados">km²</abbr><br/>densidade média: 0.39 polígonos/km²

</section>
<section>

# Reprodutibilidade

```bash

parcel:
rm -rf /tmp/sandbox/_pk7600005901_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600005901_001
mkdir -p /tmp/pg_io
wget -P /var/www/preserv.addressforall.org/download http://dl.digital-guard.org/47dca17c620c1c34ac091dac19afb8851f1d8f9a907094a0f40a0310e774445d.zip
sudo chown postgres:www-data /var/www/preserv.addressforall.org/download/47dca17c620c1c34ac091dac19afb8851f1d8f9a907094a0f40a0310e774445d.zip && sudo chmod 664 /var/www/preserv.addressforall.org/download/47dca17c620c1c34ac091dac19afb8851f1d8f9a907094a0f40a0310e774445d.zip
psql $(pg_uri_db) -c "DROP  TABLE IF EXISTS pk7600005901101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk7600005901_001; 7z  x -y /var/www/preserv.addressforall.org/download/47dca17c620c1c34ac091dac19afb8851f1d8f9a907094a0f40a0310e774445d.zip "*New File Geodatabase (2).gdb*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31982"
sudo docker run --rm --network host -v /tmp/sandbox/_pk7600005901_001:/tmp osgeo/gdal ogr2ogr -lco GEOMETRY_NAME=geom -overwrite -f "PostgreSQL" PG:" dbname='ingest1' host='localhost' port='5432' user='postgres' " "/tmp/New File Geodatabase (2).gdb" LOTES_PR -nln pk7600005901101_p1_parcel 
dd if=/dev/random of='$(sandbox)/New File Geodatabase (2).gdb/random_data_file' bs=1M count=1
psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600005901101_p1_parcel AS SELECT objectid AS gid, nrpredial AS house_number, NmMunicipio, geom FROM $(tabname)"
psql $(pg_uri_db) -c "CALL ingest.any_load_loop('gdb2sql','$(sandbox)/New File Geodatabase (2).gdb/random_data_file','parcel_none','vw1_pk7600005901101_p1_parcel','7600005901101','47dca17c620c1c34ac091dac19afb8851f1d8f9a907094a0f40a0310e774445d.zip',array[]::text[],5,1,false,'geom',true,'NmMunicipio')"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600005901101_p1_parcel"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
rm -f "/tmp/sandbox/_pk7600005901_001/*New File Geodatabase (2).gdb.*" || true
psql $(pg_uri_db) -c "DROP TABLE IF EXISTS pk7600005901101_p1_parcel CASCADE"
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PR/_pk0059.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PR/_pk0059.01/parcel/*.geojson
psql $(pg_uri_db) -c "SELECT ingest.publicating_geojsons('parcel','BR-PR','/var/gits/_dg/preservCutGeo-BR2021/data/PR/_pk0059.01/parcel','1',9,3);"
cd /var/gits/_dg/preserv/src; sudo bash fixaPermissoes.sh /var/gits/_dg/preservCutGeo-BR2021/data/PR/_pk0059.01/parcel

```
</section>

