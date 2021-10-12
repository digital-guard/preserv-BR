##
## Template file reference: preserv-CO/data/_pk004
## tplId: 004a
##
tplInputSchema_id=004a

## BASIC CONFIG
pg_io  ={{pg_io}}
orig   ={{orig}}
pg_uri ={{pg_uri}}
sandbox_root={{sandbox}}
need_commands= osm2pgsql v1.2.1+ ; {{need_extra_commands}}
srid   ={{srid}}

pkid = {{pkid}}
fullPkID={{pkid}}_{{pkversion}}
sandbox=$(sandbox_root)/_pk$(fullPkID)

## USER CONFIGS
pg_db  ={{pg_db}}
thisTplFile_root = {{thisTplFile_root}}


{{#files}}
part{{p}}_file  ={{file}}
part{{p}}_name  ={{name}}
{{/files}}

## COMPOSED VARS
pg_uri_db   =$(pg_uri)/$(pg_db)

{{#files}}
part{{p}}_path  =$(orig)/$(part{{p}}_file)
{{/files}}

all:
	@echo "=== Resumo deste makefile de recuperação de dados preservados ==="
	@printf "Targets para a geração de layers:\n\tall_layers {{#layers_keys}}{{.}} {{/layers_keys}}\n"
	@printf "Demais targets implementados:\n\tclean wget_files\n"
	@echo "A geração de layers requer os seguintes comandos e versões:\n\t$(need_commands)"

all_layers: {{#layers_keys}}{{.}} {{/layers_keys}}
	@echo "--ALL LAYERS--"


## ## ## ## ## ## ## ## ##
## Make targets of the Project Digital Preservation
{{#layers}}
{{#openstreetmap}}## ## ## ## sponsored by Project AddressForAll
openstreetmap: makedirs $(part{{file}}_path)
	@# pk{{pkid}}_p{{file}} - ETL extrating to PostgreSQL/PostGIS the "openstreetmap" data
	cd $(sandbox);  cp  $(part{{file}}_path) . ; chmod -R a+rx . > /dev/null
	osm2pgsql -E $(srid) -c -d $(pg_db) -U postgres -H localhost --slim --hstore --extra-attributes --hstore-add-index --multi-geometry --number-processes 4 --style /usr/share/osm2pgsql/empty.style $(sandbox)/$(part{{file}}_file)
	@echo FIM.

openstreetmap-clean:
	rm -f "$(sandbox)/{{orig_filename}}.*" || true
{{/openstreetmap}}
{{/layers}}
## ## ## ## ## ## ## ## ##

makedirs: clean_sandbox
	@mkdir -p $(sandbox_root)
	@mkdir -p $(sandbox)
	@mkdir -p $(pg_io)

wget_files:
	@echo "Under construction, need to check that orig path is not /var/www! or use orig=x [ENTER if not else ^C]"
	@echo $(orig)
	@read _ENTER_OK_
	mkdir -p $(orig)
{{#files}}
	@cd $(orig); wget http://preserv.addressforall.org/download/{{file}}
{{/files}}
	@echo "Please, if orig not default, run 'make _target_ orig=$(orig)'"

## ## ## ##

clean_sandbox:
	@rm -rf $(sandbox) || true

clean: openstreetmap-clean
