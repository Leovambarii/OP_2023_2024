#!/bin/bash

# 5.0 Skrypt w bashu do uruchamiania aplikacji w Pascalu via docker
DOCKER_IMAGE="kprzystalski/projobj-pascal:latest"

echo "Pulling the needed docker image..."
docker pull $DOCKER_IMAGE
echo
echo "Compiling the pascal program via docker..."
docker run --rm -v "$(pwd)":/home/student/projobj/ $DOCKER_IMAGE fpc ex_1.pas
echo
echo "Running the compiled program via docker..."
docker run --rm -v "$(pwd)":/home/student/projobj/ $DOCKER_IMAGE ./ex_1