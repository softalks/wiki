#!/bin/bash
# Allow to attach to container
sleep 15
/prepare-env.sh && echo "Preparation successfully finished"
exec "$@"
