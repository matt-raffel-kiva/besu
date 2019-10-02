#!/usr/bin/env bash


NETWORK_ROOT=$HOME/besu_pvn

if [[ "$1" != "" ]]; then
    NETWORK_ROOT=$1
fi

rm -rf ${NETWORK_ROOT}
