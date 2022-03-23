#!/bin/bash

# The regular cleanup.sh is actually the more proper way...
# but it can take Azure 8-10 minutes to tear everything down

# alt-cleanup.sh will delete my resource groups and now
# I don't have to wait (yay!). Downside is there is no confirmation
rm terraform.tfstate
az group delete -n MC_kayne-aks-rg_kayne-st2-aks_eastus --no-wait --yes
az group delete -n kayne-aks-rg --no-wait --yes
