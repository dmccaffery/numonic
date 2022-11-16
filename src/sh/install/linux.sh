#! /usr/bin/env sh

set -e

__numonic_install_linux_fonts() {
	print-success "linux: installing/upgrading nerd font..."

	font_dir="${NUMONIC_SHARE}/fonts/NerdFonts"
	temp_dir=$(mktemp -d)

	# download fonts
	curl --fail \
		--silent \
		--show-error \
		--location \
		--output "${temp_dir}"/nerd-font.zip \
		https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip

	# determine if nerd font already exists
	if [ -d "${font_dir}" ]; then

		# delete nerd font
		rm -rf "${font_dir}" 1>/dev/null 2>&1
	fi

	# make sure the font dir exists
	mkdir -p "${font_dir}" 1>/dev/null

	# extract nerd font
	unzip "${temp_dir}"/nerd-font.zip '*.ttf' -x '*Windows*' -d "${font_dir}" 1>/dev/null

	# remove temp
	rm -rf "${temp_dir}" 1>/dev/null 2>&1
}

# do not install fonts when there is no tty or this is an ssh session
if [ -z "${SSH_CLIENT:-}" ] || [ ! -t 1 ]; then
	__numonic_install_linux_fonts
fi
