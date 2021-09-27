##
## Template file reference: preserv-BR/data/SC/Florianopolis/_pk059
## tplId: 059a
##
tplInputSchema_id=059a


## BASIC CONFIG
pg_io  ={{pg_io}}
orig   ={{orig}}
pg_uri ={{pg_uri}}
sandbox_root={{sandbox}}
need_commands= 7z v16+; psql v12+; shp2pgsql v3+; {{need_extra_commands}}
srid   ={{srid}}

pkid = {{pkid}}
fullPkID={{pkid}}_{{pkversion}}
sandbox=$(sandbox_root)/_pk$(fullPkID)

## USER CONFIGS
pg_db  ={{pg_db}}
thisTplFile_root = {{thisTplFile_root}}

## ## ## ## ## ## ##
## THIS_MAKE, _pk{{pkid}}

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
	@printf "Demais targets implementados:\n\tclean wget_files me\n"
	@echo "A gereação de layers requer os seguintes comandos e versões:\n\t$(need_commands)"

all_layers: {{#layers_keys}}{{.}} {{/layers_keys}}
	@echo "--ALL LAYERS--"

## ## ## ## ## ## ## ## ##
## ## ## ## ## ## ## ## ##
## Make targets of the Project Digital Preservation
{{#layers}}


{{#nsvia}}## ## ## ## sponsored by Project AddressForAll
nsvia: layername = nsvia_{{subtype}}
nsvia: tabname = pk$(fullPkID)_p{{file}}_nsvia
nsvia: makedirs $(part{{file}}_path)
	@# pk{{pkid}}_p{{file}} - ETL extrating to PostgreSQL/PostGIS the "nsvia" datatype (zone with name)
{{>common002_layerHeader}}
	cd $(sandbox);  7z {{7z_opts}} x -y  $(part{{file}}_path) "{{orig_filename}}*"  ; chmod -R a+rx . > /dev/null
{{>common003_shp2pgsql}}
{{>common001_pgAny_load}}
	@echo FIM.

nsvia-clean: tabname = pk$(fullPkID)_p{{file}}_nsvia
nsvia-clean:
	rm -f "$(sandbox)/{{orig_filename}}.*" || true
	psql $(pg_uri_db) -c "DROP TABLE IF EXISTS $(tabname) CASCADE;  DROP VIEW IF EXISTS vw_$(tabname) CASCADE;"
{{/nsvia}}

{{#genericvia}}## ## ## ## sponsored by Project AddressForAll
genericvia: layername = genericvia_{{subtype}}
genericvia: tabname = pk$(fullPkID)_p{{file}}_genericvia
genericvia: makedirs $(part{{file}}_path)
	@# pk{{pkid}}_p{{file}} - ETL extrating to PostgreSQL/PostGIS the "genericvia" datatype (zone with name)
{{>common002_layerHeader}}
	cd $(sandbox);  7z {{7z_opts}} x -y  $(part{{file}}_path) "{{orig_filename}}*"  ; chmod -R a+rx . > /dev/null
{{>common003_shp2pgsql}}
{{>common001_pgAny_load}}
	@echo FIM.

genericvia-clean: tabname = pk$(fullPkID)_p{{file}}_genericvia
genericvia-clean:
	rm -f "$(sandbox)/{{orig_filename}}.*" || true
	psql $(pg_uri_db) -c "DROP TABLE IF EXISTS $(tabname) CASCADE;  DROP VIEW IF EXISTS vw_$(tabname) CASCADE;"
{{/genericvia}}

{{#via}}## ## ## ## sponsored by Project AddressForAll
via: layername = via_{{subtype}}
via: tabname = pk$(fullPkID)_p{{file}}_via
via: makedirs $(part{{file}}_path)
	@# pk{{pkid}}_p{{file}} - ETL extrating to PostgreSQL/PostGIS the "via" datatype (street axes)
{{>common002_layerHeader}}
	cd $(sandbox);  7z {{7z_opts}} x -y  $(part{{file}}_path) "{{orig_filename}}*"  ; chmod -R a+rx . > /dev/null
{{>common003_shp2pgsql}}
{{>common001_pgAny_load}}
	@echo FIM.

via-clean: tabname = pk$(fullPkID)_p{{file}}_via
via-clean:
	rm -f "$(sandbox)/{{orig_filename}}.*" || true
	psql $(pg_uri_db) -c "DROP TABLE IF EXISTS $(tabname) CASCADE"
{{/via}}

{{#cadvia}}## ## ## ## sponsored by Project AddressForAll
cadvia: layername = cadvia_{{subtype}}
cadvia: tabname = pk$(fullPkID)_p{{file}}_cadvia
cadvia: makedirs $(part{{file}}_path)
	@# pk{{pkid}}_p{{file}} - ETL extrating to PostgreSQL/PostGIS the "cadvia" datatype (street axes)
{{>common002_layerHeader}}
	cd $(sandbox);  7z {{7z_opts}} x -y  $(part{{file}}_path) "{{orig_filename}}*"  ; chmod -R a+rx . > /dev/null
{{>common003_shp2pgsql}}
{{>common001_pgAny_load}}
	@echo FIM.

cadvia-clean: tabname = pk$(fullPkID)_p{{file}}_cadvia
cadvia-clean:
	rm -f "$(sandbox)/{{orig_filename}}.*" || true
	psql $(pg_uri_db) -c "DROP TABLE IF EXISTS $(tabname) CASCADE"
{{/cadvia}}

{{/layers}}
## ## ## ## ## ## ## ## ##
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

clean: geoaddress-clean nsvia-clean via-clean
