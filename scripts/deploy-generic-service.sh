#!/bin/bash
set -e

ENV=$1
IMAGE_TAG=$2
APP_NAME=$3

CHART_PATH="../k8s/charts/generic-service"
VALUES_FILE="../k8s/values/${ENV}/${APP_NAME}.yaml"

if [[ -z "$ENV" ]]; then
  echo "ENV is empty"
  exit 1
fi

if [[ -z "$IMAGE_TAG" ]]; then
  echo "IMAGE_TAG is empty"
  exit 1
fi

if [[ -z "$APP_NAME" ]]; then
  echo "APP_NAME is empty"
  exit 1
fi

if [[ -z "$NAMESPACE" ]]; then
  echo "NAMESPACE environment variable is not set"
  exit 1
fi

if ! kubectl get ns "${NAMESPACE}" >/dev/null 2>&1; then
  echo "📦 Create namespace ${NAMESPACE}"
  kubectl create ns "${NAMESPACE}"
fi

echo "Deploy tag ${IMAGE_TAG} to ${APP_NAME} in ${ENV}"

helm upgrade --install "${APP_NAME}" "${CHART_PATH}" \
  --namespace "${NAMESPACE}" \
  -f "${VALUES_FILE}" \
  --atomic \
  --timeout 5m \
  --set image.tag="$IMAGE_TAG"

echo "Deploy ${APP_NAME} done"