# Kustomize Example

This folder contains a simple nginx hello world example showcasing the basics of kustomize.

Below are instructions to run this locally on a mac with docker for desktop kubernetes cluster.

## Requirements

- docker for desktop with kubernetes enabled
- kubectl

## Instructions to run

- `kustomize build -f kustomization.yaml > rendered.yaml`
- `kubectl apply -f rendered.yaml`
- open browser at http://localhost:30080/
- view kustomized hello world text
