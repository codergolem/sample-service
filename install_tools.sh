#!/bin/bash

#############
## AWS CLI ###
############
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

##############
### envsubst ###
##############

apt-get -y update && apt-get install -y --no-install-recommends gettext


##############
### kubectl #####
##############

KUBECTL_VERSION="v1.22.0"
KUBECTL_DOWNLOAD_URL="https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"

curl -LO \
                "${KUBECTL_DOWNLOAD_URL}" \
                && chmod u+x ./kubectl \
                && mv ./kubectl /usr/local/bin/kubectl