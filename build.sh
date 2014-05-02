#!/bin/bash

# Vars
DOCKERNAME="jasongiedymin/ansible-ghost"

# Build Docker
time docker build -t $DOCKERNAME .

echo
echo "This image is a trusted docker.io Image."
echo
echo "To pull it"
echo "    docker pull $DOCKERNAME"
echo
echo "To use this docker:"
echo "    docker run -d -P $DOCKERNAME"
echo
echo " then, with the port listed running [docker ps]"
echo "    curl http://localhost:<port>"
echo " should yield an html page response"
echo
echo "to run in interactive mode for debug:"
echo "    docker run -t -i $DOCKERNAME bash"
echo
