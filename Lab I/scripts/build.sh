#!/bin/bash

#Source support functions
. ./utils.sh

#Install required packages
#sh ./install_tools.sh

#Get config file variables
get_config_file $1

#Source config file variables
. ./variables.sh

#Login
az login

#Create a new resource group
az group create \
    --name $RESOURCE_GROUP \
    --location $RESOURCE_LOCATION

#Create public IPv4 address
az network public-ip create \
    --resource-group $RESOURCE_GROUP \
    --name $PUBLIC_IP_NAME \
    --version $PUBLIC_IP_VERSION #Set default as IPv4?

#Create a virtual network for VM's
az network vnet create \
    --name $VNET_NAME \
    --resource-group $RESOURCE_GROUP \
    --address-prefix $VNET_ADDRESS_PREFIX

#Create network security groups with networking rules
for GROUP in $SECURITY_GROUPS; do

    get_group_name $GROUP

    az network nsg create \
        --resource-group $RESOURCE_GROUP \
        --name $SECURITY_GROUP_NAME

    echo $GROUP | jq -c '.rules[]' | while read RULE; do

        get_rule_data $RULE

        az network nsg rule create \
            --name $RULE_NAME \
            --nsg-name $SECURITY_GROUP_NAME \
            --priority $RULE_PRIORITY \
            --resource-group $RESOURCE_GROUP \
            --access $RULE_ACCESS \
            --protocol $RULE_PROTOCOL \
            --destination-address-prefixes "$DESTINATION_ADDRESS_PREFIXES" \
            --destination-port-ranges "$DESTINATION_PORT_RANGES" \
            --source-address-prefixes "$SOURCE_ADDRESS_PREFIXES" \
            --source-port-ranges "$SOURCE_PORT_RANGES"
    done
done

for SUBNET in $SUBNETS; do

    get_subnet_data $SUBNET

    az network vnet subnet create \
        --name $SUBNET_NAME \
        --resource-group $RESOURCE_GROUP \
        --vnet-name $VNET_NAME \
        --address-prefixes $SUBNET_ADDRESS_PREFIXES \
        --network-security-group $SUBNET_SECURITY_GROUP_NAME
done

#Create virtual machines and run deploy scripts
for VM in $VIRTUAL_MACHINES; do

    get_vm_data $VM

    if [ "$VM_PUBLIC_IP" ]; then
        az vm create \
            --name $VM_NAME \
            --resource-group $RESOURCE_GROUP \
            --authentication-type "ssh" \
            --generate-ssh-keys \
            --image $VM_IMAGE \
            --nsg "" \
            --public-ip-address $VM_PUBLIC_IP \
            --private-ip-address $VM_PRIVATE_IP \
            --size $VM_SIZE \
            --subnet $VM_SUBNET \
            --vnet-name $VNET_NAME
    fi

    if [ ! "$VM_PUBLIC_IP" ]; then
        az vm create \
            --name $VM_NAME \
            --resource-group $RESOURCE_GROUP \
            --authentication-type "ssh" \
            --generate-ssh-keys \
            --image $VM_IMAGE \
            --nsg "" \
            --public-ip-address "" \
            --private-ip-address $VM_PRIVATE_IP \
            --size $VM_SIZE \
            --subnet $VM_SUBNET \
            --vnet-name $VNET_NAME
    fi
    #--public-ip-sku Standard #Recommended?
done

#Run deployment comamnds
for COMMAND in $COMMANDS; do

    get_command_data $COMMAND

    az vm run-command invoke \
        --command-id "RunShellScript" \
        --name $VM_NAME \
        --resource-group $RESOURCE_GROUP \
        --scripts $SCRIPT_FILE \
        --parameters $PARAMS \
        --debug
done
