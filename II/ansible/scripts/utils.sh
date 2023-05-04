#!/bin/bash

get_config_files() {
    case "$1" in
    1)
        export VM_CONFIG="../../vm/configs/config1.json"
        export INVENTORY="../inventory/config1.yaml"
        export INVENTORY_FILE="config1.yaml"
        export PLAYBOOK_FILE="deploy1.yaml"
        ;;
    2)
        export VM_CONFIG="../../vm/configs/config2.json"
        export INVENTORY="../inventory/config2.yaml"
        export INVENTORY_FILE="config2.json"
        export PLAYBOOK_FILE="deploy2.yaml"
        ;;
    3)
        export VM_CONFIG="../../vm/configs/config3.json"
        export INVENTORY="../inventory/config3.yaml"
        export INVENTORY_FILE="config3.json"
        export PLAYBOOK_FILE="deploy3.yaml"
        ;;
    5)
        export VM_CONFIG="../../vm/configs/config5.json"
        export INVENTORY="../inventory/config5.yaml"
        export INVENTORY_FILE="config5.json"
        export PLAYBOOK_FILE="deploy5.yaml"
        ;;
    *)
        echo "Invalid config number"
        exit 1
        ;;
    esac
}

get_vm_data() {
    export VM_NAME="$(echo $1 | jq -r '.name')"
    export VM_PUBLIC_IP="$(echo $1 | jq -r '.ip_address.public')"
    export VM_PRIVATE_IP="$(echo $1 | jq -r '.ip_address.private')"
}

get_host() {
    case "$1" in
    Frontend)
        export HOST="front"
        ;;
    Backend)
        export HOST="back"
        ;;
    DB)
        export HOST="db"
        ;;
    *)
        echo "Invalid config number"
        exit 1
        ;;
    esac
}

get_public_ip() {
    export IP="$(az network public-ip show --resource-group "$1" --name "$2" --query ipAddress --output tsv)"
}

inventory_set_user() {
    yq -i '.all.vars.ansible_user = '"\"$1\"" $2
}

inventory_set_public_ip() {
    DOMAIN="$1@$2"
    yq -i '.all.vars.ansible_ssh_common_args = "-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ProxyCommand=\"ssh -W %h:%p -i ~/.ssh/id_rsa '$DOMAIN'\""' $3
}

inventory_set_ansible_host() {
    yq -i '.all.hosts.'"\""$1"\""'.ansible_host = '"\""$2"\"" $3

}