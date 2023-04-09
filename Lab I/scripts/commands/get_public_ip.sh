IP="$(az network public-ip show --resource-group "$RESOURCE_GROUP" --name "BackendIP" --query ipAddress --output tsv)"
echo $IP