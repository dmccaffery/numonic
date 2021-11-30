---
title: download-safe
---

# NAME

download-safe - downloads a file with support for retries

# SYNOPSIS

**download-safe** <*url*> [<*output*>] [<*attempts*>] [**-d** | **--debug**] [**-h** | **--help**] [**-q** | **--quiet**]

**download-safe** **-u** <*url*> [**-o** <*output*>] [**-a** <*attempts*>] [**-d** | **--debug**] [**-h** | **--help**] [**-q** | **--quiet**]

**download-safe** **--url=**<*url*> [**--output=**<*output*>] [**--attempts=**<*attempts*>] [**-d** | **--debug**] [**-h** | **--help**] [**-q** | **--quiet**]

# DESCRIPTION

This command downloads a file from the specified <*url*> and outputs it to the specified <*output*>. If the request
returns a 404 (NOT FOUND), then the command will fail. Any status code that is intermittent will be retried up to the
specified attempts.

If attempts are not specified, then the request will be retried 3 times.

If the output is not specified, then the output will be based on the name of the file in the URL and will be output to
the current working directory.

**curl**(1) is used to perform the downloads regardless of whether or not **wget**(1) is available.

# OPTIONS

## FLAGS

### -d, --debug

print the commands as they are executed (set -x)

### -h, --help

print this help information

### -q, --quiet

suppress any output to stdout (any errors will still be printed)

## ARGUMENTS

### \<url\>, -u \<url\>, --url=\<url\>

the url that should be downloaded

### \<output\>, -o \<output\>, --output=\<output\>

the path where the downloaded file should be output
if the path is not specified, the filename will be derived from the url of the request, which is the value of the last
path segment after removing any querystring or anchor elements

### \<attempts\>, -a \<attempts\>, --attempts=\<attempts\>

the number of times to retry the request in the event of an intermittent error (409, 502, 503, 504)

# EXAMPLES

## download-safe https://httpstat.us/200
## download-safe -u https://httpstat.us/200
## download-safe --url https://httpstat.us/200

download a file from the specified url into the current path named `200`

## download-safe https://httpstat.us/200 test.txt
## download-safe -u https://httpstat.us/200 -o test.txt
## download-safe --url=https://httpstat.us/200 --output=test.txt

download a file from the specified url into the current path named `test.txt`

# SEE ALSO

**curl**(1)
