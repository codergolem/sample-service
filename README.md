# ECOSIA APP

The ecosia app is a web service that returns a fixed response, someone's favorite tree, on the endpoint "/tree".

The service is a Python flask application that runs on Kubernetes (AWS-EKS) and leverages the ALB-Ingress to expose the service to the Internet.

## Requirements

- Python 3.9
- docker-compose
- [pipenv](https://pipenv.pypa.io/en/latest/install/)
- kubectl
- Access to an AWS-EKS cluster with the ALB-Ingress controller installed.
- Access to Github and Circleci to deploy the circleci project.

## Local Development

To test the service use docker-compose:

```bash
docker-compose up -d
```

The service will be available on: "http://localhost:8080/tree"

## Testing

Initiate a pipenv shell session and install the required packages:
```bash
pipenv shell
pipenv install --dev
```
### Unit Tests
To run the unit tests execute:
```bash
python3 -m pytest spec/tests.py
```

### Functional Tests
To run the functional tests first start docker-compose as mentioned above and then run:
```bash
python3 -m pytest spec/functional_tests.py
```

## Production Deployment

In order to to deploy the service to an EKS-cluster the deployment script must be configured to use the corresponding AWS account and region, for this edit the ```run``` script as shown below:
```bash
set -o errexit
set -o nounset
set -o pipefail

export ACCOUNT_ID="<INSERT-YOUR-AWS-ACCOUNT-ID-HERE>"
export REGION="<INSERT-THE-AWS-REGION-HERE>"
CLUSTER_NAME="<INSERT-THE-CLUSTER-TO-BE-USED-HERE>"
```
Then push the source code to a GITHUB repository and connect the repository to a circleci project.
The test-build-deploy workflow will run and it will test and deploy the service to Kubernetes.

**IMPORTANT**: This setup assumes the circleci project has been provisioned with their corresponding AWS credentials to deploy the service to Kubernetes.
Configure the credentials by passing them as [env vars]([https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html) to the circleci project.