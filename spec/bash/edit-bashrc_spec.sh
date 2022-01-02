#shellcheck shell=bash

Describe 'edit-bashrc'
	Skip if "command not supported on shells other than bash" [ "${SHELL_TYPE}" != "bash" ]

	Include "${NUMONIC_HOME}"/sh/profile
	Include "${NUMONIC_HOME}"/bash/bashrc

	Describe 'when user bashrc file exists'
		It 'opens an editor to the file'
			When run with_fake_editor edit-bashrc
			The status should be success
			The output should eq ''

			The path bashrc should be readable
			The path bashrc should be writable
			The path bashrc should be executable
		End
	End

	Describe 'when user bashrc does not exist'
		It 'creates the file and opens an editor to the file'
			When run with_fake_editor edit-bashrc
			The status should be success
			The output should eq ''

			The path bashrc should be readable
			The path bashrc should be writable
			The path bashrc should be executable
		End
	End
End

# test_cmd="edit-bashrc"
# final=0

# assert_tmp=$(mktemp)

# cat << 'EOF' > "${assert_tmp}"
# #! /usr/bin/env sh
# set -e
# actual="${1}"
# expected="${HOME}/.local/share/bashrc"
# [ "${actual:-}" = "${expected}" ]
# EOF

# chmod +x "${assert_tmp}"

# if [ -f "${NUMONIC_SHARE}/bashrc" ]; then
# 	mv "${NUMONIC_SHARE}/bashrc" "${NUMONIC_SHARE}/bashrc_test_backup"
# fi

# test_editor="${EDITOR}"
# EDITOR="${assert_tmp}"

# ###
# test_name="with_existing"
# print-success "${test_cmd}: ${test_name}"

# ## arange
# expected=$(openssl rand -base64 12)
# printf '%s' "${expected}" > "${NUMONIC_SHARE}/bashrc"

# ## act
# if ! edit-bashrc; then
# 	print-fail "${test_cmd}: ${test_name} failed: exit code $?"
# 	final=1
# fi

# ## assert
# actual=$(cat "${NUMONIC_SHARE}/bashrc")

# if [ "${actual}" != "${expected}" ]; then
# 	print-fail "${test_cmd}: ${test_name} failed: expected ${expected}, got ${actual}"
# 	final=1
# fi

# ###
# test_name="with_not_existing"
# print-success "${test_cmd}: ${test_name}"

# ## arrange
# rm -f "${NUMONIC_SHARE}/bashrc"

# ## act
# if ! edit-bashrc; then
# 	print-fail "${test_cmd}: ${test_name} failed: exit code $?"
# 	final=1
# fi

# ## assert
# if [ ! -f "${NUMONIC_SHARE}/bashrc" ]; then
# 	print-fail "${test_cmd}: ${test_name} failed: file not created"
# 	final=1
# else
# 	expected="#! /usr/bin/env bash"
# 	actual=$(head -n 1 "${NUMONIC_SHARE}/bashrc")

# 	if [ "${actual}" != "${expected}" ]; then
# 		print-fail "${test_cmd}: ${test_name} failed: expected ${expected}, got ${actual}"
# 		final=1
# 	fi
# fi

# EDITOR="${test_editor}"

# exit "${final}"
