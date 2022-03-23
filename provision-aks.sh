#!/bin/bash

rm *.tfstate
terraform init
echo "yes" | terraform apply

# add a sleep after provisioning AKS to let some services settle down
sleep 30