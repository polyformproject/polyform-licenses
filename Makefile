variants=$(wildcard Polyform-*.md)
targets=$(addprefix build/,$(variants))

all: $(targets)

build/Polyform-%.md: Polyform-%.md | build
	fmt -65 -u < $< > $@

build:
	mkdir -p $@

.PHONY: clean

clean:
	rm -rf build
