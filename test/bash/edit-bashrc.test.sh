#! /usr/bin/env bash

test_cmd="edit-bashrc"
final=0

assert_tmp=$(mktemp)

cat << 'EOF' > "${assert_tmp}"
#! /usr/bin/env sh
set -e
actual="${1}"
expected="${HOME}/.local/share/bashrc"
[ "${actual:-}" = "${expected}" ]
EOF

chmod +x "${assert_tmp}"

if [ -f "${NUMONIC_SHARE}/bashrc" ]; then
	mv "${NUMONIC_SHARE}/bashrc" "${NUMONIC_SHARE}/bashrc_test_backup"
fi

test_editor="${EDITOR}"
EDITOR="${assert_tmp}"

###
test_name="with_existing"
print-success "${test_cmd}: ${test_name}"

## arange
expected=$(openssl rand -base64 12)
printf '%s' "${expected}" > "${NUMONIC_SHARE}/bashrc"

## act
if ! edit-bashrc; then
	print-fail "${test_cmd}: ${test_name} failed: exit code $?"
	final=1
fi

## assert
actual=$(cat "${NUMONIC_SHARE}/bashrc")

if [ "${actual}" != "${expected}" ]; then
	print-fail "${test_cmd}: ${test_name} failed: expected ${expected}, got ${actual}"
	final=1
fi

###
test_name="with_not_existing"
print-success "${test_cmd}: ${test_name}"

## arrange
rm -f "${NUMONIC_SHARE}/bashrc"

## act
if ! edit-bashrc; then
	print-fail "${test_cmd}: ${test_name} failed: exit code $?"
	final=1
fi

## assert
if [ ! -f "${NUMONIC_SHARE}/bashrc" ]; then
	print-fail "${test_cmd}: ${test_name} failed: file not created"
	final=1
else
	expected="#! /usr/bin/env bash"
	actual=$(head -n 1 "${NUMONIC_SHARE}/bashrc")

	if [ "${actual}" != "${expected}" ]; then
		print-fail "${test_cmd}: ${test_name} failed: expected ${expected}, got ${actual}"
		final=1
	fi
fi

EDITOR="${test_editor}"

exit "${final}"
