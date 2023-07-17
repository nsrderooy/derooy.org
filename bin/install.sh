#!/usr/bin/env bash

set -euo pipefail
# Remove hash to enable debug
# set -euox pipefail

requiredPackages=(
  imagemagick
  python3
  python3-pip
  python3-venv
)

if command -v nala > /dev/null
then
  packageInstaller=nala
else
  packageInstaller=apt
fi

if [ -f ./.git/config ]
then
  gitRoot=$(git rev-parse --show-toplevel)
else
  gitRoot=./
fi

unset packagesToInstall

for requiredPackage in "${requiredPackages[@]:-}"
do
  if [ -n "$(apt list --installed "${requiredPackage}" 1> /dev/null 2> /dev/null)" ]
  then
    packagesToInstall+=("${requiredPackage}")
  fi
done

if [ -n "${packagesToInstall[0]:-}" ]
then
  if [ "${packageInstaller}" == 'apt' ]
  then
    sudo apt update
  fi
  sudo "${packageInstaller}" install "${packagesToInstall[@]}"
fi

if [ -f "${gitRoot}/pip_requirements.txt" ]
then
  sudo -k
  python3 -m venv venv/
  . venv/bin/activate
  python3 -m pip install -U pip
  python3 -m pip install -r "${gitRoot}/pip_requirements.txt"
fi
