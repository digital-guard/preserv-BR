<aside>
<table align="right" style="padding: 1em">
<tr><td>Pacote <a target="_git" title="link canônico para o git deste pacote" href="http://git.digital-guard.org/preserv-BR/blob/main/data/PI/Teresina/_pk0045.01"><big><b>pk0045.01</b></big></a> de <small><a target="_osmcodes" title="Jurisdição" href="https://osm.codes/BR-PI-Teresina">BR-PI-Teresina</a></small>
</td></tr>
<tr><td>
Doador: <a rel="external" target="_doador" href="https://pmt.pi.gov.br/">Prefeitura Municipal de Teresina</a><br/>
<small>cnpj:06.554.869/0001-64</small> • Wikidata <a rel="external" target="_doador" title="link descritor Wikidata do doador" href="https://www.wikidata.org/wiki/Q56449993">Q56449993</a></small><br/>

Obtido via <i>site;email</i> em <b>2020-09-23</b> por:<br/>
 Avaliação técnica: <a rel="external" target="_gitPerson" title="usuário Git" href="https://github.com/IgorEliezer">IgorEliezer</a><br/>
 Representação institucional: <a rel="external" target="_gitPerson" title="usuário Git" href="https://github.com/ThierryAJean">ThierryAJean</a><br/>
</td></tr>
<tr><td>Camadas: <a title="geoaddress" href="#-geoaddress"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-geoaddress.png" alt="geoaddress" width="20"/></a> </td></tr>
<tr><td><a href="http://git.digital-guard.org/preservCutGeo-BR2021/tree/main/data/PI/Teresina/_pk0045.01">Dados publicados</a></td></tr>
</table>
</aside>

<section>

Este repositório de metadados descreve um pacote de arquivos doado para o domínio público. Ele está sendo preservado pela Digital Guard: para maiores detalhes consulte a [documentação sobre o processo de registro e preservação](https://git.digital-guard.org/preserv/tree/main/docs).

Nota. O presente documento README foi gerado por software a partir das informações contidas no arquivo [`make_conf.yaml`](make_conf.yaml) deste pacote, e informações adicionais dos catálogos de [doadores](https://git.digital-guard.org/preserv-BR/blob/main/data/donor.csv) e de [pacotes](https://git.digital-guard.org/preserv-BR/blob/main/data/donatedPack.csv).

# Camadas de dados

Os arquivos contém "camadas de dados" temáticas. Os metadados também descrevem como cada camada foi avaliada e seus dados filtrados de forma padronizada.

## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-geoaddress.png" alt="geoaddress" width="20"/> geoaddress

Nome do arquivo: `Lotes_endereco`.<br/>*Download* e integridade: [6d00a6246765ac93ce682e94282ecc0ed38cfdc1e7a6e936f53341414fd5269a.zip](http://dl.digital-guard.org/6d00a6246765ac93ce682e94282ecc0ed38cfdc1e7a6e936f53341414fd5269a.zip)<br/>Descrição: Geo-endereços<br/>Formato: shp<br/>SRID: 31983

#### Dados relevantes
* `tipo de lo || ' ' || logradouro` (via)

* `numero do` (hnum)

#### Dados publicados
[http://git.digital-guard.org/preservCutGeo-BR2021/tree/main/data/PI/Teresina/_pk0045.01/geoaddress](http://git.digital-guard.org/preservCutGeo-BR2021/tree/main/data/PI/Teresina/_pk0045.01/geoaddress)<br/>11417502 bytes (10.89 <abbr title="mebibyte">MiB</abbr>)<br/>216334 pontos<br/>densidade média de 1577.61 pontos/km²

</section>
<section>

# Reprodutibilidade

```bash

geoaddress:
rm -rf /tmp/sandbox/_pk7600004501_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk7600004501_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/6d00a6246765ac93ce682e94282ecc0ed38cfdc1e7a6e936f53341414fd5269a.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/6d00a6246765ac93ce682e94282ecc0ed38cfdc1e7a6e936f53341414fd5269a.zip && sudo chmod 664 /var/www/dl.digital-guard.org/6d00a6246765ac93ce682e94282ecc0ed38cfdc1e7a6e936f53341414fd5269a.zip
psql $(pg_uri_db) -c "DROP  TABLE IF EXISTS pk7600004501101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk7600004501_001; 7z  x -y /var/www/dl.digital-guard.org/6d00a6246765ac93ce682e94282ecc0ed38cfdc1e7a6e936f53341414fd5269a.zip "*Lotes_endereco*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=31983"
cd /tmp/sandbox/_pk7600004501_001; shp2pgsql -D   -s 31983 "Lotes_endereco.shp" pk7600004501101_p1_geoaddress | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk7600004501101_p1_geoaddress AS SELECT gid, \"tipo de lo\" || ' ' || logradouro AS via, \"numero do\" AS hnum, geom FROM $(tabname)"
psql $(pg_uri_db) -c "SELECT ingest.any_load('shp2sql','$(sandbox)/Lotes_endereco.shp','geoaddress_full','vw1_pk7600004501101_p1_geoaddress','7600004501101','6d00a6246765ac93ce682e94282ecc0ed38cfdc1e7a6e936f53341414fd5269a.zip',array[]::text[],1,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk7600004501101_p1_geoaddress"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
rm -f "/tmp/sandbox/_pk7600004501_001/*Lotes_endereco.*" || true
psql $(pg_uri_db) -c "DROP TABLE IF EXISTS pk7600004501101_p1_geoaddress CASCADE"
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/PI/Teresina/_pk0045.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/PI/Teresina/_pk0045.01/geoaddress/*.geojson
psql $(pg_uri_db) -c "SELECT ingest.publicating_geojsons('geoaddress','BR-PI-Teresina','/var/gits/_dg/preservCutGeo-BR2021/data/PI/Teresina/_pk0045.01/geoaddress','1',9,3);"
cd /var/gits/_dg/preserv/src; sudo bash fixaPermissoes.sh /var/gits/_dg/preservCutGeo-BR2021/data/PI/Teresina/_pk0045.01/geoaddress

```
</section>

