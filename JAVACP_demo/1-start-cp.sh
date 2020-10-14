#!/bin/bash

source ./javacpdemo.config

main() {
  ./stop
  if [ $? -ne 0 ]; then
    exit
  fi
  start
  compile_app
  ./exec-into-app.sh
}

######################
start() {
  docker run -d 	   \
    -h $DEMO_HOSTNAME	   \
    --name $DEMO_CONTAINER \
    --entrypoint sh 	   \
    $DEMO_IMAGE 	   \
    -c "sleep infinity"

  # create credfile
  docker exec -it $DEMO_CONTAINER \
	/tmp/CreateCredFile $CP_INSTALL_DIR/$CREDFILE_NAME \
	Password -Username $VAULT_USERNAME -Password $VAULT_PASSWORD

  # install package & start credential provider
  DEBFILE=$(docker exec $DEMO_CONTAINER bash -c "ls /tmp/CARKaim*")
  docker exec $DEMO_CONTAINER dpkg -i $DEBFILE


  status=$(docker exec $DEMO_CONTAINER /etc/init.d/aimprv start)
  if [[ $(echo $status | grep failed) != "" ]]; then
    echo
    echo "############################################################"
    echo ">> CP startup failed. Use Private Ark client to delete existing Prov_$DEMO_HOSTNAME user in Applications folder."
    echo "############################################################"
    echo
    exit -1
  fi

  echo
  echo "############################################################"
  echo ">> Be sure to add Prov_$DEMO_HOSTNAME as a member of the safe(s) it needs access to."
  echo "############################################################"
  echo
}

######################
compile_app() {
  for i in $(ls app/); do
    docker cp ./app/$i $DEMO_CONTAINER:$DEMO_DIR/
  done
  docker exec $DEMO_CONTAINER ./compile.sh
}

main "$@"
