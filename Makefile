Q ?= @
names := $(patsubst Dockerfile.%,%,$(wildcard Dockerfile.*))

all: build

help:
	@echo "make [all | build | status | clean $(names:%=| build-%) $(names:%=| status-%) $(names:%=| clean-%)]"

build: $(names:%=build-%)
.%.stamp: Dockerfile.%
	$Q docker build -t $(@:.%.stamp=%)-dpdk -f $^ . && touch $@

status: $(names:%=status-%)
status-%:
	$Q docker image ls "$(@:status-%=%-dpdk)" | sed -n 2p

clean: $(names:%=clean-%)
clean-%:
	$(RM) $(@:clean-%=.%.stamp)
	docker image rm $(@:clean-%=%-dpdk)

.PHONY: all help build status clean

define gen-stamp-dependency
build-$(1): .$(1).stamp
status-$(1):
clean-$(1):
endef
$(foreach name,$(names),$(eval $(call gen-stamp-dependency,$(name))))
