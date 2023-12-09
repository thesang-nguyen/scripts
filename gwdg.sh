#!/bin/bash

while getopts name:n:p: flag
do
    case "${flag}" in
        name) name=${OPTARG};;
        n) node=${OPTARG};;
        p) port=${OPTARG};;
    esac
done

ssh -t -t $name@gwdu101.gwdg.de -L $port:localhost:$port ssh $node -L $port:localhost:$port
