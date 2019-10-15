# Besu Dockerfile
Experimental Dockerfile for Besu network

# Run

## init

This docker instance can be used to generate a keypair
```
$ docker build -t besunode .
$ docker run besunode init
BESU_KEY_PUBLIC=0x327902f70c5b7f71633d673fc57693ee4223121e498630084fce17d35cdedb8c6d4bce3fb6df1c4b57a10765195253fa91e2066538298de8f228addafe5b99d7
BESU_KEY_PRIVATE=0xe7190808113660dbcd72b7c30039eb37eaf7dc87fd5c425a4434ab0c3d1ec8b1
```

## Genesis configuration

Write a genesis.json file and make it configurable per environment

## Data Persistence

To persist data, map a persistent EBS volume to /app/data

Details on EBS: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumes.html

Details on volume mapping for docker: https://docs.docker.com/storage/volumes/

## Environment

Required:
 - BESU_PRIVATE_KEY
 - BESU_GENESIS_FILE

Optional (required for all nodes except the initial node):
 - BESU_BOOTNODES

Optional:
 - https://besu.hyperledger.org/en/latest/Reference/CLI/CLI-Syntax/
