#!/bin/bash

### This is another validation test
### This is similar to a manual test of the st2client being able to get a history of Stackstorm executions
### It should present an ascii table showing successful executions from the previous step (from st2tests)

export ST2CLIENT=$(kubectl get --namespace default pod -l app=st2client,release=stackstorm-aks -o jsonpath="{.items[0].metadata.name}")
kubectl exec -it ${ST2CLIENT} --namespace default -- st2 execution list
