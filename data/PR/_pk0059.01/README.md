<aside>
<table align="right" style="padding: 1em">
<tr><td>Pacote <a target="_git" title="link canônico para o git deste pacote" href="https://git.digital-guard.org/preserv-BR/blob/main/data/PR/_pk0059.01"><big><b>pk0059.01</b></big></a> de <small><a target="_afacodes" title="Jurisdição" href="https://afa.codes/BR-PR">BR-PR</a></small>
</td></tr>
<tr><td>
Doador: <a rel="external" target="_doador" href="http://www.paranacidade.org.br/">Serviço Social Autônomo Paranacidade</a>
<br/>&nbsp; <small>CNPJ 01.450.804/0001-55</small> • Wikidata <a rel="external" target="_doador" title="link descritor Wikidata do doador" href="https://www.wikidata.org/wiki/Q104848282">Q104848282</a></small><br/>
Licença <a rel="external" target="_doador" href="https://git.digital-guard.org/licenses/blob/master/reports/implied-br-generic-v1.md"><b>Implied BR-generic-1.0</b></a> (cc0)<br/>
Obtido via <i>email</i> em <b>08/12/2020</b> por:
<br/>&nbsp; Avaliação técnica: <a rel="external" target="_gitPerson" title="usuário Git" href="https://github.com/IgorEliezer">IgorEliezer</a>
<br/>&nbsp; Representação institucional: <a rel="external" target="_gitPerson" title="usuário Git" href="https://github.com/ThierryAJean">ThierryAJean</a><br/>
</td></tr>
<tr><td>Camadas: <a title="parcel" href="#-parcel"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-parcel.png" alt="parcel" width="20"/></a> </td></tr>
<tr><td>Dados publicados em <a href="https://git.digital-guard.org/preservCutGeo-BR2021/tree/main/data/PR/_pk0059.01">preservCutGeo-BR2021</a><br/><a href="#reprodutibilidade">Reprodutíveis</a></td></tr>
<tr><td>Visualização: <a title="parcel" href="https://viz.addressforall.org/BR-PR/_pk0059.01/parcel"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-parcel.png" alt="parcel" width="20"/></a> </td></tr>
</table>
</aside>

<section>

Este repositório de metadados descreve um pacote de arquivos doado para o domínio público. Ele está sendo preservado pela Digital Guard: para maiores detalhes consulte a [documentação sobre o processo de registro e preservação](https://wiki.addressforall.org/doc/Documentação_Digital-guard).

Nota. O presente documento README foi gerado por software a partir das informações contidas no arquivo [`make_conf.yaml`](https://git.digital-guard.org/preserv-BR/blob/main/data/PR/_pk0059.01/make_conf.yaml) deste pacote, e informações adicionais dos catálogos de [doadores](https://git.digital-guard.org/preserv-BR/blob/main/data/donor.csv) e de [pacotes](https://git.digital-guard.org/preserv-BR/blob/main/data/donatedPack.csv).

# Camadas de dados

Os arquivos contêm "camadas de dados" temáticas. Os metadados também descrevem como cada camada foi avaliada e seus dados filtrados de forma padronizada.

## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-parcel.png" alt="parcel" width="20"/> parcel

Nome do arquivo: `New File Geodatabase (2).gdb`<br/>*Download* e integridade: [47dca17c620c1c34ac091dac19afb8851f1d8f9a907094a0f40a0310e774445d.zip](http://dl.digital-guard.org/47dca17c620c1c34ac091dac19afb8851f1d8f9a907094a0f40a0310e774445d.zip)<br/>Descrição: Lotes<br/>Tamanho do arquivo: 193516287 bytes (184.55 <abbr title="mebibyte">MiB</abbr>)<br/>Formato: gdb<br/>SRID: 31982

#### Dados relevantes
* `nrpredial` (hnum)

#### Outros dados relevantes
* `NmMunicipio`: Nome do município

#### Resultados da filtragem e sua publicação
470024630 bytes (448.25 <abbr title="mebibyte">MiB</abbr>)<br/>2546286 polígonos com 2589.16 <abbr title="quilômetros quadrados">km²</abbr><br/>densidade média: 0.39 polígonos/km²<br/>GeoJSONs publicados em [https://git.digital-guard.org/preservCutGeo-BR2021/tree/main/data/PR/_pk0059.01/parcel](https://git.digital-guard.org/preservCutGeo-BR2021/tree/main/data/PR/_pk0059.01/parcel)

#### Visualização
[https://viz.addressforall.org/BR-PR/_pk0059.01/parcel](https://viz.addressforall.org/BR-PR/_pk0059.01/parcel)

</section>
<section>

# Reprodutibilidade

O processo de transformação dos *dados orginais* (arquivos doados) em *dados filtrados* pode ser reproduzido por qualquer pessoa fazendo uso das mesmas ferramentas de software utilizadas pelo projeto. A seguir a sequência de comandos *bash* que garantem a [reprodutibilidade](https://en.wikipedia.org/wiki/Reproducibility) do processo a cada *layer*. Qualquer pessoa, munida dos [ferramentas de software utilizadas pelo projeto](https://git.AddressForAll.org/suporte/blob/master/docs/pt/infra.md#ambientes-e-ferramentas-de-uso-geral), vai gerar os mesmos resultados.

Pode-se reproduzir de dois modos:
* artesanal: com os comandos em [reproducibility.sh](https://git.digital-guard.org/preserv-BR/blob/main/data/PR/_pk0059.01/reproducibility.sh), depois de seguir a sequência de preparo da base de dados no esquema *ingest*.
* automático: usando o comando `make` conforme descrito na documentação do projeto.

</section>

