#!/bin/bash

source ../config/dap.config

#if [[ $# != 2 ]]; then
#  echo "Usage: $0 <user-number>"
#  exit -1
#fi
case $1 in
  1)
    MYSQL_USERNAME=test_user1
    MYSQL_PASSWORD=1234wxyz
    ;;
  2)
    MYSQL_USERNAME=test_user2
    MYSQL_PASSWORD=abcd1234
    ;;
  *)
    echo "Usage: $0 <user-number>"
    exit -1
esac

echo "use petclinic; select owners.first_name, owners.last_name, pets.name, types.name from owners, pets, types where pets.owner_id=owners.id and pets.type_id=types.id;"	\
| docker exec -i db-client mysql -h $CONJUR_MASTER_HOST_NAME --ssl-mode=disable -u $MYSQL_USERNAME --password=$MYSQL_PASSWORD

