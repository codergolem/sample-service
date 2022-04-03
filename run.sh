#!/bin/bash

###################################
##### CI/CD DEPLOYMENT SCRIPT #######
###################################


set -o errexit
set -o nounset
set -o pipefail

REGION="us-east-1"
ACCOUNT_ID="651625262782"
REGISTRY_URL="${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com"
SERVICE_NAME="sample"
VERSION="1"
FULL_IMAGE_NAME="${REGISTRY_URL}/${SERVICE_NAME}:${VERSION}"


task_update() {
    aws ecr get-login-password \
                                                    --region ${REGION} \
                                                    | docker login \
                                                    --username AWS \
                                                    --password-stdin "${REGISTRY_URL}"
    
    docker build . -t "${FULL_IMAGE_NAME}"
    docker push "${FULL_IMAGE_NAME}"
    # kubectl apply -f service.yml
}

task_infra() {
    cd infra
    terraform init
    terraform apply
}

task_deploy() {
  task_infra
  task_update
}

main() {
  task=${1:-''}

  if type "task_${task}" >/dev/null 2>&1; then
    "task_${task}" "$@"
  else
    echo "task '${task}' not valid, valid tasks are:

      Usage:
        ./run update                    -- Deploy a new application version to Kubernetes
        ./run deploy                     
        -- Deploy the entire infrastructure and application stack
      "
          exit 1

  fi
}

main "$@"
