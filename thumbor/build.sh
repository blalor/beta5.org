#!/bin/bash
set -e -u -o pipefail

basedir="$( cd "$( dirname "${0}" )" && pwd )"

dist_dir="${basedir}/dist"
mkdir "${dist_dir}"

export VIRTUAL_ENV_DISABLE_PROMPT=true

venv=$( mktemp -d )
python -m venv "${venv}"

# shellcheck disable=SC1090
. "${venv}/bin/activate"
target_dir=$( python -c 'import sys; print(sys.path[-1])' ) # -> ${VIRTUAL_ENV}/lib/python2.7/site-packages

pip_install=(
    pip
    --disable-pip-version-check
    # --quiet
    install
)

"${pip_install[@]}" --upgrade pip wheel

"${pip_install[@]}" -r "${basedir}/requirements.txt"

## replace thumbor config with our own
target_conf=$( python -c 'import pkg_resources; print(pkg_resources.resource_filename("image_handler", "thumbor.conf"))' )
cp -f "${basedir}/thumbor.conf" "${target_conf}"

deactivate

pushd "${target_dir}"
zip -qr9 "${dist_dir}/image-handler.zip" .
