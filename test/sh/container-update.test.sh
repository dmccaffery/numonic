#! /usr/bin/env sh

test_cmd="container-update"

if [ -n "${NUMONIC_CONTAINER:-}" ]; then
	print-warn "${test_cmd}: skipping tests in containers as container runtimes are not supported within containers"
	exit 0
fi

# nerdctl
install-containerd --force --quiet

# docker
install-docker --force --quiet

# podman
install-podman --force --quiet

# setup the runtimes and image
runtimes="docker nerdctl podman"
repository="docker.io/library/busybox"
final=0

###
test_name="with_old"
for cmd in ${runtimes}; do
	"${cmd}" pull "${repository}:1.34.0"
	original=$("${cmd}" image inspect --format '{{.ID}}' "${repository}:1.34.0")

	"${cmd}" tag "${repository}:1.34.0" "${repository}:latest"
	"${cmd}" image rm "${repository}:1.34.0"

	if ! container-update; then
		print-fail "${test_cmd}: ${test_name} failed: container-update failed in ${cmd}."
		final=1
	fi

	actual="$("${cmd}" image inspect --format '{{.ID}}' "${repository}:latest")"

	if [ "${original}" = "${actual}" ]; then
		print-fail "${test_cmd}: ${test_name} failed: image for ${repository}:latest was not updated in ${cmd}."
		final=1
	fi
done

###
test_name="with_current"
for cmd in ${runtimes}; do
	"${cmd}" pull "${repository}:latest"
	original=$("${cmd}" image inspect --format '{{.ID}}' "${repository}:latest")

	if ! container-update; then
		print-fail "${test_cmd}: ${test_name} failed: container-update failed in ${cmd}."
		final=1
	fi

	actual="$("${cmd}" image inspect --format '{{.ID}}' "${repository}:latest")"

	if [ "${original}" != "${actual}" ]; then
		print-fail "${test_cmd}: ${test_name} failed: image for ${repository}:latest was updated and should not have been in ${cmd}."
		final=1
	fi
done

exit ${final}
