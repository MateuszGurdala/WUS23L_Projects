#!/bin/bash

set -euxo pipefail


RESOURCE_GROUP="WUS_LAB3"

# Login
az login

# Delete
az group delete --name $RESOURCE_GROUP --yes --no-wait

az group delete --name NetworkWatcherRG --yes --no-wait

# az group delete --name DefaultResourceGroup-WEU --yes --no-wait

