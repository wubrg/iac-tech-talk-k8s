# Terraform Example

This folder contains a simple nginx hello world example showcasing the basics of kubernetes with terraform.

Below are instructions to run this locally on a mac with docker for desktop kubernetes cluster.

## Requirements

- docker for desktop with kubernetes enabled
- kubectl
- terraform
- tfenv

## Instructions to run

- edit variables file with new values
- `terraform init`
- `terraform apply`
- open browser at http://localhost:30081/
- view custom terraformed hello world text
