#!/usr/bin/env bash

NETWORK_ROOT=$HOME/besu_pvn

# doesn't look like this is needed exist for the first time
# echo adding nodes to white list
# curl -X POST --data '{"jsonrpc":"2.0","method":"perm_addNodesToWhitelist","params":[["enode://3397522b8b6babd8936fb9324a45c30f9acbe28d6b0910cf78b098c0751516195a126d84217eeda7d06eb9c3bd01eec09806405562ae332e2e7da1886293cc18@127.0.0.1:30303","enode://6430f276e4559a2801f2b98f12c50342c2962227a1c2f4a355d7b80595e339291cddeabec39f0c3e545f3440cc0ccc51e1d82ca0678d0c899212f83d16982474@127.0.0.1:30304"]], "id":1}' http://127.0.0.1:8545
# curl -X POST --data '{"jsonrpc":"2.0","method":"perm_addNodesToWhitelist","params":[["enode://3397522b8b6babd8936fb9324a45c30f9acbe28d6b0910cf78b098c0751516195a126d84217eeda7d06eb9c3bd01eec09806405562ae332e2e7da1886293cc18@127.0.0.1:30303","enode://6430f276e4559a2801f2b98f12c50342c2962227a1c2f4a355d7b80595e339291cddeabec39f0c3e545f3440cc0ccc51e1d82ca0678d0c899212f83d16982474@127.0.0.1:30304"]], "id":1}' http://127.0.0.1:8546
# curl -X POST --data '{"jsonrpc":"2.0","method":"perm_addNodesToWhitelist","params":[["enode://3397522b8b6babd8936fb9324a45c30f9acbe28d6b0910cf78b098c0751516195a126d84217eeda7d06eb9c3bd01eec09806405562ae332e2e7da1886293cc18@127.0.0.1:30303","enode://6430f276e4559a2801f2b98f12c50342c2962227a1c2f4a355d7b80595e339291cddeabec39f0c3e545f3440cc0ccc51e1d82ca0678d0c899212f83d16982474@127.0.0.1:30304"]], "id":1}' http://127.0.0.1:8547

echo peering node 2 to 1
curl -X POST --data '{"jsonrpc":"2.0","method":"admin_addPeer","params":["enode://3397522b8b6babd8936fb9324a45c30f9acbe28d6b0910cf78b098c0751516195a126d84217eeda7d06eb9c3bd01eec09806405562ae332e2e7da1886293cc18@127.0.0.1:30303"],"id":1}' http://127.0.0.1:8546

echo confirming
curl -X POST --data '{"jsonrpc":"2.0","method":"net_peerCount","params":[],"id":1}' localhost:8545
