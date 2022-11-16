#! /usr/bin/env bash

set -e

__numonic_install_darwin_brew() {
	if [ -n "${NUMONIC_NO_DEPENDENCIES:-}" ]; then
		print-warn "macOS: skipping installation of dependencies..."
		return 0
	fi

	# determine if we are on x86
	if [ "$(uname -m)" = "x86_64" ]; then

		# install homebrew using defaults
		__numonic_install_darwin_intel

		# move on immediately
		return 0
	fi

	 # install homebrew for apple silicon
	__numonic_install_darwin_arm64
}

__numonic_install_darwin_intel() {
	print-success "macOS: installing homebrew for Intel (amd64)..."

	HOMEBREW_PREFIX="/usr/local"
	brew_cmd="${HOMEBREW_PREFIX}/bin/brew"

	if ! command -v ${brew_cmd} 1>/dev/null 2>&1; then
		print-success "installing homebrew..."
		/bin/bash -c "CI=true $(curl -fail --silent --show-error --location https://raw.githubusercontent.com/Homebrew/install/master/install.sh) && ${brew_cmd} config"
	fi

	__numonic_install_darwin "/usr/local/bin/brew"
}

__numonic_install_darwin_arm64() {
	print-success "macOS: installing homebrew for Apple Silicon (arm64e)..."

	HOMEBREW_PREFIX="/opt/homebrew"
	brew_cmd="${HOMEBREW_PREFIX}/bin/brew"

	if ! command -v ${brew_cmd} 1>/dev/null 2>&1; then
		print-success "installing homebrew..."
		/bin/bash -c "HOMEBREW_PREFIX=${HOMEBREW_PREFIX} CI=true $(curl --fail --silent --show-error --location https://raw.githubusercontent.com/Homebrew/install/master/install.sh) && ${brew_cmd} config"
	fi

	__numonic_install_darwin "arch -arm64e /opt/homebrew/bin/brew"
}

__numonic_install_darwin() {
	print-success "macOS: installing homebrew packages..."

	brews='git gpg pinentry-mac jq'
	brew_cmd=${1:-"/usr/local/bin/brew"}

	# load the shell env for the current brew
	eval "$(${brew_cmd} shellenv)"

	# disable brew analytics
	${brew_cmd} analytics off

	print-success "macOS: updating homebrew..."
	${brew_cmd} update

	for pkg in ${brews}; do
		if ${brew_cmd} list --versions "${pkg}" 1>/dev/null; then
			print-success "macOS: upgrading ${pkg}..."
			${brew_cmd} upgrade "${pkg}" 2>/dev/null || true
			${brew_cmd} link --overwrite "${pkg}" 2>/dev/null || true
		else
			print-success "macOS: installing ${pkg}..."
			${brew_cmd} install "${pkg}" || true
		fi
	done
}

__numonic_install_darwin_fonts() {
	print-success "macOS: installing/upgrading nerd font..."

	# setup the font dir
	font_dir="${HOME}/Library/Fonts/NerdFonts"

	# create a temp dir for fonts
	temp_dir=$(mktemp -d)

	# download fonts
	curl --fail \
		--silent \
		--show-error \
		--location \
		--output "${temp_dir}/nerd-font.zip" \
		https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip

	# determine if nerd already exists
	if [ -d "${font_dir}" ]; then

		# delete nerd font
		rm -rf "${font_dir}" 1>/dev/null 2>&1
	fi

	# ensure the nerd font directory
	mkdir -p "${font_dir}" 1>/dev/null 2>&1

	# extract nerd font
	unzip "${temp_dir}/nerd-font.zip" '*.ttf' -x '*Windows*' -d "${font_dir}" 1>/dev/null

	# remove temp
	rm -rf "${temp_dir}" 1>/dev/null 2>&1
}

__numonic_install_darwin_brew

# do not install fonts when there is no tty or this is an ssh session
if [ -z "${SSH_CLIENT:-}" ] || [ ! -t 1 ]; then
	__numonic_install_darwin_fonts
fi
