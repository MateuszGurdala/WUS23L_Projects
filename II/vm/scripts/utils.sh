#!/bin/bash

get_config_file() {
    case "$1" in
    1)
        export CONFIG="../configs/config1.json"
        ;;
    3)
        export CONFIG="../configs/config3.json"
        ;;
    5)
        export CONFIG="../configs/config5.json"
        ;;
    *)
        echo "Invalid config number"
        exit 1
        ;;
    esac
}

get_group_name() {
    export SECURITY_GROUP_NAME="$(echo $1 | jq -r '.name')"
}

get_public_ip_data() {
    export PUBLIC_IP_NAME="$(echo $1 | jq -r '.name')"
    export PUBLIC_IP_VERSION="$(echo $1 | jq -r '.version')"
}

get_rule_data() {
    export RULE_NAME="$(echo $1 | jq -r '.name')"
    export RULE_PRIORITY="$(echo $1 | jq -r '.priority')"
    export RULE_ACCESS="$(echo $1 | jq -r '.access')"
    export RULE_PROTOCOL="$(echo $1 | jq -r '.protocol')"
    export SOURCE_ADDRESS_PREFIXES="$(echo $1 | jq -r '.source.address_prefixes')"
    export SOURCE_PORT_RANGES="$(echo $1 | jq -r '.source.port_ranges')"
    export DESTINATION_ADDRESS_PREFIXES="$(echo $1 | jq -r '.destination.address_prefixes')"
    export DESTINATION_PORT_RANGES="$(echo $1 | jq -r '.destination.port_ranges')"
}

get_subnet_data() {
    export SUBNET_NAME="$(echo $1 | jq -r '.name')"
    export SUBNET_ADDRESS_PREFIXES="$(echo $1 | jq -r '.address_prefixes')"
    export SUBNET_SECURITY_GROUP_NAME="$(echo $1 | jq -r '.network_security_group_name')"
}

get_vm_data() {
    export VM_NAME="$(echo $1 | jq -r '.name')"
    export VM_IMAGE="$(echo $1 | jq -r '.image')"
    export SECURITY_GROUP_NAME="$(echo $1 | jq -r '.network_security_group_name')"
    export VM_PUBLIC_IP="$(echo $1 | jq -r '.ip_address.public')"
    export VM_PRIVATE_IP="$(echo $1 | jq -r '.ip_address.private')"
    export VM_SUBNET="$(echo $1 | jq -r '.subnet')"
    export VM_SIZE="$(echo $1 | jq -r '.size')"
}
