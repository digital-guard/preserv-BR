<aside>
<table align="right">
<tr><th>BR-SP-Atibaia</th></tr>
<tr><td>
Pacote: <a target="_git" href="http://git.digital-guard.org/preserv-BR/blob/main/data/SP/Atibaia/_pk0021.01"><small>_pk0021.01</small></a>
</td></tr>
<tr><td>
Doador: <a rel="external" target="_doador" href="http://www.prefeituradeatibaia.com.br/">Prefeitura da Estância de Atibaia</a><br/>
<small>cnpj:45.279.635/0001-08</small> • <a rel="external" target="_doador" href="https://www.wikidata.org/wiki/Q97936697">Q97936697</a></small><br/>
Obtido via <i>email</i> em <b>2020-09-10</b><br/>
Avaliação técnica: igor<br/>
Representação institucional: Thierry<br/>
Licença <a rel="external" target="_doador" href="https://creativecommons.org/publicdomain/zero/1.0/"><b>CC0-1.0</b></a> (cc0 <a title="SHA256 7adf2a2ec5348c05db9a52eedccdfb065352d363ff617d6167cf6202e30ee4af.eml" href="http://dl.digital-guard.org/7adf2a2ec5348c05db9a52eedccdfb065352d363ff617d6167cf6202e30ee4af.eml"><code>7adf2a2...eml</code></a>)
</td></tr>
<tr><td>Camadas: <a title="via" href="#-via"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-via.png" alt="via" width="20"/></a> <a title="parcel" href="#-parcel"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-parcel.png" alt="parcel" width="20"/></a> <a title="building" href="#-building"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-building.png" alt="building" width="20"/></a> </td></tr>
<tr><td><a href="http://git.digital-guard.org/preservCutGeo-BR2021/tree/main/data/SP/Atibaia/_pk0021.01">Dados publicados</a></td></tr>
</table>
</aside>

<section>

# Camadas de dados
## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-building.png" alt="building" width="20"/> building

Nome do arquivo: `edificacoes/edificacoes`.<br/>Download: [6d741572b6c31ffd82cf004b92fa98056545df805bcb64afba5e7b26e32b62ab.zip](http://dl.digital-guard.org/6d741572b6c31ffd82cf004b92fa98056545df805bcb64afba5e7b26e32b62ab.zip)<br/>Descrição: Edificações<br/>Tamanho do arquivo: 11032539 bytes (10.52 <abbr title="mebibyte">MiB</abbr>)<br/>Formato: shp<br/>SRID: 3857

#### Dados relevantes
* `numero` (house_number)









## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-parcel.png" alt="parcel" width="20"/> parcel

Nome do arquivo: `lotes/lotes`.<br/>Download: [b6221fa57754ec8c4db284591a6ceeea7acf986eb215b2e521647e32fb175488.zip](http://dl.digital-guard.org/b6221fa57754ec8c4db284591a6ceeea7acf986eb215b2e521647e32fb175488.zip)<br/>Descrição: Lotes<br/>Tamanho do arquivo: 889309 bytes (0.85 <abbr title="mebibyte">MiB</abbr>)<br/>Formato: shp<br/>SRID: 29193

#### Dados relevantes
* `num` (house_number)









## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-via.png" alt="via" width="20"/> via

Nome do arquivo: `logradouros/CAD_LOG`.<br/>Download: [0a7fedd6e8e30541f706fa7f77166a183a3cc43d2b1d3d3d0a8d3fb7f077e804.zip](http://dl.digital-guard.org/0a7fedd6e8e30541f706fa7f77166a183a3cc43d2b1d3d3d0a8d3fb7f077e804.zip)<br/>Descrição: Logradouros<br/>Tamanho do arquivo: 1241211 bytes (1.18 <abbr title="mebibyte">MiB</abbr>)<br/>Formato: shp<br/>SRID: 29193

#### Dados relevantes
* `log_nome_c` (via_name)











# Evidências de teste
<img src="qgis.png" width="400"/>

# Comentários gerais
Parcel e building incompletos. Sem nome de logradouro, alguns número de porta nulos (&quot;0&quot;) e cobertura parcial de lotes (veja evidências).

</section>
<section>

# Reprodutibilidade

```bash


building:
rm -rf /tmp/sandbox/_pkBR211_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pkBR211_001
mkdir -p /tmp/pg_io
wget -P /var/www/preserv.addressforall.org/download http://dl.digital-guard.org/6d741572b6c31ffd82cf004b92fa98056545df805bcb64afba5e7b26e32b62ab.zip
sudo chown postgres:www-data /var/www/preserv.addressforall.org/download/6d741572b6c31ffd82cf004b92fa98056545df805bcb64afba5e7b26e32b62ab.zip && sudo chmod 664 /var/www/preserv.addressforall.org/download/6d741572b6c31ffd82cf004b92fa98056545df805bcb64afba5e7b26e32b62ab.zip
psql $(pg_uri_db) -c "DROP  TABLE IF EXISTS pk7600002101301_p3_building CASCADE"
cd /tmp/sandbox/_pkBR211_001; 7z  x -y /var/www/preserv.addressforall.org/download/6d741572b6c31ffd82cf004b92fa98056545df805bcb64afba5e7b26e32b62ab.zip "*edificacoes/edificacoes*" ; chmod -R a+rwx . > /dev/null
 está configurado:" --}}
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=3857"
cd /tmp/sandbox/_pkBR211_001; shp2pgsql -D   -s 3857 "edificacoes/edificacoes.shp" pk7600002101301_p3_building | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pkBR211_001/edificacoes/edificacoes.shp','building_full','pk7600002101301_p3_building','7600002101301','6d741572b6c31ffd82cf004b92fa98056545df805bcb64afba5e7b26e32b62ab.zip',array['gid', 'numero as house_number', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
rm -f "/tmp/sandbox/_pkBR211_001/*edificacoes/edificacoes.*" || true
psql $(pg_uri_db) -c "DROP TABLE IF EXISTS pk7600002101301_p3_building CASCADE"
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/building
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/building/*.geojson
psql $(pg_uri_db) -c "SELECT ingest.publicating_geojsons('building','BR-SP-Atibaia','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/building','1',9,3);"
cd /var/gits/_dg/preserv/src; sudo bash fixaPermissoes.sh /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/building






parcel:
rm -rf /tmp/sandbox/_pkBR211_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pkBR211_001
mkdir -p /tmp/pg_io
wget -P /var/www/preserv.addressforall.org/download http://dl.digital-guard.org/b6221fa57754ec8c4db284591a6ceeea7acf986eb215b2e521647e32fb175488.zip
sudo chown postgres:www-data /var/www/preserv.addressforall.org/download/b6221fa57754ec8c4db284591a6ceeea7acf986eb215b2e521647e32fb175488.zip && sudo chmod 664 /var/www/preserv.addressforall.org/download/b6221fa57754ec8c4db284591a6ceeea7acf986eb215b2e521647e32fb175488.zip
psql $(pg_uri_db) -c "DROP  TABLE IF EXISTS pk7600002101201_p2_parcel CASCADE"
cd /tmp/sandbox/_pkBR211_001; 7z  x -y /var/www/preserv.addressforall.org/download/b6221fa57754ec8c4db284591a6ceeea7acf986eb215b2e521647e32fb175488.zip "*lotes/lotes*" ; chmod -R a+rwx . > /dev/null
 está configurado:" --}}
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=29193"
cd /tmp/sandbox/_pkBR211_001; shp2pgsql -D   -s 29193 "lotes/lotes.shp" pk7600002101201_p2_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pkBR211_001/lotes/lotes.shp','parcel_none','pk7600002101201_p2_parcel','7600002101201','b6221fa57754ec8c4db284591a6ceeea7acf986eb215b2e521647e32fb175488.zip',array['gid', 'num as house_number', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".

rm -f "/tmp/sandbox/_pkBR211_001/*lotes/lotes.*" || true
psql $(pg_uri_db) -c "DROP TABLE IF EXISTS pk7600002101201_p2_parcel CASCADE"
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/parcel/*.geojson
psql $(pg_uri_db) -c "SELECT ingest.publicating_geojsons('parcel','BR-SP-Atibaia','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/parcel','1',9,3);"
cd /var/gits/_dg/preserv/src; sudo bash fixaPermissoes.sh /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/parcel

via:
rm -rf /tmp/sandbox/_pkBR211_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pkBR211_001
mkdir -p /tmp/pg_io
wget -P /var/www/preserv.addressforall.org/download http://dl.digital-guard.org/0a7fedd6e8e30541f706fa7f77166a183a3cc43d2b1d3d3d0a8d3fb7f077e804.zip
sudo chown postgres:www-data /var/www/preserv.addressforall.org/download/0a7fedd6e8e30541f706fa7f77166a183a3cc43d2b1d3d3d0a8d3fb7f077e804.zip && sudo chmod 664 /var/www/preserv.addressforall.org/download/0a7fedd6e8e30541f706fa7f77166a183a3cc43d2b1d3d3d0a8d3fb7f077e804.zip
psql $(pg_uri_db) -c "DROP  TABLE IF EXISTS pk7600002101101_p1_via CASCADE"
cd /tmp/sandbox/_pkBR211_001; 7z  x -y /var/www/preserv.addressforall.org/download/0a7fedd6e8e30541f706fa7f77166a183a3cc43d2b1d3d3d0a8d3fb7f077e804.zip "*logradouros/CAD_LOG*" ; chmod -R a+rwx . > /dev/null
 está configurado:" --}}
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=29193"
cd /tmp/sandbox/_pkBR211_001; shp2pgsql -D   -s 29193 "logradouros/CAD_LOG.shp" pk7600002101101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pkBR211_001/logradouros/CAD_LOG.shp','via_full','pk7600002101101_p1_via','7600002101101','0a7fedd6e8e30541f706fa7f77166a183a3cc43d2b1d3d3d0a8d3fb7f077e804.zip',array['gid', 'log_nome_c as via_name', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".

rm -f "/tmp/sandbox/_pkBR211_001/*logradouros/CAD_LOG.*" || true
psql $(pg_uri_db) -c "DROP TABLE IF EXISTS pk7600002101101_p1_via CASCADE"
mkdir -m777 -p /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/via
rm -rf /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/via/*.geojson
psql $(pg_uri_db) -c "SELECT ingest.publicating_geojsons('via','BR-SP-Atibaia','/var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/via','1',9,3);"
cd /var/gits/_dg/preserv/src; sudo bash fixaPermissoes.sh /var/gits/_dg/preservCutGeo-BR2021/data/SP/Atibaia/_pk0021.01/via



```
</section>


