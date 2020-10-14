#!/bin/bash

if [[ $# != 1 ]]; then
  echo "Usage: $0 <pet-name>"
  exit -1
fi
pet_name=$1

PETSTORE_ADDRESS=petstore:8080

echo "Pets in PetDB - before:"
curl -s $PETSTORE_ADDRESS/pets
echo

echo
echo "Adding $pet_name..."
curl -XPOST --data "{ \"name\": \"$pet_name\" }" -H "Content-Type: application/json" $PETSTORE_ADDRESS/pet

echo
echo "Pets in PetDB - after:"
curl -s $PETSTORE_ADDRESS/pets
echo
echo
