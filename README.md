This repository help operate Airflow

# Prerequisites
1. [just](https://github.com/casey/just)
2. [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
3. [gcloud](https://cloud.google.com/sdk/docs/install), required if you need to set up GKE workload identity.

# Ariflow Operator Overview
We use [Airflow's official helm chart](https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml) to generate the yaml files,
then we use kustomize to overwrite environment specific variables.
## base
1. update resource helm hook to argocd hook.
2. specify the base values.yaml
## overlays
1. production: overwrite connection string to its corresponding Cloud SQL's connection string.
2. develop: overwrite connection string to its corresponding Cloud SQL's connection string, and update dags sync branch to develop.
3. office: overwrite connection string to its corresponding managed SQL connection string, and update dags sync branch to develop.
   IaC for deploying sql can be found [here](https://source.mobagel.com/8ndpoint/infra/k8s-chart/-/tree/master/posgresql).
## cd
this folder is generating argocd deployed application spec
1. cd/base: create repo spec connecting to airflow-cd and dags.
2. cd/overlays: create application's declarative spec for corresponding environment, and setup proper cluster credential if needed.

# Quick Start
## Argo CD
1. connect kubectl to the cluster you want to deploy argocd application (i.e., the argocd cluster).
2. `just argo-deploy gke`
