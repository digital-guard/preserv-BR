
## ############################
## SELF-GENERATE MAKE (make me)
##

mkme_input        = ./make_conf.yaml
country           = BR
baseSrc           = /opt/gits/_dg

srcPy             = $(baseSrc)/preserv/src/run_mustache.py
mkme_input0       = $(baseSrc)/preserv-$(country)/src/maketemplates/commomFirst.yaml
mkme_srcTplLast   = $(baseSrc)/preserv-$(country)/src/maketemplates/commomLast.mustache.mk

thisTplFile_root  = $(shell grep 'thisTplFile_root'  < $(mkme_input0) | cut -f2 -d':' |  sed 's/^[ \t]*//' | sed 's/[\ \#].*//')
sandbox           = $(shell grep 'sandbox'           < $(mkme_input0) | cut -f2 -d':' |  sed 's/^[ \t]*//' | sed 's/[\ \#].*//')
schemaId_template = $(shell grep 'schemaId_template' < $(mkme_input)  | cut -f2 -d':' |  sed 's/^[ \t]*//' | sed 's/[\ \#].*//')
pkid              = $(shell grep 'pkid'              < $(mkme_input)  | cut -f2 -d':' |  sed 's/^[ \t]*//' | sed 's/[\ \#].*//')

mkme_srcTpl       = $(baseSrc)/$(thisTplFile_root)/src/maketemplates/make_$(schemaId_template).mustache.mk
mkme_output       = $(sandbox)/make_me.mk_$(country)_pkid$(pkid)

readme_srcTpl     = $(baseSrc)/preserv-$(country)/src/maketemplates/readme.mustache
readme_output     = $(sandbox)/README-draft.md_$(country)_pkid$(pkid)

script_quotes     = $(baseSrc)/preserv/src/quotes.bash

info:
	@echo "=== Targets  ==="
	@printf "readme: gera rascunho de Readme.md para conjunto de dados.\n"
	@printf "me: gera makefile para ingestão dos dados, a partir de make_conf.yaml\n"

readme: $(srcPy) $(mkme_input) $(readme_srcTpl)
	@echo "-- Create basic readme.md template --"
	python3 $(srcPy) -b $(baseSrc)/ -t $(readme_srcTpl) -i $(mkme_input)  > $(readme_output)
	chmod 777 $(readme_output)
	@echo " Check diff, the '<' lines are the new ones... Something changed?"
	@diff $(readme_output) ./README-draft.md || :
	@echo "If some changes, and no error in the changes, move the readme:"
	@echo " mv $(readme_output) ./README-draft.md"
	@echo "[ENTER para rodar mv ou ^C para sair]"
	@read _tudo_bem_
	mv $(readme_output) ./README-draft.md

me: $(srcPy) $(mkme_input0) $(mkme_input) $(mkme_srcTpl) $(script_quotes)
	@echo "-- Updating this make --"
	python3 $(srcPy) -b $(baseSrc)/ -t $(mkme_srcTpl) --tplLast=$(mkme_srcTplLast) -i $(mkme_input) --input0=$(mkme_input0) > $(mkme_output)
	chmod 777 $(mkme_output)
	bash $(script_quotes) $(mkme_output)
	@echo " Check diff, the '<' lines are the new ones... Something changed?"
	@diff $(mkme_output) ./makefile || :
	@echo "If some changes, and no error in the changes, move the script:"
	@echo " mv ./makefile ./bk-makefile"
	@echo " mv $(mkme_output) ./makefile"
	@echo "[ENTER para rodar mv ou ^C para sair]"
	@read _tudo_bem_
	mv $(mkme_output) ./makefile
