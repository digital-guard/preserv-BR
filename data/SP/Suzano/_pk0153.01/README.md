<aside>
<table align="right" style="padding: 1em">
<tr><td>Pacote <big><b>pk0153.01</b></big> de <small><a target="_afacodes" title="Jurisdição" href="https://afa.codes/BR-SP-Suzano">BR-SP-Suzano</a></small>
</td></tr>
<tr><td>
Doador: <a rel="external" target="_doador" href="https://suzano.sp.gov.br/">Prefeitura de Suzano</a>
<br/>&nbsp; <small>CNPJ 46.523.056/0001-21</small> • Wikidata <a rel="external" target="_doador" title="link descritor Wikidata do doador" href="https://www.wikidata.org/wiki/Q737670">Q737670</a></small><br/>
Licença <a rel="external" target="_doador" href="https://git.digital-guard.org/licenses/blob/master/reports/implied-govWorks_geo-BR_municipal-v1.md"><b>Implied govWorks_geo-BR_municipal-1.0</b></a> (cc0)<br/>
Obtido via <i>email</i> em <b>17/11/2023</b> por:
<br/>&nbsp; Avaliação técnica: <a rel="external" target="_gitPerson" title="usuário Git" href="https://github.com/crebollobr">crebollobr</a>
<br/>&nbsp; Representação institucional: <a rel="external" target="_gitPerson" title="usuário Git" href="https://github.com/ThierryAJean">ThierryAJean</a><br/>
</td></tr>
<tr><td>Camadas: <a title="via" href="#-via"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-via.png" alt="via" width="20"/></a> <a title="parcel" href="#-parcel"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-parcel.png" alt="parcel" width="20"/></a> </td></tr>

</table>
</aside>

<section>

Este repositório de metadados descreve um pacote de arquivos doado para o domínio público. Ele está sendo preservado pela Digital Guard: para maiores detalhes consulte a [documentação sobre o processo de registro e preservação](https://wiki.addressforall.org/doc/Documentação_Digital-guard).

Nota. O presente documento README foi gerado por software a partir das informações contidas no arquivo [`make_conf.yaml`](https://git.digital-guard.org/preserv-BR/blob/main/data/SP/Suzano/_pk0153.01/make_conf.yaml) deste pacote, e informações adicionais dos catálogos de [doadores](https://git.digital-guard.org/preserv-BR/blob/main/data/donor.csv) e de [pacotes](https://git.digital-guard.org/preserv-BR/blob/main/data/donatedPack.csv).

# Camadas de dados

Os arquivos contêm "camadas de dados" temáticas. Os metadados também descrevem como cada camada foi avaliada e seus dados filtrados de forma padronizada.

## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-parcel.png" alt="parcel" width="20"/> parcel

Nome do arquivo: `lotes_suzano`<br/>*Download* e integridade: [aff2f6a57e043ce7a5f0e2d6c120f6aba3a97621471422a11fbdfd69f82705da.zip](https://dl.digital-guard.org/aff2f6a57e043ce7a5f0e2d6c120f6aba3a97621471422a11fbdfd69f82705da.zip)<br/>Descrição: lotes_suzano<br/>Formato: shp<br/>SRID: 31983

#### Dados relevantes
* `logradouro` (via)

* `num_log` (hnum)

* `complement` (complemento)

## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-via.png" alt="via" width="20"/> via

Nome do arquivo: `logradouros`<br/>*Download* e integridade: [3f369b4082ed525f080ff6f20cd9cf35b473dfc64012f99690a043bb5d6960b1.zip](https://dl.digital-guard.org/3f369b4082ed525f080ff6f20cd9cf35b473dfc64012f99690a043bb5d6960b1.zip)<br/>Descrição: logradouros<br/>Formato: shp<br/>SRID: 31983

#### Dados relevantes
* `LOG_CAD` (via)

* `LOTEA_LEG` (nsvia)

# Evidências de teste
<img src="qgis.png" width="400"/>

</section>
<section>

# Reprodutibilidade

O processo de transformação dos *dados orginais* (arquivos doados) em *dados filtrados* pode ser reproduzido por qualquer pessoa fazendo uso das mesmas ferramentas de software utilizadas pelo projeto. A seguir a sequência de comandos *bash* que garantem a [reprodutibilidade](https://en.wikipedia.org/wiki/Reproducibility) do processo a cada *layer*. Qualquer pessoa, munida dos [ferramentas de software utilizadas pelo projeto](https://git.AddressForAll.org/suporte/blob/master/docs/pt/infra.md#ambientes-e-ferramentas-de-uso-geral), vai gerar os mesmos resultados.

Pode-se reproduzir de dois modos:
* artesanal: com os comandos em [reproducibility.sh](https://git.digital-guard.org/preserv-BR/blob/main/data/SP/Suzano/_pk0153.01/reproducibility.sh), depois de seguir a sequência de preparo da base de dados no esquema *ingest*.
* automático: usando o comando `make` conforme descrito na documentação do projeto.

</section>

