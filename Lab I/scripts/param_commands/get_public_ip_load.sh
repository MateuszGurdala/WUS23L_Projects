IP="$(az network public-ip show --resource-group "$RESOURCE_GROUP" --name "LoadbalancerIP" --query ipAddress --output tsv)"
echo $IP
