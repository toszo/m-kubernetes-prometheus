include $(M_RESOURCES)/templates.mk
include $(M_RESOURCES)/consts.mk
include $(M_RESOURCES)/defaults.mk

export

#medatada method is printing static metadata information about module
metadata: guard-M_RESOURCES
	#k8sprom | metadata | should print component metadata
	@echo "$$M_METADATA_CONTENT"

#init method is used to initialize module configuration and check if state is providing strong (and weak) dependencies
#TODO should also validate state if strong requirements are met
init: guard-M_RESOURCES guard-M_SHARED setup ensure-state-file template-config-file initialize-state-file display-config-file

#plan method would get config file and environment state file and compare them and calculate what would be done o apply stage

#plan: guard-M_RESOURCES guard-M_SHARED setup validate-config validate-state template-tfvars module-plan terraform-plan

#apply method runs module provider logic using config file

apply: guard-M_RESOURCES guard-M_SHARED apply-shell
#apply: guard-M_RESOURCES guard-M_SHARED setup module-plan terraform-apply update-state-after-apply terraform-output

#audit method should call logic to check if remote components are in "known" state
#TODO implement validation if remote resources are as expected, possibly with terraform plan

#audit:
	#k8sprom | audit | should output current state of remote components

#destroy: template-tfvars terraform-destroy update-state-after-destroy

#plan-destroy: template-tfvars terraform-plan-destroy

#output: terraform-output

setup: $(M_SHARED)/$(M_MODULE_SHORT)
	#k8sprom | setup | ensure required directories

ensure-state-file: $(M_SHARED)/$(M_STATE_FILE_NAME)
	#k8sprom | ensure-state-file | checks if state file exists

template-config-file:
	#k8sprom | template-config-file | will template config file (and backup previous if exists)
	@if test -f $(M_SHARED)/$(M_MODULE_SHORT)/$(M_CONFIG_NAME); then mv $(M_SHARED)/$(M_MODULE_SHORT)/$(M_CONFIG_NAME) $(M_SHARED)/$(M_MODULE_SHORT)/$(M_CONFIG_NAME).backup ; fi
	@echo "$$M_CONFIG_CONTENT" > $(M_SHARED)/$(M_MODULE_SHORT)/$(M_CONFIG_NAME)

display-config-file:
	#k8sprom | display-config-file | config file content is:
	@cat $(M_SHARED)/$(M_MODULE_SHORT)/$(M_CONFIG_NAME)

initialize-state-file:
	#k8sprom | initialize-state-file | will initialize state file
	@echo "$$M_STATE_INITIAL" > $(M_SHARED)/$(M_MODULE_SHORT)/k8sprom-state.tmp
	@yq m -i -x $(M_SHARED)/$(M_STATE_FILE_NAME) $(M_SHARED)/$(M_MODULE_SHORT)/k8sprom-state.tmp
	@rm $(M_SHARED)/$(M_MODULE_SHORT)/k8sprom-state.tmp

apply-shell: 
	$(M_RESOURCES)/install.sh "$(M_SHARED)/$(M_KUBECONFIG_PATH)"

guard-%:
	@if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi

$(M_SHARED)/$(M_STATE_FILE_NAME):
	@mkdir -p $(dir $@)
	@touch $@

$(M_SHARED)/$(M_MODULE_SHORT):
	@mkdir -p $@