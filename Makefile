#!/usr/bin/make -f

# Quantal is broken
RELEASES = precise trusty
IMAGES = $(foreach release,$(RELEASES),$(release)-desktop-i386 $(release)-desktop-amd64)
BOXES = $(foreach image,$(IMAGES),$(image).box)

.PHONY: all
all: $(BOXES)

.PHONY: $(BOXES)
.NOTPARALLEL: $(BOXES)
$(BOXES): %.box:
	vagrant up $*
	vagrant package $* --output $*.box
	vagrant destroy --force $*

.PHONY: clean
clean:
	vagrant destroy --force
	rm -f *.box
