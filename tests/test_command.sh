#!/bin/bash

RESOURCE_GROUP="Test_group"

az login

# az vm create \
#     --name "Backend" \
#     --resource-group "WUS_LAB_1" \
#     --authentication-type "ssh" \
#     --generate-ssh-keys \
#     --image "UbuntuLTS" \
#     --size "Standard_B2s" \
#     --public-ip-address "VM_IP"

az vm create \
    --name "Backend" \
    --resource-group "WUS_LAB_1" \
    --authentication-type "ssh" \
    --generate-ssh-keys \
    --image "UbuntuLTS" \
    --nsg "" \
    --public-ip-address "" \
    --private-ip-address "10.0.2.5" \
    --size "Standard_DS1_v2" \
    --subnet "SubnetBack" \
    --vnet-name "VNet3"

az vm run-command invoke \
    --name "Backend" \
    --command-id "RunShellScript" \
    --resource-group "WUS_LAB_1" \
    --scripts "@./backend_slavemaster.sh" \
    --parameters "10.0.3.6" "3306" "10.0.3.7" "3305" "9000"
