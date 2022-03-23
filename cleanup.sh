#!/bin/bash

echo "yes" | terraform destroy

rm terraform.tfstate
rm terraform.tfstate.backup

