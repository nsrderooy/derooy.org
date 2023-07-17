#!/usr/bin/env bash

set -euo pipefail
# Remove hash to enable debug
# set -euox pipefail

while read -r javaScriptFile
do
  cat <<EOF
  <script src="$(sed s/\.\\/docs\\///g <<< "${javaScriptFile}")">
    integrity="sha384-$(openssl dgst -sha384 -binary < "${javaScriptFile}" | openssl base64 -A)"
      crossorigin="anonymous">
EOF
done <<< "$(find ./docs/ -name \*.js)"
