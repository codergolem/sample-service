# ECOSIA APP

The ecosia app is a web service that returns a fixed response, someone's favorite tree, on the endpoint "/tree".

The service is a Python flask application that runs on Kubernetes (AWS-EKS) and leverages the ALB-Ingress to expose the service to the Internet.

## Requirements

- Python 3.9
- docker-compose
- [pipenv](https://pipenv.pypa.io/en/latest/install/)
- kubectl
- Access to an AWS-EKS cluster with the ALB-Ingress controller installed to deploy the service.
- An AWS ECR registry to host the docker images.
- Access to Github and Circleci to deploy the circleci project.

## Local Development

To run the service locally use docker-compose:

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

In order to to deploy the service to an EKS-cluster the circle-ci project must have the following env vars available:

"AWS_ACCOUNT_ID" -> The aws account where the EKS cluster is deployed. 
"AWS_DEFAULT_REGION" -> The aws region where the EKS cluster and ECR registry are deployed.
"AWS_ECR_REPOSITORY_NAME" -> The ECR repository name where the images will be published to.
"AWS_CLUSTER_NAME" -> The EKS cluster name to be used.
"AWS_ACCESS_KEY_ID" -> The aws access key.
"AWS_SECRET_ACCESS_KEY" -> The aws secret key.

To run the production deployment push the source code to a GITHUB repository and connect the repository to a circleci project.
The test-build-deploy workflow will run and it will test and deploy the service to Kubernetes.
