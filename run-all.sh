#!/bin/bash

### This script is not used in the Github Actions pipeline
### It may be used if you want to provision/deploy locally
### It's basically a wrapper to run all provisioning scripts

SLEEP_TIME=30
START_TIME=$(date)
START_CALC=$SECONDS

echo "Starting: $START_TIME"
echo "$START_CALC"

echo "Provisioning AKS via Terraform..."
./provision-aks.sh
sleep $SLEEP_TIME

echo "Retrieve kube config and get info on pods..."
./post-provision.sh

echo "Perform helm repo add and helm install..."
./helm-deploy.sh
sleep $SLEEP_TIME

echo "Perform integration tests..."
./helm-test.sh

kubectl get pods -A | grep st2client

echo "Final validation with st2client"
./st2client-validate.sh

END_TIME=$(date)
echo "Started:   $START_TIME"
echo "Completed: $END_TIME"
END_CALC=$SECONDS

ELAPSED_TIME=$(( END_CALC - START_CALC ))
# ((hour=$ELAPSED_TIME/3600))
((mins=($ELAPSED_TIME-hour*3600)/60))
((sec=$ELAPSED_TIME-((hour*3600) + (mins*60))))
printf "Total elapsed time(mm:ss): %02d:%02d\n" "$mins" "$sec"
