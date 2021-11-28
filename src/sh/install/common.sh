#! /usr/bin/env sh

set -e

__numonic_configure_gpg() {
	if ! command -v gpgconf 1>/dev/null 2>&1; then
		print-warn "numonic: skipping gpg configuration..."
	fi

	print-success "numonic: configuring gpg..."

	gpg_config_dir="$(gpgconf --list-dirs | grep ^homedir)"
	gpg_config_dir=${gpg_config_dir#*\:}

	# test for gpg config
	if [ ! -d "${gpg_config_dir}" ]; then

		# create the gpg config directory
		mkdir -p "${gpg_config_dir}"

		# set the permissions
		chmod u=rwx,go= "${gpg_config_dir}"

		# apply initial defaults
		gpgconf --apply-defaults 1>/dev/null 2>/dev/null || true
	fi
}

__numonic_configure_starship() {
	print-success "numonic: configuring starship..."
	curl --fail \
		--silent \
		--show-error \
		--location \
		https://starship.rs/install.sh | bash -s -- --force --bin-dir="${NUMONIC_BIN}" 1>/dev/null
}

print-success '' \
	'##############################################################################' \
	'CONFIGURING DEPENDENCIES' \
	'##############################################################################' \
''

__numonic_configure_gpg
__numonic_configure_starship
