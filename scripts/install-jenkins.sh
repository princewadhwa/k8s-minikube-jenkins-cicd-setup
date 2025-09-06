#!/bin/bash
set -e

NAMESPACE=jenkins

kubectl create namespace $NAMESPACE || true

helm upgrade install jenkins ../helm/jenkins --namespace $NAMESPACE --create-namespace -f ../helm/jenkins/values.yaml