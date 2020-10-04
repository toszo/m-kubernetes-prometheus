define M_METADATA_CONTENT
labels:
  version: $(M_VERSION)
  name: Prometheus Operator
  short: $(M_MODULE_SHORT)
  kind: infrastructure
  provider: any
endef

define M_CONFIG_CONTENT
kind: $(M_MODULE_SHORT)-config
$(M_MODULE_SHORT):
  name: $(M_NAME)
  kubeconfig_path: "$(M_SHARED)/$(M_KUBECONFIG_PATH)"
endef

define M_STATE_INITIAL
kind: state
$(M_MODULE_SHORT):
  status: initialized
endef
