#!/bin/sh

SCRIPT_DIR_PATH=$(cd "$(dirname "$0")" || exit; pwd)

docker build -t pmuens/biostar:latest "$SCRIPT_DIR_PATH"/..
