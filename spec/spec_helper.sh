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
	NUMONIC_BIN="${test_home}"/local/bin

	mkdir -p "${NUMONIC_SHARE}"
	mkdir -p "${NUMONIC_BIN}"

	setenv NUMONIC_HOME="${NUMONIC_HOME}"
	setenv NUMONIC_LOCAL="${NUMONIC_LOCAL}"
	setenv NUMONIC_SHARE="${NUMONIC_SHARE}"
	setenv NUMONIC_BIN="${NUMONIC_BIN}"

	setenv SHELL_TYPE="${SHELL_TYPE}"
}

# This callback function will be invoked after a specfile has been loaded.
spec_helper_loaded() {
	:
}

# This callback function will be invoked after core modules has been loaded.
spec_helper_configure() {
	with_fake_editor() {
		echo "PATH: ${PATH}"
		EDITOR=fake_editor "$@"
	}
}
