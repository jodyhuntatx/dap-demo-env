#!/bin/bash

DAP_PRIMARY_HOSTNAME=
DAP_PRIMARY_CONTAINER=dap-primary
DAP_APPLIANCE_IMAGE=conjur-appliance:11.7.0
DAP_ACCOUNT=bnsfpoc
DAP_ADMIN_PASSWORD=CYberark11@@

echo "Starting $DAP_PRIMARY_CONTAINER..."
sudo docker run -d			\
    --name $DAP_PRIMARY_CONTAINER	\
    -p "443:443"			\
    -p "5432:5432"			\
    -p "1999:1999"			\
    --restart unless-stopped		\
    --security-opt seccomp:unconfined	\
    $DAP_APPLIANCE_IMAGE

echo "Configuring $DAP_PRIMARY_CONTAINER..."
sudo docker exec $DAP_PRIMARY_CONTAINER		\
                evoke configure master		\
                -h $DAP_PRIMARY_HOSTNAME	\
                -p $DAP_ADMIN_PASSWORD		\
		--accept-eula		    	\
                $DAP_ACCOUNT
