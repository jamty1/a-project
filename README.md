# MLflow AWS deployment (EC2, RDS, S3)
## Overview
This is a proof-of-concept deployment to deploy an MLflow server in AWS using EC2, RDS, and S3

![Deployment Diagram](./diagram.png)

## Prerequisites
You need to have the following installed:
* AWS CLI \([Download](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)\)
* Terraform \([Download](https://www.terraform.io/downloads)\)

## Usage
To start the deployment, simply execute the `init.sh` file.

You will be prompted to input a database username and password.  Simply leaving it as blank will input the default values instead.

If all setup is done properly, Terraform will build start building the infrastructure in AWS and automatically deploy the MLflow server.
