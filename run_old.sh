#!/bin/bash
sudo docker run -it --rm --pull=always \
-e LLM_NUM_RETRIES=10 \
-e LLM_RETRY_MIN_WAIT=2 \
-e LLM_RETRY_MAX_WAIT=10 \
-e LLM_RETRY_MULTIPLIER=4 \
-e SANDBOX_RUNTIME_CONTAINER_IMAGE=docker.all-hands.dev/all-hands-ai/runtime:0.31-nikolaik \
-e LOG_ALL_EVENTS=true \
-v /var/run/docker.sock:/var/run/docker.sock \
-v ~/.openhands-state:/.openhands-state \
-p 3000:3000 \
--add-host host.docker.internal:host-gateway \
--name openhands-app \
docker.all-hands.dev/all-hands-ai/openhands:0.31
