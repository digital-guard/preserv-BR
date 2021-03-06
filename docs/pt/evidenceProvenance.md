
# Registro proveniência do domínio da doação

> ✋ ESCOPO: procedimentos para registro de evidência da *proveniência* dos dados, comprovando-se a **enquivalência entre doador e  proprietário do endereço Internet que comparece na doação *online***.

Ver documento principal **no projeto  principal, Preserv**, em http://git.digital-guard.org/preserv/blob/main/docs/pt/evidenceProvenance.md

O presente documento contém apenas especificidades e dicas para execussão dos procedimentos no contexto Brasil.

## Registro da evidência de domínio

No Brasil os proprietários de domínio podem ter seu CNPJ comprovado através da consulta ao **WHOIS do Registro-BR**,<br/> https://registro.br/tecnologia/ferramentas/whois <br/>Todavia nem sempre será o CNPJ do responsável final. Podem haver encadeamentos formais de responsabilidade. Tradicionalmente os governos estaduais e governos municipais não são designados na Internet diretamente por um domínio, mas por **subdomínios** (parte final do *hostname*). Nos exemplos a prefeitura de São Paulo é subdomínio de `sp.gov.br` e a prefeitura de Vitória é subdomínio de `es.gov.br`.

Os **subdomínios `gov.br`** dos estados são gerenciados por autarquias independentes, listadas em https://iprefeituras.com.br/como-ter-dominio-governamental   <br/>No exemplo `sp.gov.br` é gerenciado pela PRODESP, que oferece seu "WHOIS de subdomínio" em https://www.dominio.sp.gov.br

### Exemplo do *download* GeoSampa

Como vimos na tabela acima, a URL da página de *downloads* do GeoSampa é um pouco mais complexo, http://geosampa.prefeitura.sp.gov.br  <br/>Ela requer que primeiro seja estabelecido o vínculo do gestor PRODESP com o domínio `SP.GOV.BR`.<br/>PS: se buscar `geosampa.prefeitura.sp.gov.br` o resultado será o mesmo.

&nbsp;&nbsp;![](../_assets/ex03-DomainOwnner_evidence-SP-Sampa.png)

Coletada essa evidência, que pode ser comum a diversos outros doadores, **estaremos comprovando o vínculo entre o domínio `sp.gov.br` e o `CNPJ 62.577.929/0001-35`** da PRODESP.  <br/>NOTA: o uso de serviços não-oficiais tais como Google ou [IPrefeituras/dominio-governamental](https://iprefeituras.com.br/como-ter-dominio-governamental) é meramente confirmativo e informal, não tem valor jurídico.

Em seguida consultamos a página (de responsabilidade da PRODESP) que faz  papel de "WHOIS de `sp.gov.br`", https://www.dominio.sp.gov.br <br/> NOTA: se por azar não houvesse, seria necessária a consulta por e-mail ou eSIC, como no caso de `es.gov.br`.

&nbsp;&nbsp;![](../_assets/ex04-SubDomainOwnner_evidence-SP-Sampa-prefeitura.png)

Evidencia-se por fim a relação entre o subdomínio `prefeitura.sp.gov.br` e o `CNPJ 46.392.080/0001-79` da Prefeitura, que é a o doador e responsável pelo GeoSampa.
