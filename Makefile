variants=$(wildcard Polyform-*.md)
targets=$(addprefix build/,$(variants))

TAG:=$(or $(TAG),$(shell (git diff-index --quiet HEAD && git describe --exact-match --tags 2>/dev/null)))
VERSION:=$(if $(TAG),$(shell echo $(TAG) | sed 's/v//'),Development Draft)
REPO=https://github.com/polyformproject/polyform-licenses/
OFFICIAL=https://polyformproject.org/licenses

all: $(targets)

build/Polyform-%.md: Polyform-%.md | build
	cat $< \
	| fmt -65 -u \
	| sed "s!{{{version}}}!$(VERSION)!" \
	| sed "s!{{{url}}}!<$(if $(TAG),$(OFFICIAL)/$(shell echo $* | tr A-Z a-z | sed s/polyform-//)/$(TAG),$(REPO))>!" \
	> $@

build:
	mkdir -p $@

.PHONY: clean

clean:
	rm -rf build
