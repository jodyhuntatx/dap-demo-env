#!/bin/bash

export BASEURL="https://WIN-T4KRGHVATN4"
export APPID="WASASCP"
export SAFE="CICD_Secrets"
export FOLDER="Root"
export OBJECTNAME="Database-MSSql-JodyDBUser"
#set -x
RESPONSE=$(curl -k -s \
  "$BASEURL/AIMWebService/api/Accounts?AppID=$APPID&Safe=$SAFE&Folder=$FOLDER&Object=$OBJECTNAME")
PASSWORD=$(echo $RESPONSE | jq -r .Content)
echo "The password is: ${PASSWORD}"
