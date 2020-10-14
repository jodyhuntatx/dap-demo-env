#!/bin/bash

echo "Connecting to PostgreSQL database..."
set -x
psql "host=localhost port=5432 dbname=test_app sslmode=disable"
set +x

echo "Connecting to MySQL database..."
set -x
mysql -h 127.0.0.1 test_app
set +x

echo "Connecting to MSSQLserver database..."
set -x
sqlcmd -U x -P x 
set +x

echo "Connecting to AWS EC2 instance via SSH..."
set -x
ssh -p 2222 foo@localhost
set +x

echo "Connecting to nginx via http..."
set -x
curl http://nginx:8081
set +x
