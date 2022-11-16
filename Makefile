.PHONY: pr
pr: test docs

.PHONY: test
test:
	shellspec --format documentation

.PHONY: docs
docs:
	./hack/docs-generate.sh

.PHONY: install
install:
	./install-numonic --shell=zsh
