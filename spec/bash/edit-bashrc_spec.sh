#shellcheck shell=bash

Describe 'edit-bashrc'
	Skip if "command not supported on shells other than bash" is_not_bash

	Describe 'when user bashrc file exists'
		It 'opens an editor to the file'
			touch "${NUMONIC_SHARE}"/bashrc

			When run with_fake_editor edit-bashrc
			The status should be success
			The output should start with 'EDITOR: fake_editor'

			The path "${NUMONIC_SHARE}"/bashrc should be readable
			The path "${NUMONIC_SHARE}"/bashrc should be writable
			The path "${NUMONIC_SHARE}"/bashrc should be executable
		End
	End

	Describe 'when user bashrc does not exist'
		It 'creates the file and opens an editor to the file'
			When run with_fake_editor edit-bashrc
			The status should be success
			The output should start with 'EDITOR: fake_editor'

			The path "${NUMONIC_SHARE}"/bashrc should be readable
			The path "${NUMONIC_SHARE}"/bashrc should be writable
			The path "${NUMONIC_SHARE}"/bashrc should be executable
		End
	End

	Describe 'when requesting help'
		Parameters
			"--help"
			"-h"
		End

		It "prints man page with ${1}"
			When run with_fake_editor edit-bashrc "${1}"
			The status should be success
			The output should start with 'EDIT-BASHRC(1)'
		End
	End

	Describe 'when enabling debug'
		Parameters
			"--debug"
			"-d"
		End

		It "enables debug with ${1}"
			unset CLR_WARN

			When run with_fake_editor edit-bashrc "${1}"
			The status should be success
			The error should start with 'edit-bashrc: debug enabled'
			The output should start with 'EDITOR: fake_editor'
		End
	End
End
