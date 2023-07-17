.ONESHELL:
.NOTPARALLEL:
SHELL          = bash
PROJECT       := vos-consultancy
GITROOT       := $(shell git rev-parse --show-toplevel)

help:
	@grep '^[^#[:space:]].*:' Makefile

install:
	@$(GITROOT)/bin/install.sh
update:
	@$(GITROOT)/bin/update.sh
activate:
	@if [ -f "$(GITROOT)/pip_requirements.txt" ]
	then
	  @. venv/bin/activate
	fi

.PHONY: help Makefile
