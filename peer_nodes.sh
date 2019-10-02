#!/usr/bin/env bash

NETWORK_ROOT=$HOME/besu_pvn

P2P_PORT=30303
HTTP_RPC_PORT=8545

NODE_1_ENODE=enode://7e0c587f89bd1166a4e92b15b727c89e5bc0516db03d10a48d62682d5564c12843051d25faa6ab128880d5b9a4b86c4a11ebfde891014084c9684e3683bc3efb@127.0.0.1:30303

case $1 in
    "1")
        echo node 1 is not needing peering
        exit 1
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

# doesn't look like this is needed exist for the first time
# echo adding nodes to white list
if [[ "$2" == "add" ]]; then
    curl -X POST --data '{"jsonrpc":"2.0","method":"perm_addNodesToWhitelist","params":[["enode://7e0c587f89bd1166a4e92b15b727c89e5bc0516db03d10a48d62682d5564c12843051d25faa6ab128880d5b9a4b86c4a11ebfde891014084c9684e3683bc3efb@127.0.0.1:30303","enode://6430f276e4559a2801f2b98f12c50342c2962227a1c2f4a355d7b80595e339291cddeabec39f0c3e545f3440cc0ccc51e1d82ca0678d0c899212f83d16982474@127.0.0.1:30304"]], "id":1}' http://127.0.0.1:8545
    curl -X POST --data '{"jsonrpc":"2.0","method":"perm_addNodesToWhitelist","params":[["enode://7e0c587f89bd1166a4e92b15b727c89e5bc0516db03d10a48d62682d5564c12843051d25faa6ab128880d5b9a4b86c4a11ebfde891014084c9684e3683bc3efb@127.0.0.1:30303","enode://6430f276e4559a2801f2b98f12c50342c2962227a1c2f4a355d7b80595e339291cddeabec39f0c3e545f3440cc0ccc51e1d82ca0678d0c899212f83d16982474@127.0.0.1:30304"]], "id":1}' http://127.0.0.1:8546
    curl -X POST --data '{"jsonrpc":"2.0","method":"perm_addNodesToWhitelist","params":[["enode://7e0c587f89bd1166a4e92b15b727c89e5bc0516db03d10a48d62682d5564c12843051d25faa6ab128880d5b9a4b86c4a11ebfde891014084c9684e3683bc3efb@127.0.0.1:30303","enode://6430f276e4559a2801f2b98f12c50342c2962227a1c2f4a355d7b80595e339291cddeabec39f0c3e545f3440cc0ccc51e1d82ca0678d0c899212f83d16982474@127.0.0.1:30304"]], "id":1}' http://127.0.0.1:8547
fi

echo peering node $1 to 1
curl -X POST --data '{"jsonrpc":"2.0","method":"admin_addPeer","params":["enode://7e0c587f89bd1166a4e92b15b727c89e5bc0516db03d10a48d62682d5564c12843051d25faa6ab128880d5b9a4b86c4a11ebfde891014084c9684e3683bc3efb@127.0.0.1:30303"],"id":1}' http://127.0.0.1:${HTTP_RPC_PORT}


echo confirming
curl -X POST --data '{"jsonrpc":"2.0","method":"net_peerCount","params":[],"id":1}' localhost:8545

echo
