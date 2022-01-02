#! /usr/bin/env sh

set -e

shell_name=${1:-'bash'}

./install.sh "${shell_name}"

SHELL=${shell_name}

if [ -f /opt/homebrew/bin/"${shell_name}" ]; then
	SHELL=/opt/homebrew/bin/${shell_name}
elif [ -f /usr/local/bin/"${shell_name}" ]; then
	SHELL=/usr/local/bin/${shell_name}
elif ! command -v "${shell_name}" 1>/dev/null 2>&1; then
	printf 'install: shell not on PATH: %s\n' "${shell_name}"
	exit 1
fi

# smoke test the shell
# shellcheck disable=SC2016
exec "${SHELL}" -lc 'cat ${NUMONIC_HOME}/.sha'
