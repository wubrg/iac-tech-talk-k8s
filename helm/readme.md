# Helm Example

This folder contains a simple nginx hello world example showcasing the basics of helm.

Below are instructions to run this locally on a mac with docker for desktop kubernetes cluster.

## Requirements

- docker for desktop with kubernetes enabled
- kubectl
- helm

## Instructions to run

- `helm install ./helloworld --generate-name`
- `helm list`
- open browser at http://localhost:30082/
- view helmly hello world text
