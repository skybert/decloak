#! /usr/bin/env bash

## Unit tests for decloak.
##
## author: torstein, tkj@stibodx.com

set -o errexit
set -o nounset
set -o pipefail

cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

assert_equals() {
  [[ "${1}" == "${2}" ]]
}

test_basic_auth_in_http_header() {
  credentials=foo:bar
  input="Authorization: Basic $(printf "%s" "${credentials}" | base64 -)"
  actual=$("${cwd}"/decloak "${input}")
  expected=${credentials}
  assert_equals "${expected}" "${actual}"
}

test_uri_decode_http() {
  input='http://foo/bar=%2F'
  actual=$("${cwd}"/decloak "${input}")
  expected=http://foo/bar=/
  assert_equals "${expected}" "${actual}"
}

test_uri_decode_https() {
  input='https://foo/bar=%2F'
  actual=$("${cwd}"/decloak "${input}")
  expected=https://foo/bar=/
  assert_equals "${expected}" "${actual}"
}

test_basic_auth_as_argument() {
  credentials=foo:bar
  input=$(printf "%s" "${credentials}" | base64 -)
  actual=$("${cwd}"/decloak "${input}")
  expected=${credentials}
  assert_equals "${expected}" "${actual}"
}

test_basic_auth_as_pipe() {
  credentials=foo:bar
  input=$(printf "%s" "${credentials}" | base64 -)
  actual=$(printf "%s\\n" "${input}" | "${cwd}"/decloak)
  expected=${credentials}
  assert_equals "${expected}" "${actual}"
}

main() {
  declare -F |
    sed 's#declare -f##' |
    grep test_ |
    while read -r t; do
      if "${t}"; then
        echo -n .
      else
        echo -n E
      fi
    done
  echo
}

main "$@"
