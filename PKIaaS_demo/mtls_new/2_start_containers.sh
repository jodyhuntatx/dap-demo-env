#!/bin/bash
set -eou pipefail
source ../env/pkiaas.env
source ../env/sandbox.env
source ./env/mtls-demo.conf

docker-compose up -d 
