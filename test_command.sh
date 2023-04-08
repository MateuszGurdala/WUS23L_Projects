#!/bin/bash

az login

az group create \
    --name "Test_group" \
    --location "northeurope"

az network public-ip create \
    --resource-group "Test_group" \
    --name "Pub_IP" \
    --version "IPv4"

az vm create \
    --name "Test_VM" \
    --resource-group "Test_group" \
    --authentication-type "ssh" \
    --generate-ssh-keys \
    --image "Ubuntu2204" \
    --size "Standard_B1s"

az vm run-command invoke \
    --command-id "Test_command" \
    --resource-group "Test_group" \
    --scripts "SCRIPTSHERE" \
    --parameters "PARAMSHERE"
