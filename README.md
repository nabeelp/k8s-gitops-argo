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
kubectl apply -n argocd -f cluster/dev/
```

To setup a PROD cluster, run the following:

```bash
kubectl apply -n argocd -f cluster/prod/
```

### Step 3: Setup ArgoCD Ingress and login to ArgoCD UI

This involves creating an Ingress rule and then retrieving the intial ArgoCD password.

```bash
kubectl apply -n argocd -f cluster/common/traefik/argocd-ingress.yaml
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

Navigate to your cluster by taking the following URL and replacing the text "<cluster-ip-or-fqdn>" with the relevant value for your cluster. Once the login page displays, use the username of `admin` and the password returned from the last command above.