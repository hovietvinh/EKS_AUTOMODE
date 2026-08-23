#!/bin/bash
set -e

export ENV=$1

# 1. ingress-nginx-controller
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx \
  -n ingress-nginx --create-namespace \
  -f ../k8s/addons/ingress-nginx/values-base.yaml \
  -f ../k8s/addons/ingress-nginx/values-${ENV}.yaml

# 2. root-ingress alb
if [ -z "$CERTIFICATE_ARN" ] || [ -z "$SUBNET_IDS" ]; then
  echo "CERTIFICATE_ARN or SUBNET_IDS is not set, aborting"
  exit 1
fi

RENDERED_VALUES=$(mktemp)
envsubst '${CERTIFICATE_ARN} ${SUBNET_IDS}' < ../k8s/addons/root-ingress/values-${ENV}.yaml > "$RENDERED_VALUES"

helm upgrade --install root-ingress ../k8s/addons/root-ingress \
  -n ingress-nginx \
  -f ../k8s/addons/root-ingress/values-base.yaml \
  -f "$RENDERED_VALUES"

rm -f "$RENDERED_VALUES"

helm repo add external-dns https://kubernetes-sigs.github.io/external-dns/
helm repo update

helm upgrade --install external-dns external-dns/external-dns \
  -n external-dns --create-namespace \
  -f ../k8s/addons/external-dns/values-base.yaml \
  -f ../k8s/addons/external-dns/values-${ENV}.yaml
