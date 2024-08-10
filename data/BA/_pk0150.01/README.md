<aside>
<table align="right" style="padding: 1em">
<tr><td>Pacote <big><b>pk0150.01</b></big> de <small><a target="_afacodes" title="Jurisdição" href="https://afa.codes/BR-BA">BR-BA</a></small>
</td></tr>
<tr><td>
Doador: <a rel="external" target="_doador" href="https://servicos.neoenergiacoelba.com.br/Pages/index.aspx">Companhia de Eletricidade do Estado da Bahia - COELBA</a>
<br/>&nbsp; <small>CNPJ 15.139.629/0001-94</small> • Wikidata <a rel="external" target="_doador" title="link descritor Wikidata do doador" href="https://www.wikidata.org/wiki/Q9790126">Q9790126</a></small><br/>

Obtido via <i>email</i> em <b>08/11/2021</b> por:
<br/>&nbsp; Avaliação técnica: <a rel="external" target="_gitPerson" title="usuário Git" href="https://github.com/luisfelipebr">luisfelipebr</a>
<br/>&nbsp; Representação institucional: <a rel="external" target="_gitPerson" title="usuário Git" href="https://github.com/ThierryAJean">ThierryAJean</a><br/>
</td></tr>
<tr><td>Camadas: <a title="geoaddress" href="#-geoaddress"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-geoaddress.png" alt="geoaddress" width="20"/></a> </td></tr>

</table>
</aside>

<section>

Este repositório de metadados descreve um pacote de arquivos doado para o domínio público. Ele está sendo preservado pela Digital Guard: para maiores detalhes consulte a [documentação sobre o processo de registro e preservação](https://wiki.addressforall.org/doc/Documentação_Digital-guard).

Nota. O presente documento README foi gerado por software a partir das informações contidas no arquivo [`make_conf.yaml`](https://git.digital-guard.org/preserv-BR/blob/main/data/BA/_pk0150.01/make_conf.yaml) deste pacote, e informações adicionais dos catálogos de [doadores](https://git.digital-guard.org/preserv-BR/blob/main/data/donor.csv) e de [pacotes](https://git.digital-guard.org/preserv-BR/blob/main/data/donatedPack.csv).

# Camadas de dados

Os arquivos contêm "camadas de dados" temáticas. Os metadados também descrevem como cada camada foi avaliada e seus dados filtrados de forma padronizada.

## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-geoaddress.png" alt="geoaddress" width="20"/> geoaddress

Nome do arquivo: `Table_Data_CLB_v2.txt`<br/>*Download* e integridade: [6737c438c504c4f1a930e07ba6f392eedeb95b3ed96b9781187000b48f0eb082.zip](https://dl.digital-guard.org/6737c438c504c4f1a930e07ba6f392eedeb95b3ed96b9781187000b48f0eb082.zip)<br/>Formato: txt<br/>SRID: 4326

#### Dados relevantes
* `NUMERO` (hnum)

* `TIPO_LOGRADOURO LOGRADOURO` (via)

* `DE_BAIRRO` (nsvia)

* `CEP` (postcode)

* `CIDADE` (city)

</section>
<section>

# Reprodutibilidade

O processo de transformação dos *dados orginais* (arquivos doados) em *dados filtrados* pode ser reproduzido por qualquer pessoa fazendo uso das mesmas ferramentas de software utilizadas pelo projeto. A seguir a sequência de comandos *bash* que garantem a [reprodutibilidade](https://en.wikipedia.org/wiki/Reproducibility) do processo a cada *layer*. Qualquer pessoa, munida dos [ferramentas de software utilizadas pelo projeto](https://git.AddressForAll.org/suporte/blob/master/docs/pt/infra.md#ambientes-e-ferramentas-de-uso-geral), vai gerar os mesmos resultados.

Pode-se reproduzir de dois modos:
* artesanal: com os comandos em [reproducibility.sh](https://git.digital-guard.org/preserv-BR/blob/main/data/BA/_pk0150.01/reproducibility.sh), depois de seguir a sequência de preparo da base de dados no esquema *ingest*.
* automático: usando o comando `make` conforme descrito na documentação do projeto.

</section>

