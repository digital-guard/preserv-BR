
## ############################ ##
## SELF-GENERATE MAKE (make me) ##
## ############################ ##

mkme_input        = $(shell ls -d "${PWD}/"make_conf.yaml)
country           = $(shell ls -d "${PWD}" | cut -d'-' -f2 | cut -d'/' -f1)
baseSrc           = /opt/gits/_dg

mkme_input0       = $(baseSrc)/preserv-$(country)/src/maketemplates/commomFirst.yaml

pg_io             = $(shell grep 'pg_io'  < $(mkme_input0) | cut -f2  -d':' | sed 's/^[ \t]*//' | sed 's/[\ \#].*//')
pg_uri            = $(shell grep 'pg_uri' < $(mkme_input0) | cut -f2- -d':' | sed 's/^[ \t]*//' | sed 's/[\ \#].*//')
pg_db             = $(shell grep 'pg_db'  < $(mkme_input0) | cut -f2  -d':' | sed 's/^[ \t]*//' | sed 's/[\ \#].*//')
pkid              = $(shell grep 'pkid'   < $(mkme_input)  | cut -f2  -d':' | sed 's/^[ \t]*//' | sed 's/[\ \#].*//')

pg_uri_db         = $(pg_uri)/$(pg_db)

mkme_output       = $(pg_io)/makeme_$(country)$(pkid)
readme_output     = $(pg_io)/README-draft_$(country)$(pkid)

info:
	@echo "=== Targets  ==="
	@printf "me: gera makefile para ingestão dos dados, a partir de make_conf.yaml.\n"
	@printf "readme: gera rascunho de Readme.md para conjunto de dados.\n"
	@printf "insert_make_conf.yaml: carrega na base de dados o arquivo make_conf.yaml.\n"

me:
	@echo "-- Updating this make --"
	psql $(pg_uri_db) -c "SELECT ingest.lix_generate_makefile('$(country)','$(pkid)');"
	sudo chmod 777 $(mkme_output)
	@echo " Check diff, the '<' lines are the new ones... Something changed?"
	@diff $(mkme_output) ./makefile || :
	@echo "If some changes, and no error in the changes, move the script:"
	@echo " mv $(mkme_output) ./makefile"
	@echo "[ENTER para rodar mv ou ^C para sair]"
	@read _tudo_bem_
	mv $(mkme_output) ./makefile

readme:
	@echo "-- Create basic README-draft.md template --"
	psql $(pg_uri_db) -c "SELECT ingest.lix_generate_readme('$(baseSrc)','$(country)','$(pkid)');"
	sudo chmod 777 $(readme_output)
	@echo " Check diff, the '<' lines are the new ones... Something changed?"
	@diff $(readme_output) ./README-draft.md || :
	@echo "If some changes, and no error in the changes, move the readme:"
	@echo " mv $(readme_output) ./README-draft.md"
	@echo "[ENTER para rodar mv ou ^C para sair]"
	@read _tudo_bem_
	mv $(readme_output) ./README-draft.md

insert_make_conf.yaml:
	@echo "-- Carrega make_conf.yaml na base de dados. --"
	@echo "Uso: make insert_make_conf.yaml"
	@echo "pkid: $(pkid)"
	@echo "[ENTER para continuar ou ^C para sair]"
	@read _tudo_bem_
	psql $(pg_uri_db) -c "SELECT ingest.lix_insert('$(country)','$(mkme_input)','make_conf');"
