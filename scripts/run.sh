#!/bin/sh

SCRIPT_DIR_PATH=$(cd "$(dirname "$0")" || exit; pwd)

docker run -it --rm --name biostar \
  -v "$SCRIPT_DIR_PATH"/..:/mnt/data \
  --entrypoint /bin/bash \
  --workdir /mnt/data \
  pmuens/biostar:latest
