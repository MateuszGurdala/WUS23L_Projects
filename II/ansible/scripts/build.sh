#!/bin/bash

#Source support functions
. ./utils.sh

#Get config files
get_vm_config_file $1
get_ansible_config_file $1

. ./variables.sh

az login

. ./update_inventory.sh
