from hyperledger/besu:latest

RUN apt-get update -y && apt-get install jq -y
WORKDIR /app
ADD entrypoint.sh .
ENTRYPOINT [ "./entrypoint.sh" ]
