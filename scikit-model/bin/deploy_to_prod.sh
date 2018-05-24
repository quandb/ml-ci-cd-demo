#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
source ${current_directory}/common.sh
# exit_if_not_ci

VERSION_TO_DEPLOY_TO_PROD=$1

current_deployed_version=$(get_current_default_version_for ${MODEL_NAME})

echo "[INFO] Current deployed version is ${current_deployed_version}"
echo "[INFO] VERSION_TO_DEPLOY_TO_PROD=${VERSION_TO_DEPLOY_TO_PROD}"
echo "[INFO] Next version to be deployed will be ${VERSION_TO_DEPLOY_TO_PROD}"
gcloud ml-engine versions set-default ${VERSION_TO_DEPLOY_TO_PROD} --model=${MODEL_NAME}

echo "[INFO] Listing model(s) and default version name(s)"
gcloud ml-engine models list

${current_directory}/smoke_test.sh ${VERSION_TO_DEPLOY_TO_PROD}
