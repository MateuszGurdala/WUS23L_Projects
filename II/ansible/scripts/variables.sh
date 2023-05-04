#!/bin/bash

export RESOURCE_GROUP="$(jq -r '.resource_group.name' "$VM_CONFIG")"

export VIRTUAL_MACHINES="$(jq -c '.virtual_machines[]' "$VM_CONFIG")"
