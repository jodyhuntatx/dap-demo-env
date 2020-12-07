#!/bin/bash

#Variables
DOCKER_PODMAN="podman"
SECOPT_PODMAN="--security-opt=seccomp=unconfined"
SECOPT_DOCKER="--security-opt seccomp:unconfined"
SECOPT=$SECOPT_PODMAN
RESTART_PODMAN="--restart=always"
RESTART_DOCKER="--restart unless-stopped"
RESTART=$RESTART_PODMAN

DAP_HOST_DNS=rhel8nogui
DAP_HOST_IP=192.168.35.196
DAP_HTTPS_PORT=1443
CONJUR_APPLIANCE_URL=https://$DAP_HOST_DNS:$DAP_HTTPS_PORT
DAP_PRIMARY_IMAGE=localhost/cyberark/conjur-appliance:11.7.0
DAP_PRIMARY_CONTAINER=dap-primary
DAP_CLI_IMAGE=localhost/cyberark/conjur-cli:5-latest
DAP_CLI_CONTAINER=dap-cli
DAP_ALTNAMES=rhel8nogui.localdomain
DAP_ADMIN_USERNAME=admin
DAP_ADMIN_PASSWORD=CYberark11@@
DAP_ACCOUNT=cyberark

main(){
  stop_all
  start_dap_master
  start_dap_cli
}

###################################
stop_all() {
  stop_primary
  stop_cli
}

stop_primary() {
  $DOCKER_PODMAN stop $DAP_PRIMARY_CONTAINER
  $DOCKER_PODMAN rm $DAP_PRIMARY_CONTAINER
}

stop_cli() {
  $DOCKER_PODMAN stop $DAP_CLI_CONTAINER
  $DOCKER_PODMAN rm $DAP_CLI_CONTAINER
}

###################################
start_dap_master(){
  echo "Starting DAP Master container"
  echo "-----"
  $DOCKER_PODMAN container run -d 	\
	  --name $DAP_PRIMARY_CONTAINER \
	  $RESTART		\
	  $SECOPT		\
	  -p $DAP_HTTPS_PORT:443	\
	  -p 5432:5432		\
	  -p 1999:1999		\
	  $DAP_PRIMARY_IMAGE

  echo "Configuring Master Instance"
  echo "-----"
  $DOCKER_PODMAN exec $DAP_PRIMARY_CONTAINER	\
	  evoke configure master --accept-eula -h $DAP_HOST_DNS -p $DAP_ADMIN_PASSWORD $DAP_ACCOUNT
  #echo "addin ALTNAME(s) to cert"
  #echo "------"
  #$DOCKER_PODMAN exec $DAP_CONTAINER_NAME evoke ca regenerate --restart $DAP_ALTNAMES
}

###################################
start_dap_cli() {
  echo "Starting DAP CLI"
  echo "-----"
  $DOCKER_PODMAN container run -d \
	  --name $DAP_CLI_CONTAINER			\
	  $RESTART					\
	  --add-host "$DAP_HOST_DNS:$DAP_HOST_IP"	\
	  --entrypoint sh 	\
	  $DAP_CLI_IMAGE	\
	  -c "sleep infinity"

  echo "Configuring DAP CLI"
  echo "-----"
  $DOCKER_PODMAN exec -i $DAP_CLI_CONTAINER \
	  conjur init --account $DAP_ACCOUNT --url $CONJUR_APPLIANCE_URL <<< yes
  $DOCKER_PODMAN exec $DAP_CLI_CONTAINER \
	  conjur authn login -u $DAP_ADMIN_USERNAME -p $DAP_ADMIN_PASSWORD
}

main
