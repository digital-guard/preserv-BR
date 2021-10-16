#!/bin/sh

# retorna todos os diretórios com o padrão '*_pk*' e copia o arquivo makefile_Pk_First para cada um deles, renomeando o arquivo para makefile.
find ../data -type d -name '*_pk*' -exec cp maketemplates/commomLast.mustache.mk \{\}/makefile \;
