#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
    exit 1
fi

cd ./vm/scripts
sh ./build.sh $1
