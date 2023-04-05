# Cluster specific configurations and notes

This folder contains the `common` services that are deployed to all environments. These services are deployed using ArgoCD and the `ApplicationSet` CRD.

## Environment specifics for common services

As ArgoCD does not interpret environment variables like `$ARGOCD_APP_SOURCE_TARGET_REVISION` when executing the Git Generator, each environment will need its own directory (e.g. dev) with an `ApplicatinSet` yaml within that. 

Within the `ApplicationSet` yaml, the values for the `spec.generators.get.revision` node and the **second** `spec.template.spec.sources.targetRevision` will need to be set to the name of the branch that relates to the environment. So, for the dev environment, the values would be `development` and for the production environment, this would be `main`.

Where you have a helm chart where you need to set different values for the dev enviornment from the values used for the prod environemnt, but you also have common values for both, you can use the following:

- values.yaml for the common values
- values-dev.yaml for the dev specific values
- values-prod.yaml for the prod specific values
