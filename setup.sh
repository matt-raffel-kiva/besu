#!/usr/bin/env bash


NETWORK_ROOT=$HOME/besu_pvn
NODES=2

cwd=$(pwd)

if [[ "$1" != "" ]]; then
    NETWORK_ROOT=$1
    shift
fi

if [[ "$1" != "" ]]; then
    echo input found $1
    if ! [[ "$1" =~ ^[2-9]+$ ]]; then
       echo "Just enter number of nodes"
       exit 1
    fi
    set NODES=$1
fi


echo configuring data directories ${NETWORK_ROOT} Nodes ${NODES}
for NODE_ID in $(seq 1 ${NODES});
do
    echo making node ${NODE_ID}
    mkdir -p ${NETWORK_ROOT}/Node-${NODE_ID}/data
    echo copying permissions for ${NODE_ID}
    cp permissions_config.toml ${NETWORK_ROOT}/Node-${NODE_ID}/data
done
ls -l ${NETWORK_ROOT}


besu --data-path=${NETWORK_ROOT} public-key export-address --to=${NETWORK_ROOT}/nodeAddress1

echo
echo nodeAddress1 information
cat ${NETWORK_ROOT}/nodeAddress1
echo

# like to get data from  besu --data-path=$NETWORK_ROOT public-key export-address --to=$NETWORK_ROOT/nodeAddress1
# and automagically put it in the cliqueGenesis.json file

echo copying genesis file
read -p "edit cliqueGenesis.json updating it with public key"
cp cliqueGenesis.json ${NETWORK_ROOT}

cd ${cwd}


