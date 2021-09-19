# grep em config do yaml, removendo espaços iniciais ou finais e eventuais comentários iniciados com '#'
mkme_input        = ./make_conf.yaml
country           = BR
baseSrc           = /opt/gits/_dg

srcPy             =  $(baseSrc)/preserv/src/run_mustache.py
mkme_input0       =  $(baseSrc)/preserv-$(country)/src/maketemplates/commomFirst.yaml
mkme_srcTplLast   =  $(baseSrc)/preserv-$(country)/src/maketemplates/commomLast.mustache.mk

thisTplFile_root  = $(shell grep 'thisTplFile_root'  < $(mkme_input0) | cut -f2 -d':' |  sed 's/^[ \t]*//' | sed 's/[\ \#].*//')
schemaId_template = $(shell grep 'schemaId_template' < $(mkme_input)  | cut -f2 -d':' |  sed 's/^[ \t]*//' | sed 's/[\ \#].*//')
thisTplFile       = $(thisTplFile_root)/src/maketemplates/make_$(schemaId_template).mustache.mk

mkme_srcTpl       =  $(baseSrc)/$(thisTplFile)
mkme_output       = /tmp/digitalPresservation-make_me.mk

me: $(srcPy) $(mkme_input0) $(mkme_input) $(mkme_srcTpl)
	@echo "-- Updating this make --"
	python3 $(srcPy) -b $(baseSrc)/ -t $(mkme_srcTpl) --tplLast=$(mkme_srcTplLast) -i $(mkme_input) --input0=$(mkme_input0) > $(mkme_output)
	@echo " Check diff, the '<' lines are the new ones... Something changed?"
	@diff $(mkme_output) ./makefile || :
	@echo "If some changes, and no error in the changes, move the script:"
	@echo " mv ./makefile ./bk-makefile"
	@echo " mv $(mkme_output) ./makefile"
	@echo "[ENTER para rodar mv ou ^C para sair]"
	@read _tudo_bem_
	mv $(mkme_output) ./makefile
