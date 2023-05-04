#!/bin/bash

inventory_set_user $USER $INVENTORY

for VM in $VIRTUAL_MACHINES; do

    get_vm_data $VM
    get_host $VM_NAME

    if [ "$VM_PUBLIC_IP" != "" ]; then
        get_public_ip $RESOURCE_GROUP $VM_PUBLIC_IP
        inventory_set_public_ip $USER $IP $INVENTORY
    fi

    inventory_set_ansible_host $HOST $VM_PRIVATE_IP $INVENTORY

    for PARAM in $VM_PARAMS; do

        get_param_data $PARAM

        inventory_add_param $HOST $PARAM_NAME $PARAM_VALUE $INVENTORY

    done
done
