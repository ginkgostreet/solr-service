
this-dir := $(dir $(lastword $(MAKEFILE_LIST)))
include $(this-dir)env-defaults.make

zk-cmd := $(SOLR_BIN)/solr zk -z $(SOLR_HOST):9983

ping-solr-cmd = curl http://$(SOLR_HOST):$(SOLR_PORT)/api/collections --fail 2>/dev/null 1>/dev/null
ping-solr = $(ping-solr-cmd) || false

.PHONY: ping
ping:
	@$(ping-solr)

.PHONY: solr-start
solr-start:
	sudo service solr start

.PHONY: solr-stop
solr-stop:
	@sudo service solr stop

.PHONY: list-collections
list-collections: ping
	@$(zk-cmd) ls /collections

.PHONY: install-libmysql-java
install-libmysql-java:
	dpkg -S libmysql-javas || sudo apt install libmysql-java