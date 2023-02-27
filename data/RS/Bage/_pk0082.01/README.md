# Geral

Baixamos os dados que estão disponíveis no [GitHub](https://github.com/GGC-Bage/GeoDataBase) em 2022-04-25. Todas as camadas estão no formato `geojson`.



## via

Abrir LOGRADOUROS.geojson

Copiar para o diretório alvo

SRID: 31981

id: gid

logradouro: via

geometry: geom



## parcel

Abrir LOTES_URBANOS.geojson

Copiar para o diretório alvo

SRID: 31981

id: gid

numero: house_number (numero de porta)

logradouro: via (nome do logradouro)

geometry: geom

----

Abrir LOTES_RURAIS.geojson

Copiar para o diretório alvo

SRID: 4326

id: gid

geometry: geom

----

**Obs:** necessário join entre lotes urbanos e rurais

**Obs2:** o nome do logradouro no arquivo de lotes não é igual ao nome do logradouro no arquivo de vias. Seguindo os passos abaixo é possível encontrar correspondência de 89%.

1. Remover os primeiros três caracteres

2. Separar a string em duas, utilizando a vírgula como separador

3. Na segunda string (que possui termos como AV ou TV), remover os espaços em branco a direita e esquerda (trim)

4. Criar uma nova string com: (i) segunda string, (ii) espaço " ", (iii) primeira string

```
# Código em R (caso ajude a escrever o código em POSTGIS):

data %>%
  dplyr::mutate(log2 = stringr::str_sub(logradouro, 3)) %>% # 1.
  tidyr::separate(log2, into=c("log3", "log4"), sep=",") %>% #2.
  dplyr::mutate(log3 = dplyr::if_else(is.na(log3), "", log3),
         log4 = dplyr::if_else(is.na(log4), "", log4),
         log3 = stringr::str_trim(log3), #3.
         log4 = stringr::str_trim(log4), #3.
         log5 = base::paste0(log4, " ", log3)) %>% #4.
  dplyr::select(id, log3, log4, log5) %>%
  dplyr::rename(logradouro = log5)
```



## block

Abrir QUARTEIRAO.geojson

Copiar para o diretório alvo

SRID: 31981

id: gid

geometry: geom



## Outros arquivos:

- AREA_CONTRUIDA.geojson

- ASFALTO_ANTIGO.geojson

- ASFALTO_NOVO_DESDE_2017.geojson

- BANCOS_DE_AREA_ARROIO_BAGE.geojson

- COMPREB.geojson

- CONDOMINIOS.geojson

- CURVAS_DE_NIVEL_BAGE_10M.geojson

- DISTRITOS_DE_BAGE.geojson

- DNPM_BAGE.geojson

- ESTRADAS_RURAIS_DE_BAGE.geojson

- INTERTRAVADO_DE_CONCRETO.geojson

- LIMITES_DE_BAGE.geojson

- LOTEAMENTOS.geojson

- MARCOS_DE_REFERENCIA.geojson

- PARALELEPIPEDO.geojson

- PARQUE_DO_GAUCHO_BAGE.geojson

- PAVIMENTACAO_BAGE.geojson

- PREFEITURA_DE_BAGE.geojson

- REGIOES_CENSITARIAS.geojson


