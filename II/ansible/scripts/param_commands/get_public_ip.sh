PUBLIC_IP="$(az network public-ip show --resource-group "$RESOURCE_GROUP" --name "FrontendIP" --query ipAddress --output tsv)"
echo $PUBLIC_IP
