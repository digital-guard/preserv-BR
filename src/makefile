
baseSrc = $(shell ls -d "${PWD}" | cut -d'-' -f1)

info:
	@echo "------------------------------------------------------"
	@echo "Cria arquivos makefile iniciais para os pacotes '_pk*'"
	@echo "------------------------------------------------------"
	@echo ""
	@echo "Targets disponíveis:"
	@echo " * all: cria makefile para todos os diretórios '_pk*', no diretório data,"
	@echo "        copiando o arquivo makefile_Pk_First.mk em cada um deles."

all: makefile_pk_first

makefile_pk_first:
	@echo "------------------------------------------------------"
	@echo "Iniciada cópia de makefile_Pk_First.mk nos diretórios '_pk*' de data."
	# retorna todos os diretórios com o padrão '*_pk*' e copia o arquivo makefile_Pk_First para cada um deles, renomeando o arquivo para makefile.
	find ../data -type d -name '*_pk*' -exec cp $(baseSrc)/src/maketemplates/commomLast.mustache.mk \{\}/makefile \;
	@echo "Finalizada a cópia "
	@echo "------------------------------------------------------"
