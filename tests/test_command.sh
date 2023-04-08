#!/bin/bash

az login

az group create \
    --name "Test_group" \
    --location "northeurope"

az vm create \
    --name "Test_VM" \
    --resource-group "Test_group" \
    --authentication-type "ssh" \
    --generate-ssh-keys \
    --image "Ubuntu2204" \
    --size "Standard_B2s"

az vm run-command invoke \
    --name "Test_VM" \
    --command-id "RunShellScript" \
    --resource-group "Test_group" \
    --scripts "@./backend.sh" \
    --parameters "10.0.2.5" "9000" "9000" \
    --debug
