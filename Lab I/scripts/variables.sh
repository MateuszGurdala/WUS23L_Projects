#!/bin/bash

#Resource group
export RESOURCE_GROUP="$(jq -r '.resource_group.name' "$CONFIG")"
export RESOURCE_LOCATION="$(jq -r '.resource_group.location' "$CONFIG")"

#Virtual network
export VNET_NAME="$(jq -r '.virtual_network.name' "$CONFIG")"
export VNET_ADDRESS_PREFIX="$(jq -r '.virtual_network.address_prefix' "$CONFIG")"

#Public Ip
export PUBLIC_IP_NAME="$(jq -r '.public_ip.name' "$CONFIG")"
export PUBLIC_IP_VERSION="$(jq -r '.public_ip.version' "$CONFIG")"

#Security groups array
export SECURITY_GROUPS="$(jq -c '.security_groups[]' "$CONFIG")"

#Virtual machines array
export VIRTUAL_MACHINES="$(jq -c '.virtual_machines[]' "$CONFIG")"

#Commands array
export COMMANDS="$(jq -c '.commands[]' "$CONFIG")"

# echo $SECURITY_GROUPS | while read group; do
#     echo $group | jq -c '.rules[]' | while read rule; do
#         get_rule_data $rule
#         echo $RULE_NAME
#         echo $RULE_PRIORITY
#         echo $RULE_ACCESS
#         echo $RULE_PROTOCOL
#         echo $SOURCE_ADDRESS_PREFIXES
#         echo $SOURCE_PORT_RANGES
#         echo $DESTINATION_ADDRESS_PREFIXES
#         echo $DESTINATION_PORT_RANGES
#     done
# done

# echo $VIRTUAL_MACHINES | while read vm; do
#     get_vm_data $vm
#     echo $VM_NAME
#     echo $VM_IMAGE
#     echo $SECURITY_GROUP_NAME
#     echo $VM_PUBLIC_IP
#     echo $VM_PRIVATE_IP
#     echo $VM_SIZE
# done
