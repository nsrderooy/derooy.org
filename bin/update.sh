#!/usr/bin/env bash

set -euo pipefail
# Remove hash to enable debug
# set -euox pipefail

if [ -f ./.git/config ]
then
  gitRoot=$(git rev-parse --show-toplevel)
else
  gitRoot=./
fi

if [ -f "${gitRoot}/pip_requirements.txt" ]
then
  sudo -k
  . venv/bin/activate
  sed -i s/==.*//g "${gitRoot}/pip_requirements.txt"
  python3 -m pip install -U pip
  python3 -m pip install -U -r "${gitRoot}/pip_requirements.txt" && \
  python3 -m pip freeze > "${gitRoot}/pip_requirements.txt"
fi

