#! /usr/bin/env sh

set -e

__numonic_install_centos() {
	if [ -n "${NUMONIC_NO_DEPENDENCIES:-}" ]; then
		print-warn "centos: skipping installation of dependencies..."
		return 0
	fi

	sudo_cmd=$(command -v sudo || printf '')
	yum_cmd=$(command -v dnf || command -v yum)
	packages='zsh'

	print-success "centos: installing ${packages}..."
	# shellcheck disable=SC2086
	"${sudo_cmd}" "${yum_cmd}" install -y ${packages}
}

__numonic_install_centos
