#!/bin/bash

# Skipping helm repo add because I already have it in my cache...
# helm repo add stackstorm https://helm.stackstorm.com/
helm install stackstorm-aks stackstorm/stackstorm-ha
# Adding a sleep after helm install to let services settle down...
sleep 30
