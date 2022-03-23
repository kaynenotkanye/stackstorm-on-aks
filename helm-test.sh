#!/bin/bash

# This will run integration tests as a sidecar container in AKS
# The integration tests perform a subset of st2tests,
# Found here: https://github.com/StackStorm/st2tests
helm test stackstorm-aks