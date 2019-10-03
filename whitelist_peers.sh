#!/usr/bin/env bash


NETWORK_ROOT=$HOME/besu_pvn

P2P_PORT=30303
HTTP_RPC_PORT=8545
NODES=0

for d in ${NETWORK_ROOT}/Node-* ; do
    NODE_KEYS[NODES]=$(<${d}/data/key)
    NODES=$((NODES+1))
done

for key in ${NODE_KEYS[@]}; do
    echo ${key}
done
