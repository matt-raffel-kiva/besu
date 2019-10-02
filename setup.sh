#!/usr/bin/env bash

NETWORK_ROOT=$HOME/besu_pvn
cwd=$(pwd)

if [[ "$1" != "" ]]; then
    NETWORK_ROOT=$1
fi

echo configuring data directories ${NETWORK_ROOT}
mkdir -p ${NETWORK_ROOT}/Node-1/data
mkdir -p ${NETWORK_ROOT}/Node-2/data
mkdir -p ${NETWORK_ROOT}/Node-3/data
ls -l ${NETWORK_ROOT}

echo copying permissions
cp permissions_config.toml ${NETWORK_ROOT}/Node-1/data
cp permissions_config.toml ${NETWORK_ROOT}/Node-2/data
cp permissions_config.toml ${NETWORK_ROOT}/Node-3/data

# like to get data from  besu --data-path=$NETWORK_ROOT public-key export-address --to=$NETWORK_ROOT/nodeAddress1
# and automagically put it in the cliqueGenesis.json file

echo copying genesis file
read -p "edit cliqueGenesis.json updating it with public key"
cp cliqueGenesis.json ${NETWORK_ROOT}

cd ${cwd}


