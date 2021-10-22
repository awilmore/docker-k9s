#!/bin/bash

set -e

docker buildx build -t awilmore/k9s:latest . --load
