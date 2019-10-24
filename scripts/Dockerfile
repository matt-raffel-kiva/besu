from hyperledger/besu:latest

# This is the base of everything we will need for the image
RUN apt-get update && \
      apt-get install -y \
      apt-transport-https \
      curl \
      vim \
      wget \
      iputils-ping \
      telnet

WORKDIR /app
ADD * /app/
ENTRYPOINT [ "/app/start_docker_node.sh" ]
