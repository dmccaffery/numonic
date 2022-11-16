# shellcheck shell=sh

# Defining variables and functions here will affect all specfiles.
# Change shell options inside a function may cause different behavior,
# so it is better to set them here.
# set -eu

test_home=$(mktemp -d)

# This callback function will be invoked only once before loading specfiles.
spec_helper_precheck() {
	# Available functions: info, warn, error, abort, setenv, unsetenv
	# Available variables: VERSION, SHELL_TYPE, SHELL_VERSION
	: minimum_version "0.28.1"

	NUMONIC_HOME="${PWD}"/src
	NUMONIC_LOCAL="${test_home}"/local
	NUMONIC_SHARE="${test_home}"/local/share
	NUMONIC_BIN="${NUMONIC_HOME}"/"${SHELL_TYPE}"/scripts
	NUMONIC_SH_BIN="${NUMONIC_HOME}"/sh/scripts

	mkdir -p "${NUMONIC_SHARE}"
	mkdir -p "${NUMONIC_BIN}"

	setenv NUMONIC_HOME="${NUMONIC_HOME}"
	setenv NUMONIC_LOCAL="${NUMONIC_LOCAL}"
	setenv NUMONIC_SHARE="${NUMONIC_SHARE}"
	setenv NUMONIC_BIN="${NUMONIC_BIN}"

	setenv SHELL_TYPE="${SHELL_TYPE}"
	setenv PATH="${NUMONIC_BIN}":"${NUMONIC_SH_BIN}":/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin
	setenv MANPATH="${NUMONIC_HOME}"/man
}

# This callback function will be invoked after core modules has been loaded.
spec_helper_configure() {
	with_fake_editor() {
		EDITOR=fake_editor "$@"
	}

	is_bash() {
		test "${SHELL_TYPE}" = "bash"
	}

	is_not_bash() {
		test "${SHELL_TYPE}" != "bash"
	}
}
