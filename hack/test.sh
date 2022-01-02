#! /usr/bin/env sh

set -e

shells=
tests=

while :; do
	case $1 in
		-s|--shell)
			shells="${shells} ${2}"
			;;
		--shell=*)
			shells="${shells} ${1#*=}"
			;;
		-t|--test)
			tests="${tests} ${2}"
			shift
			;;
		--test=*)
			tests="${tests} ${1#*=}"
			;;
		?*)
			printf "\test: unknown argument: %s\n" "${1}"
			exit 1
			;;
		*)
			break
			;;
	esac
	shift
done

if [ -z "${shells:-}" ]; then
	shells="'*'"
fi

if [ -z "${tests:-}" ]; then
	tests="'*'"
fi

shells=${shells#*' ':-"'*'"}
tests=${tests#*' ':-"'*'"}

if [ -z "${CI:-}" ]; then
	test_home=$(mktemp -d)

	export NUMONIC_LOCAL="${test_home}"/local
	export NUMONIC_HOME="${PWD}"/src
fi

print-success '' \
	'test: setting up environment...' \
	"NUMONIC_LOCAL : ${NUMONIC_LOCAL}" \
	"NUMONIC_HOME  : ${NUMONIC_HOME}" \
	"shells        : ${shells}" \
	"tests         : ${tests}" \
''

set +e
final=0

(
	for shell in ${shells}; do
		if [ "${shell}" = "'*'" ]; then
			shell="*"
		fi

		for test in ${tests}; do
			if [ "${test}" = "'*'" ]; then
				test="*"
			fi

			for current in "${PWD}"/test/${shell}/${test}.test.sh; do
				if [ ! -f "${current}" ]; then
					continue
				fi

				shell=${current%/*}
				shell=${shell##*/}

				name=${current##*/}
				name=${name%.test.sh*}
				name="${shell}/${name}"

				if ! command -v "${shell}" 1>/dev/null 2>&1; then
					print-warn "test: skipping ${name} tests as the ${shell} shell is not available..."
					continue
				fi

				print-success "TEST: ${name} STARTING"

				temp=$(mktemp -d)

				(
					cd "${temp}" || exit 1
					TERM=dumb "${shell}" -lc "${current}" 1>stdout.test 2>stderr.test
				)

				exit_code=$?

				if [ ${exit_code} -ne 0 ]; then
					print-fail "TEST: ${name} FAILED: ${exit_code}"
					printf '\n'
					print-warn "$(cat "${temp}"/stderr.test)"
					final=1
				else
					print-success "TEST: ${name} PASSED"
				fi
				rm -rf "${temp}"
			done
		done
	done

	exit ${final}
)
