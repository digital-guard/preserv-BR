# Dados e metadados

Metadados de entrada são aqueles fornecidos pelos operadores autorizados.

Metadados de saída ([`_out`](_out)) são gerados automaticamente pelo [*software* do projeto Preserv](http://git.digital-guard.org/preserv), a partir da leitura dos arquivos no *filesystem* e cruzamento com demais dados. A saída de dados filtrados fica armazenada no [git preservCutGeo-BR2021](https://git.digital-guard.org/preservCutGeo-BR2021) e demais recortes e atualizações.

-----

## Jurisdições

Nomes e identificadores de regiões, estados e municípios, organizados conforme [datasets.OK.org.br](http://datasets.OK.org.br) e semântica de jurisdição fixada pelas [URNs LEX](https://en.wikipedia.org/wiki/Lex_(URN)).

Para alterar Jurisdições fazer upload e editar em interface amigável [desta planilha online colaborativa](https://docs.google.com/spreadsheets/d/1xibgSNwdbBbTS1Uv1eFfP_lWpiXYvGnhHBEP_bAPYwk/). Exemplos:

* [`jurisdictionLevel3`](jurisdictionLevel3.csv): regiões (Sul, Norte, etc.), que no OpenStreetMap correspondem a jurisdição de nível 3 (`admin_level=3`).

* [`jurisdictionLevel4`](jurisdictionLevel4.csv): estados (AC, AM, ES, etc.), que no OpenStreetMap correspondem a jurisdição de nível 4 (`admin_level=4`).

* `$UF/jurisdictionLevel8`: municípios no contexto do estado (AM/Manaus, SP/Itu, etc.), que no OpenStreetMap correspondem a jurisdição de nível 8 (`admin_level=8`). Exemplo: [AC/jurisdictionLevel8](AC/jurisdictionLevel8.csv).

## Packages e seus metadados

Todo pacote de dados tem origem numa doação para o domínio público, ou cessão de direitos para a organização proprietária do domínio `digital-guard.org`. E toda doação está relacionada ao seu doador. Em função deste arranjo são preservados os seguintes metadados neste *git*:

* metadados do [**doador** (`donor`)](donor.csv): identificação interna sequencial (_local_id_), identificação pública (ex. CNPJ), nome e demais metados essenciais da [organização](https://schema.org/Organization) doadora.

* metadados do [**pacote doado** (`donatedPack`)](donatedPack.csv): identificador sequencial de pacote (_pack_id_), doador relacionado, data de homologação pela Curadoria, e demais metadados do pacote, que pode conter um ou mais arquivos compactados. Os pacotes podem ainda ser atualizados ao longo dos anos, resultando em versões mais atualizadas.  Neste repositório *git* tanto as correções como as novas versões se sobrepõe às antigas.

* Demais metadados e descritores: ver cada pasta `_pk$id` em `preserv-$país`. Por exemplo na pasta [_pk0001.03](_pk0001.03) um pacote de escopo nacional e na pasta [RS/PortoAlegre/_pk0018.01](RS/PortoAlegre/_pk0018.01) um pacote de escopo municipal.

## Planilhas colaborativas

Favor usar APENAS OS LINKS ABAIXO para inicio de edição, antes de alterar o *git*:

* [**donations-BR**](https://docs.google.com/spreadsheets/d/1-FQjjhHjJnAOxSWYEdFU_RePxAJDsJCnLviOyDo3QMM/): planilha colaborativa de doadores e pacotes, fonte para ser editada antes de `donatedPack.csv`, `donor.csv`.

* [**preserv_BR-jurisdictions**](https://docs.google.com/spreadsheets/d/1xibgSNwdbBbTS1Uv1eFfP_lWpiXYvGnhHBEP_bAPYwk/): planilha colaborativa de jurisdições,  fonte para ser editada antes de `data/jurisdictionLevel3.csv`, `data/jurisdictionLevel4.csv`, `data/*/jurisdictionLevel8.csv` (onde `*` é `AC`, `AM`, `ES`).
