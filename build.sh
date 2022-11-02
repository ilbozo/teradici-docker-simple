#!/bin/bash
set -ex
docker build --progress plain \
    -t pcoip-client \
    .
