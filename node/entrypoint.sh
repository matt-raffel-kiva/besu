#!/bin/bash

# This script is a convenience wrapper for multiple besu functions:
# - generating a public private keypair (pass init as an argument)
# - running a bootnode (leave BESU_BOOTNODES unset)
# - running a non-boot node (set BESU_BOOTNODES)

# script

besu=/opt/besu/bin/besu

if [[ "$1" == "init" ]]
then
    # generate key (ignore debug output)
    $besu --data-path=data public-key export --to=data/pubkey > /dev/null
    echo -n 'BESU_KEY_PUBLIC='
    cat data/pubkey
    echo ""
    echo -n 'BESU_KEY_PRIVATE='
    cat data/key
    echo ""
    exit 0
fi

# The remainder of the script spins up a besu node based on config provided by
# environment variables
# dependencies: genesis file, environment variables

set -ev

# Environment - required for running a node

# The private key of the running node
if [[ ! -z "$BESU_KEY_PRIVATE" ]]
then
    >&2 echo "BESU_KEY_PRIVATE must be set"
    exit 1
fi

# The file path of genesis file for private network.
if [[ ! -z "$BESU_GENESIS_FILE" ]]
then
    >&2 echo "BESU_GENESIS_FILE must be set"
    exit 1
fi

# Environment - required for nonboot nodes

# BESU_BOOTNODES # list of bootnode URLs
if [[ ! -z "$BESU_BOOTNODES" ]]
then
    >&2 echo "THIS IS A BOOT NODE"
    >&2 echo "URL=enode://"$(echo $BESU_PUBLIC_KEY | cut -d'x' -f 2)"@"TODO-GET-PUBLIC-HOSTNAME:30303"
fi

mkdir data
echo -n $BESU_KEY_PRIVATE > data/key

# Environment - optional
# BESU_NETWORK_ID # overrides the network ID in the genesis file
# BESU_BANNED_NODEIDS # blacklist for node public keys (e.g. revoked orgs)

$besu --data-path=data \
     --node-private-key-file=data/key \
     --rpc-http-enabled \
     --rpc-http-api=ETH,NET,CLIQUE \
     --host-whitelist="*" \
     --rpc-http-cors-origins="all"
