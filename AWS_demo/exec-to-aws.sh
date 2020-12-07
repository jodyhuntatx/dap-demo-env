#!/bin/bash

source conjur_setup/aws.config

ssh -i $AWS_SSH_KEY $LOGIN_USER@$AWS_PUB_DNS
