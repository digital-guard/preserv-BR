<aside>
<table align="right" style="padding: 1em">
<tr><td>Pacote <a target="_git" title="link canônico para o git deste pacote" href="http://git.digital-guard.org/preserv-BR/blob/main/data/BA/Salvador/_pk0050.01"><big><b>pk0050.01</b></big></a> de <small><a target="_osmcodes" title="Jurisdição" href="https://osm.codes/BR-BA-Salvador">BR-BA-Salvador</a></small>
</td></tr>
<tr><td>
Doador: <a rel="external" target="_doador" href="http://www.salvador.ba.gov.br/">Prefeitura Municipal de Salvador</a><br/>
<small>cnpj:13.927.801/0001-49</small> • Wikidata <a rel="external" target="_doador" title="link descritor Wikidata do doador" href="https://www.wikidata.org/wiki/Q53930901">Q53930901</a></small><br/>

Obtido via <i>site</i> em <b>2022-11-16</b> por:<br/>
 Avaliação técnica: <a rel="external" target="_gitPerson" title="usuário Git" href="https://github.com/luisfelipebr">luisfelipebr</a><br/>
 Representação institucional: <a rel="external" target="_gitPerson" title="usuário Git" href="https://github.com/ThierryAJean">ThierryAJean</a><br/>
</td></tr>
<tr><td>Camadas: <a title="via" href="#-via"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-via.png" alt="via" width="20"/></a> <a title="nsvia" href="#-nsvia"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-nsvia.png" alt="nsvia" width="20"/></a> <a title="parcel" href="#-parcel"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-parcel.png" alt="parcel" width="20"/></a> </td></tr>
<tr><td><a href="http://git.digital-guard.org/preservCutGeo-BR2021/tree/main/data/BA/Salvador/_pk0050.01">Dados publicados</a></td></tr>
</table>
</aside>

<section>

Este repositório de metadados descreve um pacote de arquivos doado para o domínio público. Ele está sendo preservado pela Digital Guard: para maiores detalhes consulte a [documentação sobre o processo de registro e preservação](https://git.digital-guard.org/preserv/tree/main/docs).

Nota. O presente documento README foi gerado por software a partir das informações contidas no arquivo [`make_conf.yaml`](make_conf.yaml) deste pacote, e informações adicionais dos catálogos de [doadores](https://git.digital-guard.org/preserv-BR/blob/main/data/donor.csv) e de [pacotes](https://git.digital-guard.org/preserv-BR/blob/main/data/donatedPack.csv).

# Camadas de dados

Os arquivos contêm "camadas de dados" temáticas. Os metadados também descrevem como cada camada foi avaliada e seus dados filtrados de forma padronizada.

## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-parcel.png" alt="parcel" width="20"/> parcel

Nome do arquivo: `edf_edificacao_a.dxf`.<br/>*Download* e integridade: [e8326aac43117a60b0f6294ecc579e7c2bdaee704206a86d03edcff9a5f9db04.zip](http://dl.digital-guard.org/e8326aac43117a60b0f6294ecc579e7c2bdaee704206a86d03edcff9a5f9db04.zip)<br/>Descrição: Edificacao_sem_acentos.zip<br/>Formato: <br/>SRID: 31984

#### Comentários
foi necessário usar a função ST_MakePolygon(geom) sobre a geometia do dado para criar polignos uteis

## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-nsvia.png" alt="nsvia" width="20"/> nsvia

Nome do arquivo: `Prefeituras_Bairro`.<br/>*Download* e integridade: [2dd6c00405143aa6378b38a80eb5a7f4d7ce201d31e99c60b4a5bf4ad5bf98de.zip](http://dl.digital-guard.org/2dd6c00405143aa6378b38a80eb5a7f4d7ce201d31e99c60b4a5bf4ad5bf98de.zip)<br/>Descrição: PrefeituraBairro.zip<br/>Formato: shp<br/>SRID: 31984

#### Dados relevantes
* `subclasses` (nsvia)

## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-via.png" alt="via" width="20"/> via

Nome do arquivo: `Trecho_de_Arruamento_2021-08-20`.<br/>*Download* e integridade: [58c2353cf924694da728d1107e71e9deb67d39c1f9ffd65a2eaffed32b4d253a.zip](http://dl.digital-guard.org/58c2353cf924694da728d1107e71e9deb67d39c1f9ffd65a2eaffed32b4d253a.zip)<br/>Descrição: Trecho_de_Arruamento_2021-08-20.zip<br/>Formato: shp<br/>SRID: 31984

#### Comentários
foi necessário usar a função ST_Boundary(geom) sobre a geometia do dado para criar linhas, uteis para o mapa

</section>
<section>

# Reprodutibilidade

Ver detalhes em [reproducibility.sh](reproducibility.sh).

</section>

