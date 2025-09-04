#!/bin/bash
set -e

NAMESPACE=jenkins

kubectl create namespace $NAMESPACE || true

helm install jenkins ../helm/jenkins --namespace $NAMESPACE --create-namespace