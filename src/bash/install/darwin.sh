#! /usr/bin/env sh

set -e

__numonic_install_darwin() {
	if [ -n "${NUMONIC_NO_DEPENDENCIES:-}" ]; then
		print-warn "macOS: skipping installation of dependencies..."
		return 0
	fi

	brews='bash bash-completion@2'

	for pkg in ${brews}; do
		if brew list --versions "${pkg}" 1>/dev/null; then
			print-success "macOS: upgrading ${pkg}..."
			brew upgrade "${pkg}" 2>/dev/null || true
			brew link --overwrite "${pkg}" 2>/dev/null || true
		else
			print-success "macOS: installing ${pkg}..."
			brew install "${pkg}" || true
		fi
	done
}

__numonic_install_darwin
