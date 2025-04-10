#!/usr/bin/env bash

# OPENHANDS_INSTANCE_ID が未設定または空なら1を設定
if [ -z "$OPENHANDS_INSTANCE_ID" ]; then
  OPENHANDS_INSTANCE_ID=1
fi

# 数値でなければエラー終了
if ! [[ "$OPENHANDS_INSTANCE_ID" =~ ^[0-9]+$ ]]; then
  echo "Error: OPENHANDS_INSTANCE_ID must be an integer." >&2
  exit 1
fi

CONTAINER_IMAGE=docker.all-hands.dev/all-hands-ai/openhands:0.32
SANDBOX_RUNTIME_CONTAINER_IMAGE=docker.all-hands.dev/all-hands-ai/runtime:0.32-nikolaik
VOLUME=~/openhands-$OPENHANDS_INSTANCE_ID

# setup env
BASE_PORT=3000

# 公開ポートを3000からはじめて、インスタンスIDから決定する
EXPOSE_PORT=$((BASE_PORT + OPENHANDS_INSTANCE_ID - 1))

# setup config dir
sudo mkdir -p $VOLUME
sudo chmod 777 $VOLUME

sudo docker run -it \
    --rm \
    --pull=always \
    -e LLM_NUM_RETRIES=10 \
    -e LLM_RETRY_MIN_WAIT=2 \
    -e LLM_RETRY_MAX_WAIT=10 \
    -e LLM_RETRY_MULTIPLIER=4 \
    -e SANDBOX_RUNTIME_CONTAINER_IMAGE=${SANDBOX_RUNTIME_CONTAINER_IMAGE} \
    -e LOG_ALL_EVENTS=true \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v ${VOLUME}:/.openhands-state \
    -p ${EXPOSE_PORT}:3000 \
    --add-host host.docker.internal:host-gateway \
    --name openhands-app-${OPENHANDS_INSTANCE_ID} \
    ${CONTAINER_IMAGE}
