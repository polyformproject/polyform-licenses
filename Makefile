variants=$(wildcard Polyform-*.md)
targets=$(addprefix build/,$(variants))

all: $(targets)

build/Polyform-%.md: Polyform-%.md | build
	fmt -65 -u < $< > $@

pdfs: $(addprefix build/,$(variants:.md=.pdf))

build/%.pdf: build/%.md | build
	pandoc -o $@ $<

build:
	mkdir -p $@

.PHONY: clean

clean:
	rm -rf build
