#!/bin/bash

#Resource group
export RESOURCE_GROUP="$(jq -r '.resource_group.name' "$CONFIG")"
export RESOURCE_LOCATION="$(jq -r '.resource_group.location' "$CONFIG")"

#Virtual network
export VNET_NAME="$(jq -r '.virtual_network.name' "$CONFIG")"
export VNET_ADDRESS_PREFIX="$(jq -r '.virtual_network.address_prefix' "$CONFIG")"

#Public Ips array
export PUBLIC_IPS="$(jq -c '.public_ips[]' "$CONFIG")"

#Security groups array
export SECURITY_GROUPS="$(jq -c '.security_groups[]' "$CONFIG")"

#Subnets array
export SUBNETS="$(jq -c '.subnets[]' "$CONFIG")"

#Virtual machines array
export VIRTUAL_MACHINES="$(jq -c '.virtual_machines[]' "$CONFIG")"

#Commands array
export COMMANDS="$(jq -c '.commands[]' "$CONFIG")"
