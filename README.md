# preserv-BR

[Preservação digital](https://en.wikipedia.org/wiki/Digital_preservation) de  **dados primários do Brasil**, no escopo do [**Projeto Digital-Guard**](http://git.Digital-guard.org) e seus projetos-patrocinadores: [AddressForAll](http://AddressForAll.org), [OSM-codes](http://OSM.codes) e outros.

## Organização territorial e seus geocódigos

Os registros de controle da preservação são baseados em códigos e identificadores persistentes, atribuídos oficialmente pela ISO e outras iniciativas internacionais. Ao Brasil foram atribuídos: no contexto [ISO&nbsp;3166](https://en.wikipedia.org/wiki/ISO_3166) o geocódigo [**BR**](https://en.wikipedia.org/wiki/ISO_3166-2:BR) e número  [**76**](https://en.wikipedia.org/wiki/ISO_3166-1_numeric); na [Wikidata](http://Wikidata.org) o identificador	[Q155](http://wikidata.org/entity/Q155); no [OpenStreetMap](http://OSM.org) o identificador de [*relation* 59470](http://osm.org/relation/59470).

O território nacional e suas subdivisões adminisrativas representam **jurisdições**:

* O país está dividido em **26 Estados** federados (e 1 distrito federal - DF), geridos por representantes eleitos democraticamente nos respectivos territórios. <br/>Os geocódigos das Unidades da Federação (Estados e DF) seguem a convenção registrada pela [ISO&nbsp;3166&#8209;2:BR](https://en.wikipedia.org/wiki/ISO_3166-2:BR). O IBGE também fixou geocódigos numéricos. No OpenStreetMap convenciona-se o que a subdivisão por UF corresponde ao *nível administrativo 2*. <!--, abaixo da subdivisão por regiões (*nível 1* composto por Norte, Nordeste, Centro-Oeste, Sudeste e Sul).  Key:admin_level-->

* Os Estados são subdivididos em um total de **~5500 municípios**, geridos por representantes eleitos democraticamente nos respectivos territórios.<br/>O IBGE fixou geocódigos numéricos para os municípios, e o [LexML](http://www.lexml.gov.br) fixou convenções para expressar os respectivos nomes de município através de [URNs LEX](https://pt.wikipedia.org/wiki/Lex_(URN)). Quanto à abreviação dos nomes não existem padrões oficiais, adotamos neste  projeto as convenções do [DER-SP](http://www.der.sp.gov.br) na abreviação de 3 letras, adaptando padrão similar para o restante dos estados.  No OpenStreetMap convenciona-se o que os municípios correspondem ao *nível administrativo 8*.

As jurisdições de comunidades locais recebem atribuições oficiais para a geração e controle de dados. Conforme o escopo da preservação podemos destacar:
* Quem atribui nomes às ruas e define o sistema de numeração predial é o município.
* Quem definine e atribui códigos postais é a federação.
* Quem atribui nomes de vias dentro de grandes lotes é o seu proprietário (parques, condomínios, fazendas, etc.).
<!-- ?? * Quem atribui nomes de rios e demais corpos d'água é o Comitê de bacia hidrográfica em que se encontra.-->

## Organização deste repositório

Neste *git* são mantidos apenas metadados, ou seja, descritores das entidades, tais como nomes e geocódigos, enquanto mapas e outros dados, são armazenados externamente por serem muito grandes.

Os metadados foram organizados conforme [instruções Preserv](http://git.digital-guard.org/preserv-BR), na pasta [`/data`](./data):

* [`/data`](./data#readme): dados. Na raiz os dados originais de **entrada**, ou seja, metadados fornecidos para o sistema. Na pasta `/data/_out` alguns metadados de saída, principalmente comprovantes de integridade e relatórios automáticos de sumarização estatística, gerados pelo sistema.

* [`/src`](./src#readme): código-fonte dos algoritmos SQL, makefile e outros.

## Mais detalhes

* Sobre [operação deste repositório](http://git.digital-guard.org/preserv/blob/main/docs/pt/organizacao.md) 
* Sobre ...


