#!/bin/bash

RESOURCE_GROUP_NAME="WUS_LAB3"
CLUSTER_NAME="WUSk82"

# create resource group
az group create --name $RESOURCE_GROUP_NAME --location westeurope

# create aks cluster
az aks create --resource-group $RESOURCE_GROUP_NAME \
    --name $CLUSTER_NAME \
    --enable-managed-identity \
    --node-count 2 \
    --generate-ssh-keys

az aks get-credentials \
    --resource-group $RESOURCE_GROUP_NAME \
    --name $CLUSTER_NAME

kubectl get nodes

# deploy spring-petclinic-cloud
cd spring-petclinic-cloud/

kubectl apply -f k8s/init-namespace
kubectl apply -f k8s/init-services

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm search repo bitnami

helm upgrade -i vets-db-mysql bitnami/mysql --namespace spring-petclinic --version 9.4.6 --set auth.database=service_instance_db
helm upgrade -i visits-db-mysql bitnami/mysql --namespace spring-petclinic  --version 9.4.6 --set auth.database=service_instance_db
helm upgrade -i customers-db-mysql bitnami/mysql --namespace spring-petclinic  --version 9.4.6 --set auth.database=service_instance_db

# spingcommunity repository on dockerhub:
# https://hub.docker.com/u/springcommunity
export REPOSITORY_PREFIX=springcommunity

./scripts/deployToKubernetes.sh

kubectl get svc -n spring-petclinic api-gateway
