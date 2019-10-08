#!/bin/bash
set -ev

# This script follows the tutorial here:
# https://besu.hyperledger.org/en/latest/Tutorials/Private-Network/Create-Private-Clique-Network/
# dependencies: cliqueGenesis.json, put Clique-Network in gitignore
# TODOs: randomly generate all keys

# kill all subprocesses on ctrl-c
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

brew install jq
brew tap hyperledger/besu
brew install besu

mkdir -p Clique-Network/Node-1
mkdir -p Clique-Network/Node-2
mkdir -p Clique-Network/Node-3

besu --data-path=Clique-Network/Node-1/data public-key export-address --to=Clique-Network/Node-1/data/node1Address

cat cliqueGenesis.json | jq ".extraData |= \"0x$(printf '0%.0s' {1..64})$(cut -d'x' -f 2 < Clique-Network/Node-1/data/node1Address )$(printf '0%.0s' {1..130})\"" > Clique-Network/cliqueGenesis.json

# run node 1
besu --data-path=Clique-Network/Node-1/data \
     --genesis-file=Clique-Network/cliqueGenesis.json \
     --network-id 123 \
     --rpc-http-enabled \
     --rpc-http-api=ETH,NET,CLIQUE \
     --host-whitelist="*" \
     --rpc-http-cors-origins="all" &

node1pubid=$(besu --data-path=Clique-Network/Node-1/data public-key export | grep ^0x | cut -d'x' -f 2)
node1host=127.0.0.1
node1port=30303
enode_url=enode://$node1pubid@$node1host:$node1port

# TODO: poll for node1 to be ready?
sleep 1

# run second node
besu --data-path=Clique-Network/Node-2/data \
     --genesis-file=Clique-Network/cliqueGenesis.json \
     --bootnodes=$enode_url \
     --network-id 123 \
     --p2p-port=30304 \
     --rpc-http-enabled \
     --rpc-http-api=ETH,NET,CLIQUE \
     --host-whitelist="*" \
     --rpc-http-cors-origins="all" \
     --rpc-http-port=8546 &

# run third node
besu --data-path=Clique-Network/Node-3/data \
     --genesis-file=Clique-Network/cliqueGenesis.json \
     --bootnodes=$enode_url \
     --network-id 123 \
     --p2p-port=30305 \
     --rpc-http-enabled \
     --rpc-http-api=ETH,NET,CLIQUE \
     --host-whitelist="*" \
     --rpc-http-cors-origins="all" \
     --rpc-http-port=8547
