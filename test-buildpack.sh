#!/bin/bash
# test-buildpack.sh <app> <yml_config>

set -ex

if [ ! $# -eq 2 ]
  then
    echo "Usage: ./test-buildpack.sh <app> <yml_config>"
fi

APP=$1
CONFIG=$2

YQ="$(which yq)"
if [ -z $YQ ]; then
  echo "Downloading yq"
  curl -L https://github.com/mikefarah/yq/releases/download/2.4.0/yq_linux_amd64 -o yq
  chmod +x yq
  YQ="./yq"
fi

export JSON_CONFIG="$($YQ r $CONFIG -j)"
export VCAP_SERVICES="$(cf curl /v3/apps/$(cf app $APP --guid)/env | jq .system_env_json.VCAP_SERVICES)"
eval "$(./bin/map)" && env
