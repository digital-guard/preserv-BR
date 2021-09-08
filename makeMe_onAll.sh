#!/bin/sh

# retorna todos os diretórios com o padrão '*_pk*' e copia o arquivo makefile para cada um deles.
find . -type d -name '*_pk*' -exec cp makefile \{\} \;
