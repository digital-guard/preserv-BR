<aside>
<table align="right" style="padding: 1em">
<tr><td>Pacote <a target="_git" title="link canônico para o git deste pacote" href="http://git.digital-guard.org/preserv-BR/blob/main/data/RS/Bage/_pk0082.01"><big><b>pk0082.01</b></big></a> de <small><a target="_osmcodes" title="Jurisdição" href="https://osm.codes/BR-RS-Bage">BR-RS-Bage</a></small>
</td></tr>
<tr><td>
Doador: <a rel="external" target="_doador" href="https://www.bage.rs.gov.br/">Prefeitura Municipal de Bagé</a>
<br/>&nbsp; <small>CNPJ 88.073.291/0001-99</small> • Wikidata <a rel="external" target="_doador" title="link descritor Wikidata do doador" href="https://www.wikidata.org/wiki/Q119140">Q119140</a></small><br/>

Obtido via <i>GitHub</i> em <b>2022-04-25</b> por:
<br/>&nbsp; Avaliação técnica: <a rel="external" target="_gitPerson" title="usuário Git" href="https://github.com/luisfelipebr">luisfelipebr</a>
<br/>&nbsp; Representação institucional: <a rel="external" target="_gitPerson" title="usuário Git" href="https://github.com/ThierryAJean">ThierryAJean</a><br/>
</td></tr>
<tr><td>Camadas: <a title="via" href="#-via"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-via.png" alt="via" width="20"/></a> <a title="block" href="#-block"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-block.png" alt="block" width="20"/></a> <a title="parcel" href="#-parcel"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-parcel.png" alt="parcel" width="20"/></a> </td></tr>

</table>
</aside>

<section>

Este repositório de metadados descreve um pacote de arquivos doado para o domínio público. Ele está sendo preservado pela Digital Guard: para maiores detalhes consulte a [documentação sobre o processo de registro e preservação](https://wiki.addressforall.org/doc/Documentação_Digital-guard).

Nota. O presente documento README foi gerado por software a partir das informações contidas no arquivo [`make_conf.yaml`](http://git.digital-guard.org/preserv-BR/blob/main/data/RS/Bage/_pk0082.01/make_conf.yaml) deste pacote, e informações adicionais dos catálogos de [doadores](https://git.digital-guard.org/preserv-BR/blob/main/data/donor.csv) e de [pacotes](https://git.digital-guard.org/preserv-BR/blob/main/data/donatedPack.csv).

# Camadas de dados

Os arquivos contêm "camadas de dados" temáticas. Os metadados também descrevem como cada camada foi avaliada e seus dados filtrados de forma padronizada.

## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-parcel.png" alt="parcel" width="20"/> parcel

Nome do arquivo: `LOTES_URBANOS`<br/>*Download* e integridade: [7fc034ac5c703dcfe93567bd5196ce6eba22df7b779b15ca713b026e85f64759.zip](http://dl.digital-guard.org/7fc034ac5c703dcfe93567bd5196ce6eba22df7b779b15ca713b026e85f64759.zip)<br/>Descrição: LOTES<br/>Tamanho do arquivo: 10319163 bytes (9.84 <abbr title="mebibyte">MiB</abbr>)<br/>Formato: geojson<br/>SRID: 31981

## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-block.png" alt="block" width="20"/> block

Nome do arquivo: `QUARTEIRAO`<br/>*Download* e integridade: [47063f994f552e27c3b528fcc60cb03e36923b6875dd862dc54062e0ecb3bf60.zip](http://dl.digital-guard.org/47063f994f552e27c3b528fcc60cb03e36923b6875dd862dc54062e0ecb3bf60.zip)<br/>Descrição: quarteirões<br/>Tamanho do arquivo: 1496124 bytes (1.43 <abbr title="mebibyte">MiB</abbr>)<br/>Formato: geojson<br/>SRID: 31981

## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-via.png" alt="via" width="20"/> via

Nome do arquivo: `LOGRADOUROS-utf8`<br/>*Download* e integridade: [e77fe6f601a65e46244bc70b4f19008ad4ce3b1db36fafbaed2a248429504e81.zip](http://dl.digital-guard.org/e77fe6f601a65e46244bc70b4f19008ad4ce3b1db36fafbaed2a248429504e81.zip)<br/>Descrição: LOGRADOUROS<br/>Tamanho do arquivo: 456311 bytes (0.44 <abbr title="mebibyte">MiB</abbr>)<br/>Formato: geojson<br/>SRID: 31981

</section>
<section>

# Reprodutibilidade

O processo de transformação dos *dados orginais* (arquivos doados) em *dados filtrados* pode ser reproduzido por qualquer pessoa fazendo uso das mesmas ferramentas de software utilizadas pelo projeto. A seguir a sequência de comandos *bash* que garantem a [reprodutibilidade](https://en.wikipedia.org/wiki/Reproducibility) do processo a cada *layer*. Qualquer pessoa, munida dos [ferramentas de software utilizadas pelo projeto](https://git.AddressForAll.org/suporte/blob/master/docs/pt/infra.md#ambientes-e-ferramentas-de-uso-geral), vai gerar os mesmos resultados.

Pode-se reproduzir de dois modos:
* artesanal: com os comandos em [reproducibility.sh](http://git.digital-guard.org/preserv-BR/blob/main/data/RS/Bage/_pk0082.01/reproducibility.sh), depois de seguir a sequência de preparo da base de dados no esquema *ingest*.
* automático: usando o comando `make` conforme descrito na documentação do projeto.

</section>

