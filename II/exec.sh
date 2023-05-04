#!/bin/bash

if [ "$#" == 1 ]; then
    if [ "$1" == "installtools" ]; then
        echo "Installing tools"
        sh ./install_tools.sh
        exit 0
    fi
fi

if [ "$#" == 3 ]; then
    if [ "$1" == "deploy" ]; then
        if [ "$2" == "vm" ]; then
            echo "Deploying Virtual Machines"
            cd ./vm/scripts
            sh ./build.sh $3
            exit 0
        elif [ "$2" == "ansible" ]; then
            echo "Running Ansible Playbook"
            cd ./ansible/scripts
            sh ./build.sh $3
            exit 0
        fi
    fi
fi

echo "Invalid arguments"
exit 1
