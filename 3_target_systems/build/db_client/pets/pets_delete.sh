#!/bin/bash

PETSTORE_ADDRESS=petstore:8080

echo "Deleting pets 1-4.."
curl -XDELETE $PETSTORE_ADDRESS/pet/1
curl -XDELETE $PETSTORE_ADDRESS/pet/2
curl -XDELETE $PETSTORE_ADDRESS/pet/3
curl -XDELETE $PETSTORE_ADDRESS/pet/4
