#!/bin/bash

rm ~/.kube/config
az aks get-credentials --resource-group kayne-aks-rg --name kayne-st2-aks
kubectl get pods -A