RELEASE_NAME ?= prometheus-operator
NAMESPACE    ?= monitoring

.PHONY: all
all: install upgrade delete clean-crd

.PHONY: install
install:
	helm install . -n $(RELEASE_NAME) --namespace $(NAMESPACE)

.PHONY: upgrade
upgrade:
	helm upgrade -f values.yaml $(RELEASE_NAME) .

.PHONY: delete
delete:
	@helm del --purge $(RELEASE_NAME)

.PHONY: clean-crd
clean-crd:
	@kubectl delete crd \
		alertmanagers.monitoring.coreos.com \
		podmonitors.monitoring.coreos.com \
		prometheuses.monitoring.coreos.com \
		prometheusrules.monitoring.coreos.com \
		servicemonitors.monitoring.coreos.com
