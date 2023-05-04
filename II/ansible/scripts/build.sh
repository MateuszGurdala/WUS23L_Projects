#!/bin/bash

#Source support functions
. ./utils.sh

#Get config files
get_vm_config_file $1
get_ansible_config_file $1

. ./variables.sh

az login

inventory_set_user $USER $INVENTORY

for VM in $VIRTUAL_MACHINES; do

    get_vm_data $VM
    get_host $VM_NAME

    if [ "$VM_PUBLIC_IP" != "" ]; then
        get_public_ip $RESOURCE_GROUP $VM_PUBLIC_IP
        inventory_set_public_ip $HOST $IP $INVENTORY
    fi

    inventory_set_ansible_host $HOST $VM_PRIVATE_IP $INVENTORY
done
