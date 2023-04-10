# k8s-gitops-argo

Kubernetes GitOps repo based on Argo

## Getting started

To get ArgoCD and teh cluster services and related applications installed on a cluster, perform the following steps:

### Step 1: Install ArgoCD

To install ArgoCD into the current clsuter context, execute the following:

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### Step 2: Install cluster services for DEV or PROD

Depending on whether you are setting up a DEV or a PROD cluster, execute one of the following commands. The DEV cluster resources use less resources as they exclude services typically involved in cluster management.

To setup a DEV cluster, run the following:

```bash
kubectl apply -n argocd -f cluster/dev/cluster-applicationset-dev.yaml
```

To setup a PROD cluster, run the following:

```bash
kubectl apply -n argocd -f cluster/prod/cluster-applicationset-prod.yaml
```

