#!/bin/bash

# All environment variables are container env vars set in docker run arguments

		# if not here, build the jarfile
if [[ ! -f JavaDemo.jar ]]; then
  pushd build
    ./build.sh
    mv JavaDemo.jar ..
  popd
fi
		# if not here, build java key store
if [[ ! -f $JAVA_KEY_STORE_FILE ]]; then
  echo "Initializing Java key store..."
  keytool -importcert -trustcacerts -file ./conjur-master.pem -keystore $JAVA_KEY_STORE_FILE &> /dev/null <<EOF
$JAVA_KEY_STORE_PASSWORD
$JAVA_KEY_STORE_PASSWORD
yes
EOF
fi
		# default to host id retrieval
OP_ARG=$1
if [[ "$OP_ARG" == "" ]]; then
  OP_ARG=host
fi

# run the app
java -jar JavaDemo.jar $OP_ARG
