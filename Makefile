variants=$(wildcard PolyForm-*.md)
targets=$(addprefix build/,$(variants))

all: $(targets)

build/PolyForm-%.md: PolyForm-%.md | build
	fmt -65 -u < $< > $@

pdf: $(addprefix build/,$(variants:.md=.pdf))

build/%.pdf: build/%.md | build
	pandoc -o $@ $<

docx: $(addprefix build/,$(variants:.md=.docx))

build/%.docx: build/%.md | build
	pandoc -o $@ $<

build:
	mkdir -p $@

.PHONY: clean

clean:
	rm -rf build
