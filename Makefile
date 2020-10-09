build-container-with-skaffold := true

include make.d/workspace.mk
include make.d/container.mk


.DEFAULT_GOAL := help

define container_d =
$(1)~container: ## $(1)
$(1)~container: docker-dir := $(top-dir)
$(1)~container: skaffold.yaml $(shell find $(1) -type d  -name target -prune -o -type f -print)
endef

containers := $(subst /,,$(dir $(wildcard */Dockerfile)))

$(foreach container,$(containers), $(eval $(call container_d,$(container))))

build: $(foreach container,$(containers),$(container)~container); @:

include skaffold.mk


