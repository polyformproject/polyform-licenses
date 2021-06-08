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

.PHONY: clean diffs

clean:
	rm -rf build diffs

diffs:
	rm -rf diffs
	mkdir -p diffs
	for from in PolyForm-*.md; do \
		for to in PolyForm-*.md; do \
			[ "$$from" = "$$to" ] && continue; \
			fromstem="$${from#PolyForm-}"; \
			tostem="$${to#PolyForm-}"; \
			diff "$$from" "$$to" > "diffs/$${fromstem%-*.md} versus $${tostem%-*.md}.diff"; \
		done \
	done
