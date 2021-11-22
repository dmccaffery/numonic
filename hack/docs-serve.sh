#! /usr/bin/env sh

set -e

if command -v python3 1>/dev/null 2>&1; then
	python_cmd=python3
elif command -v python 1>/dev/null 2>&1; then
	python_cmd=python
else
	printf 'docs-site: python3 not available'
	exit 1
fi

${python_cmd} -m mkdocs serve --dirtyreload --config-file docs/mkdocs.yml
