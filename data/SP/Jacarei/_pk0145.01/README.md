<aside>
<table align="right" style="padding: 1em">
<tr><td>Pacote <a target="_git" title="link canônico para o git deste pacote" href="http://git.digital-guard.org/preserv-BR/blob/main/data/SP/Jacarei/_pk0145.01"><big><b>pk0145.01</b></big></a> de <small><a target="_osmcodes" title="Jurisdição" href="https://osm.codes/BR-SP-Jacarei">BR-SP-Jacarei</a></small>
</td></tr>
<tr><td>
Doador: <a rel="external" target="_doador" href="https://www.jacarei.sp.gov.br/">Município de Jacareí</a><br/>
<small>cnpj:46.694.139/0001-83</small> • Wikidata <a rel="external" target="_doador" title="link descritor Wikidata do doador" href="https://www.wikidata.org/wiki/Q655363">Q655363</a></small><br/>

Obtido via <i>email</i> em <b>2022-12-15</b> por:<br/>
 Avaliação técnica: <a rel="external" target="_gitPerson" title="usuário Git" href="https://github.com/luisfelipebr">luisfelipebr</a><br/>
 Representação institucional: <a rel="external" target="_gitPerson" title="usuário Git" href="https://github.com/ThierryAJean">ThierryAJean</a><br/>
</td></tr>
<tr><td>Camadas: <a title="via" href="#-via"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-via.png" alt="via" width="20"/></a> <a title="nsvia" href="#-nsvia"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-nsvia.png" alt="nsvia" width="20"/></a> <a title="parcel" href="#-parcel"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-parcel.png" alt="parcel" width="20"/></a> <a title="cadparcel" href="#-cadparcel"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-cadparcel.png" alt="cadparcel" width="20"/></a> </td></tr>
<tr><td><a href="http://git.digital-guard.org/preservCutGeo-BR2021/tree/main/data/SP/Jacarei/_pk0145.01">Dados publicados</a></td></tr>
</table>
</aside>

<section>

Este repositório de metadados descreve um pacote de arquivos doado para o domínio público. Ele está sendo preservado pela Digital Guard: para maiores detalhes consulte a [documentação sobre o processo de registro e preservação](https://git.digital-guard.org/preserv/tree/main/docs).

Nota. O presente documento README foi gerado por software a partir das informações contidas no arquivo [`make_conf.yaml`](make_conf.yaml) deste pacote, e informações adicionais dos catálogos de [doadores](https://git.digital-guard.org/preserv-BR/blob/main/data/donor.csv) e de [pacotes](https://git.digital-guard.org/preserv-BR/blob/main/data/donatedPack.csv).

# Camadas de dados

Os arquivos contêm "camadas de dados" temáticas. Os metadados também descrevem como cada camada foi avaliada e seus dados filtrados de forma padronizada.

## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-cadparcel.png" alt="cadparcel" width="20"/> cadparcel

Nome do arquivo: `AddressForAll/LOTES_COM_NUMERO_TODOS`.<br/>*Download* e integridade: [16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar](http://dl.digital-guard.org/16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar)<br/>Descrição: Lotes, logradouros, bairros e endereços<br/>Tamanho do arquivo: 12508908 bytes (11.93 <abbr title="mebibyte">MiB</abbr>)<br/>Formato: xlsx<br/>SRID: 31983

#### Dados relevantes
* `Endereço` (via)

* `Endereço` (hnum)

* `Endereço` (nsvia)

#### Outros dados relevantes
* `Inscrição Imobiliária`: Inscrição do lote

Complementa [parcel](#-parcel) por meio de `insclote` e `insclote`

## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-parcel.png" alt="parcel" width="20"/> parcel

Nome do arquivo: `AddressForAll/LOTES_2021`.<br/>*Download* e integridade: [16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar](http://dl.digital-guard.org/16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar)<br/>Descrição: Lotes, logradouros, bairros e endereços<br/>Tamanho do arquivo: 12508908 bytes (11.93 <abbr title="mebibyte">MiB</abbr>)<br/>Formato: shp<br/>SRID: 31983

#### Outros dados relevantes
* `INSCLOTE`: Inscrição do lote

<br/>Complementado por [cadparcel](#-cadparcel) por meio de `insclote` e `insclote`

## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-nsvia.png" alt="nsvia" width="20"/> nsvia

Nome do arquivo: `AddressForAll/Loteamentos_2017`.<br/>*Download* e integridade: [16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar](http://dl.digital-guard.org/16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar)<br/>Descrição: Lotes, logradouros, bairros e endereços<br/>Tamanho do arquivo: 12508908 bytes (11.93 <abbr title="mebibyte">MiB</abbr>)<br/>Formato: shp<br/>SRID: 31983

#### Dados relevantes
* `LOTEAMENTO` (nsvia): nome de bairro sem acentuação

## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-via.png" alt="via" width="20"/> via

Nome do arquivo: `AddressForAll/Eixo_logradouros_nomes`.<br/>*Download* e integridade: [16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar](http://dl.digital-guard.org/16075eaba18c74d131e46efacfc88a43cd6154696fd6dbf96f29fecf2fbca54e.rar)<br/>Descrição: Lotes, logradouros, bairros e endereços<br/>Tamanho do arquivo: 12508908 bytes (11.93 <abbr title="mebibyte">MiB</abbr>)<br/>Formato: shp<br/>SRID: 31983

#### Dados relevantes
* `Nome_LOG` (via)

</section>
<section>

# Reprodutibilidade

Ver detalhes em [reproducibility.sh](reproducibility.sh).

</section>

