#!/bin/bash

###################################
##### CI/CD DEPLOYMENT SCRIPT #######
###################################


set -o errexit
set -o nounset
set -o pipefail


export ACCOUNT_ID="651625262782"
export REGION="us-east-1"
CLUSTER_NAME="ecosia-app-development"
export VERSION=${CIRCLE_SHA1}
REGISTRY_URL="${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com"
SERVICE_NAME="sample"
FULL_IMAGE_NAME="${REGISTRY_URL}/${SERVICE_NAME}:${VERSION}"


task_deploy() {
    aws ecr get-login-password \
                                                    --region ${REGION} \
                                                    | docker login \
                                                    --username AWS \
                                                    --password-stdin "${REGISTRY_URL}"
    
    docker build . -t "${FULL_IMAGE_NAME}"
    docker push "${FULL_IMAGE_NAME}"
    envsubst < "k8s/deployment.tpl" > "k8s/config/deployment.yml"
    aws eks --region "${REGION}" update-kubeconfig --name "${CLUSTER_NAME}"
    kubectl apply -f k8s/config
}

task_test() {
  pip install --no-cache-dir pipenv=="2022.3.28"
  pipenv install --dev --system
  python3 -m pytest spec/tests.py
}

main() {
  task=${1:-''}

  if type "task_${task}" >/dev/null 2>&1; then
    "task_${task}" "$@"
  else
    echo "task '${task}' not valid, valid tasks are:

      Usage:
        ./run deploy                   -- Deploy a new application version to Kubernetes
        ./run test                        -- Run the unit tests
      "
          exit 1

  fi
}

main "$@"
