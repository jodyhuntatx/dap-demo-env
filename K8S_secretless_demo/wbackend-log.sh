#!/bin/bash

. ../config/dap.config
. ../config/utils.sh

if [[ $1 != pg && $1 != my && $1 != ms && $1 != http && $1 != conjur ]]; then
  echo "Watch backend server log."
  echo "Usage: $0 [ pg | my | ms | http | conjur ]"
  exit -1
fi
BACKEND=$1

# finds pod matching pod_name_substr and follows the secretless container log
if [[ $BACKEND == pg ]]; then
  app_pod=postgres-db-0
elif [[ $BACKEND = ms ]]; then
  app_pod=mssqlserver-db-0
elif [[ $BACKEND = my ]]; then
  app_pod=mysql-db-0
elif [[ $BACKEND = http ]]; then
  app_pod=nginx-0
else
  app_pod=conjur1
fi

if [[ $app_pod = conjur1 ]]; then
  docker exec $app_pod tail -f /var/log/conjur/audit.log
else
  $CLI logs -f $app_pod -n $TEST_APP_NAMESPACE_NAME
fi
