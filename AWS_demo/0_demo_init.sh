#!/bin/bash
##########################################
##  This script executes on local host  ##
##    All others execute on AWS host    ##
##########################################

SETUP_DIR=./conjur_setup
DEMO_DIRS="./ruby ./python ./java"

# sync local & remote config files 
source $SETUP_DIR/aws.config

# Location of local Conjur appliance tarfile to copy to AWS
CONJUR_TARFILE_SOURCE_DIR=~/conjur-install-images

function main() {
  if [[ "$AWS_PUB_DNS" == "" ]]; then
    echo "Please edit $SETUP_DIR/aws.config and set AWS_PUB_DNS to DNS name of Conjur host."
    exit -1
  fi
#  scp_appliance_image_to_cloud
  scp_subdirs_to_cloud

  # exec to AWS EC2 instance to install & run demo
  ssh -i $AWS_SSH_KEY ubuntu@$AWS_PUB_DNS 
}

function scp_appliance_image_to_cloud() {
  echo "mkdir $IMAGE_DIR" | ssh -i $AWS_SSH_KEY ubuntu@$AWS_PUB_DNS
  scp -i $AWS_SSH_KEY \
	$CONJUR_TARFILE_SOURCE_DIR/$CONJUR_APPLIANCE_IMAGE_FILE \
	ubuntu@$AWS_PUB_DNS:$IMAGE_DIR

}

function scp_subdirs_to_cloud() {
  # Copy subdirectories to AWS
  scp -r -i $AWS_SSH_KEY $SETUP_DIR ubuntu@$AWS_PUB_DNS:~ 
  for i in $DEMO_DIRS; do
    scp -r -i $AWS_SSH_KEY $i ubuntu@$AWS_PUB_DNS:~ 
  done
}

main "$@"
