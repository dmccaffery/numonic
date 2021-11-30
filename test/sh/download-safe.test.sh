#! /usr/bin/env sh

test_cmd="download-safe"

final=0

###
test_name="with_url_missing"
print-success "${test_cmd}: ${test_name}"

## arrange
url=

## act
if download-safe --url="${url}"; then
	print-fail "${test_cmd}: ${test_name} failed: request should not have succeeded"
	final=1
fi

###
test_name="with_url"
print-success "${test_cmd}: ${test_name}"

## arrange
url="https://httpstat.us/200"

## act
rm -f "200" 2>/dev/null || true
if ! download-safe "${url}"; then
	print-fail "${test_cmd}: ${test_name} failed: request should have succeeded"
	final=1
fi

rm -f "200" 2>/dev/null || true
if ! download-safe -u "${url}"; then
	print-fail "${test_cmd}: ${test_name} failed: request should have succeeded"
	final=1
fi

rm -f "200" 2>/dev/null || true
if ! download-safe --url="${url}"; then
	print-fail "${test_cmd}: ${test_name} failed: request should have succeeded"
	final=1
fi

###
test_name="with_url_including_querystring"
print-success "${test_cmd}: ${test_name}"

## arrange
url="https://httpstat.us/200?something=else"
rm -f "200" 2>/dev/null || true

## act
if ! download-safe "${url}"; then
	print-fail "${test_cmd}: ${test_name} failed: request should have succeeded"
	final=1
fi

if [ ! -f "200" ]; then
	print-fail "${test_cmd}: ${test_name} failed: file should have been created without query string"
	final=1
fi

###
test_name="with_url_including_anchor"
print-success "${test_cmd}: ${test_name}"

## arrange
url="https://httpstat.us/200#something"
rm -f "200" 2>/dev/null || true

## act
if ! download-safe "${url}"; then
	print-fail "${test_cmd}: ${test_name} failed: request should have succeeded"
	final=1
fi

if [ ! -f "200" ]; then
	print-fail "${test_cmd}: ${test_name} failed: file should have been created without anchor"
	final=1
fi

###
test_name="with_output"
print-success "${test_cmd}: ${test_name}"

## arrange
url="https://httpstat.us/200"

## act
output=$(openssl rand -base64 12)
if ! download-safe "${url}" "${output}"; then
	print-fail "${test_cmd}: ${test_name} failed: request should have succeeded"
	final=1
fi

if [ ! -f "${output}" ]; then
	print-fail "${test_cmd}: ${test_name} failed: file should have been created at ${output}"
	final=1
fi

output=$(openssl rand -base64 12)
if ! download-safe -u "${url}" -o "${output}"; then
	print-fail "${test_cmd}: ${test_name} failed: request should have succeeded"
	final=1
fi

if [ ! -f "${output}" ]; then
	print-fail "${test_cmd}: ${test_name} failed: file should have been created at ${output}"
	final=1
fi

output=$(openssl rand -base64 12)
if ! download-safe --url="${url}" --output="${output}"; then
	print-fail "${test_cmd}: ${test_name} failed: request should have succeeded"
	final=1
fi

if [ ! -f "${output}" ]; then
	print-fail "${test_cmd}: ${test_name} failed: file should have been created at ${output}"
	final=1
fi

###
test_name="with_retriable_error"
print-success "${test_cmd}: ${test_name}"

## arrange
url="https://httpstat.us/502"

## act
if download-safe "${url}" --quiet 1>stdout 2>stderr; then
	print-fail "${test_cmd}: ${test_name} failed: request should not have succeeded"
	final=1
fi

if [ -s stdout ] || [ ! -s stderr ]; then
	print-fail "${test_cmd}: ${test_name} failed: stdout should be empty; stderr should not"
	final=1
fi

if ! grep "3 attempts" stderr; then
	print-fail "${test_cmd}: ${test_name} failed: request should have been retried 3 times"
fi

###
test_name="with_non_retriable_error"
print-success "${test_cmd}: ${test_name}"

## arrange
url="https://httpstat.us/500"

## act
if download-safe "${url}" --quiet 1>stdout 2>stderr; then
	print-fail "${test_cmd}: ${test_name} failed: request should not have succeeded"
	final=1
fi

if [ -s stdout ] || [ ! -s stderr ]; then
	print-fail "${test_cmd}: ${test_name} failed: stdout should be empty; stderr should not"
	final=1
fi

if grep "2 attempts" stderr; then
	print-fail "${test_cmd}: ${test_name} failed: request should not have been retried"
fi

###
test_name="with_attempts"
print-success "${test_cmd}: ${test_name}"

## arrange
url="https://httpstat.us/502"
attempts=2

## act
if download-safe "${url}" -a ${attempts} --quiet 1>stdout 2>stderr; then
	print-fail "${test_cmd}: ${test_name} failed: request should not have succeeded"
	final=1
fi

if [ -s stdout ] || [ ! -s stderr ]; then
	print-fail "${test_cmd}: ${test_name} failed: stdout should be empty; stderr should not"
	final=1
fi

if ! grep "2 attempts" stderr; then
	print-fail "${test_cmd}: ${test_name} failed: request should have been retried twice"
	final=1
fi

if grep "3 attempts" stderr; then
	print-fail "${test_cmd}: ${test_name} failed: request should not have been retried 3 times"
	final=1
fi

if download-safe "${url}" --attempts ${attempts} --quiet 1>stdout 2>stderr; then
	print-fail "${test_cmd}: ${test_name} failed: request should not have succeeded"
	final=1
fi

if [ -s stdout ] || [ ! -s stderr ]; then
	print-fail "${test_cmd}: ${test_name} failed: stdout should be empty; stderr should not"
	final=1
fi

if ! grep "2 attempts" stderr; then
	print-fail "${test_cmd}: ${test_name} failed: request should have been retried twice"
	final=1
fi

if grep "3 attempts" stderr; then
	print-fail "${test_cmd}: ${test_name} failed: request should not have been retried 3 times"
	final=1
fi

###
test_name="with_help"
print-success "${test_cmd}: ${test_name}"

## act
if ! download-safe --help; then
	print-fail "${test_cmd}: ${test_name} failed: exit code $?"
	final=1
fi

###
test_name="with_quiet_success"
print-success "${test_cmd}: ${test_name}"

## arrange
url="https://httpstat.us/200"
rm -f "200" 2>/dev/null || true

## act
if ! download-safe "${url}" --quiet 1>stdout 2>stderr; then
	print-fail "${test_cmd}: ${test_name} failed: request should have succeeded"
	final=1
fi

if [ -s stdout ] || [ -s stderr ]; then
	print-fail "${test_cmd}: ${test_name} failed: stdout/stderr should be empty"
	final=1
fi

###
test_name="with_quiet_failure"
print-success "${test_cmd}: ${test_name}"

## arrange
url="https://httpstat.us/404"

## act
if download-safe "${url}" --quiet 1>stdout 2>stderr; then
	print-fail "${test_cmd}: ${test_name} failed: request should not have succeeded"
	final=1
fi

if [ -s stdout ] || [ ! -s stderr ]; then
	print-fail "${test_cmd}: ${test_name} failed: stdout should be empty; stderr should not"
	final=1
fi

exit ${final}
