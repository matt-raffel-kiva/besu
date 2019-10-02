#!/usr/bin/env bash


NETWORK_ROOT=$HOME/besu_pvn
P2P_PORT=30303
HTTP_RPC_PORT=8545

cwd=$(pwd)

if [[ "$1" == "" ]]; then
    echo "node parameter was not specified (1,2,3....)"
    exit 1
fi

if ! [[ "$1" =~ ^[0-9]+$ ]]; then
   echo "Just enter node # (1,2,3...)"
   exit 1
fi

if [[ "$2" != "" ]]; then
    NETWORK_ROOT=$2
fi

case $1 in
    "1")
        ;;
    "2")
        P2P_PORT=30304
        HTTP_RPC_PORT=8546
        ;;
    "3")
        P2P_PORT=30305
        HTTP_RPC_PORT=8547
        ;;
    *)
        echo unrecognized port $1
        exit 1
        ;;
esac


cd ${NETWORK_ROOT}/Node-$1
besu --data-path=data --genesis-file=../cliqueGenesis.json --permissions-nodes-config-file-enabled --permissions-accounts-config-file-enabled --rpc-http-enabled --rpc-http-api=ADMIN,ETH,NET,PERM,CLIQUE --host-whitelist="*" --rpc-http-cors-origins="*" --p2p-port=${P2P_PORT} --rpc-http-port=${HTTP_RPC_PORT}
