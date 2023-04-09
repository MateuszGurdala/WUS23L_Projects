#!/bin/bash

RESOURCE_GROUP="Test_group"

az login

# az group create \
#     --name "$RESOURCE_GROUP" \
#     --location "northeurope"

# az network public-ip create \
#     --resource-group $RESOURCE_GROUP \
#     --name "VM_IP" \
#     --version "IPv4" #Set default as IPv4?

# az vm create \
#     --name "Test_VM" \
#     --resource-group "$RESOURCE_GROUP" \
#     --authentication-type "ssh" \
#     --generate-ssh-keys \
#     --image "Ubuntu2204" \
#     --size "Standard_B2s" \
#     --public-ip-address "VM_IP"

# az vm run-command invoke \
#     --name "Test_VM" \
#     --command-id "RunShellScript" \
#     --resource-group "$RESOURCE_GROUP" \
#     --scripts "@./backend.sh" \
#     --parameters "10.0.2.5" "9000" "9000" \
#     --debug

COMMAND="az network public-ip show --resource-group $RESOURCE_GROUP --name "VM_IP" --query ipAddress --output tsv"
PARAM="$($COMMAND)"
echo $PARAM

# az network public-ip show \
#     --resource-group $RESOURCE_GROUP \
#     --name "VM_IP" \
#     --query ipAddress \
#     --output tsv
