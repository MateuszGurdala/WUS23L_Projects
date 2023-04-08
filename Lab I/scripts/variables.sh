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
