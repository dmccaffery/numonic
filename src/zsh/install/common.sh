#! /usr/bin/env sh

set -e

__numonic_configure_zsh() {
	print-success 'numonic: configuring completion...'

	# test to see if the zsh completion dir is specified
	if [ -n "${ZSH_COMPLETION_DIR:-}" ]; then

		# create the dir if it does not already exist
		if [ ! -d "${ZSH_COMPLETION_DIR}" ]; then
			mkdir -p "${ZSH_COMPLETION_DIR}"
		fi

		# set permissions on the script directory
		chmod -R u=rwx,go=rx "${ZSH_COMPLETION_DIR}"
	fi

	# remove any cached zsh completion
	rm -f "${HOME}"/.zcompdump* 1>/dev/null 2>&1 || true
}

__numonic_configure_zsh
