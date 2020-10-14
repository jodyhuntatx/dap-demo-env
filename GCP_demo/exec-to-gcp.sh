#!/bin/bash

source conjur_setup/gcp.config

ssh -i $GCP_SSH_KEY $LOGIN_USER@$GCP_PUB_IP
