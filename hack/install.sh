#! /usr/bin/env sh

set -e

SHELL_NAME=${1:-'bash'}

./install.sh "${SHELL_NAME}"

SHELL=${SHELL_NAME}

if [ -f /opt/homebrew/bin/"${SHELL_NAME}" ]; then
	SHELL=/opt/homebrew/bin/${SHELL_NAME}
elif [ -f /usr/local/bin/"${SHELL_NAME}" ]; then
	SHELL=/usr/local/bin/${SHELL_NAME}
elif ! command -v "${SHELL_NAME}" 1>/dev/null 2>&1; then
	printf 'install: shell not on PATH: %s\n' "${SHELL_NAME}"
	exit 1
fi

# smoke test the shell
# shellcheck disable=SC2016
exec "${SHELL}" -lc 'cat ${NUMONIC_HOME}/.sha'
