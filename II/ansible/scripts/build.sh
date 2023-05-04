#!/bin/bash

#Source support functions
. ./utils.sh

#Get config files
get_config_files $1

. ./variables.sh

az login

. ./update_inventory.sh

cd ..
ansible-playbook -i inventory/"$INVENTORY_FILE" configs/"$PLAYBOOK_FILE"
