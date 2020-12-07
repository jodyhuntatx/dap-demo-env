#!/bin/bash

export CONJUR_APPLIANCE_URL=https://conjur-master-mac
export CONJUR_AUTHN_LOGIN=admin
export CONJUR_ADMIN_PASSWORD=$(sudo keyring get conjur adminpwd);
export CONJUR_CERT_FILE=$MASTER_CERT_FILE
export CONJUR_ACCOUNT=dev

./load-policy.rb client policy.yaml
