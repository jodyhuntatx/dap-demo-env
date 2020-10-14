#!/bin/bash

source ccp.config

curl -sk "https://$CCP_HOST/AIMWebService/api/Accounts?AppID=$APP_ID&Query=Safe=$SAFE;Object=$OBJECT" | jq .
