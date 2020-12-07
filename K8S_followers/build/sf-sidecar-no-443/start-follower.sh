#!/bin/bash
set -euo pipefail

# if not set already, set CONJUR_MASTER_PORT to 443
CONJUR_MASTER_PORT=${CONJUR_MASTER_PORT-443}
 
echo "DAP Seed Fetcher v$(cat /opt/dap-seedfetcher/VERSION)"

while [ ! -f "$SEEDFILE_DIR/follower-seed.tar" ]; do
  echo "waiting on seedfile..."
  sleep 10
done
echo "Starting follower services..."
/bin/keyctl session - /sbin/my_init &
sleep 5

if [[ -f "$SEEDFILE_DIR/follower-seed.tar" ]]; then
    echo "Unpacking seed..."
    evoke unpack seed $SEEDFILE_DIR/follower-seed.tar

    echo "Configuring follower..."
    evoke configure follower -p $CONJUR_MASTER_PORT
fi

wait
