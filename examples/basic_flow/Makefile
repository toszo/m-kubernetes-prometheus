K8SPROM := epiphanyplatform/k8sprometheus:0.0.1

makefile_dir_path := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
#makes it easier to replace the value
M_NAME            ?= k8s-prom-module-test
M_SHARED_EXTERNAL ?= $(makefile_dir_path)/$(M_NAME)/shared

export

all: apply

init: init-mk8sprom

init-mk8sprom: setup
	@docker run --rm \
		-v $(M_SHARED_EXTERNAL):/shared \
		-t $(K8SPROM) \
		init \
		M_NAME=$(M_NAME)

setup: $(M_SHARED_EXTERNAL)

$(M_SHARED_EXTERNAL):
	@mkdir -p $(dir $@)