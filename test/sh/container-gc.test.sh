#! /usr/bin/env sh

test_cmd="container-gc"

if [ -n "${NUMONIC_CONTAINER:-}" ]; then
	print-warn "${test_cmd}: skipping tests in containers as container runtimes are not supported within containers"
	exit 0
fi

# nerdctl
# TODO: nerdctl is purposefully not included as prune is not yet implemented
# install-containerd --force --quiet

# docker
install-docker --force --quiet

# podman
install-podman --force --quiet

# setup the runtimes and image
# TODO: nerdctl is purposefully not included as prune is not yet implemented
runtimes="docker podman"
image="docker.io/library/busybox:latest"
final=0

###
test_name="with_image"
for cmd in ${runtimes}; do
	"${cmd}" run "${image}" echo hello
	container-gc
	if "${cmd}" image list --all "${image}" | grep "${image}"; then
		print-fail "${test_cmd}: ${test_name} failed: image ${image} still exists in ${cmd}."
		final=1
	fi
done

###
test_name="with_container"
container_name=$(openssl rand -base64 12)

for cmd in ${runtimes}; do
	"${cmd}" run --name="${container_name}" "${image}" echo hello
	container-gc
	if "${cmd}" container list --all --filter=name="${container_name}" | grep "${container_name}"; then
		print-fail "${test_cmd}: ${test_name} failed: container with ${container_name} still exists in ${cmd}."
		final=1
	fi
done

###
test_name="with_volume"
for cmd in ${runtimes}; do
	volume_name=$("${cmd}" volume create --driver=local)
	"${cmd}" run --mount=type=volume,src="${volume_name}",target=/volumes/"${volume_name}" "${image}" echo hello
	container-gc
	if "${cmd}" volume list --filter=name="${volume_name}" | grep "${volume_name}"; then
		print-fail "${test_cmd}: ${test_name} failed: volume with ${volume_name} still exists in ${cmd}."
		final=1
	fi
done

exit ${final}
