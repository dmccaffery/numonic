#! /usr/bin/env sh

NUMONIC_HOME="${NUMONIC_HOME:-${HOME}/.local/numonic}"
SRCROOT="${PWD}/src"

printf 'NUMONIC HOME: %s\n' "${NUMONIC_HOME}"
printf 'SOURCE ROOT : %s\n' "${SRCROOT}"

rm -rf "${NUMONIC_HOME}"
mkdir -p "${NUMONIC_HOME}"

ln -Fs "${SRCROOT}/sh" "${NUMONIC_HOME}"
ln -Fs "${SRCROOT}"/zsh "${NUMONIC_HOME}"
ln -Fs "${SRCROOT}"/bash "${NUMONIC_HOME}"
ln -Fs "${SRCROOT}"/themes "${NUMONIC_HOME}"
ln -Fs "${SRCROOT}"/man "${NUMONIC_HOME}"

ls -la "${NUMONIC_HOME}"
