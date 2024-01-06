#!/bin/bash

while getopts name:node:port: flag
do
    case "${flag}" in
        name) name=${OPTARG};;
        node) node=${OPTARG};;
        port) port=${OPTARG};;
    esac
done

ssh -t -t $name@gwdu101.gwdg.de -L $port:localhost:$port ssh $node -L $port:localhost:$port
