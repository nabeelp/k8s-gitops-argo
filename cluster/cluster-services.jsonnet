function (
    repoUrl="$ARGOCD_APP_SOURCE_REPO_URL",
    branchName="$ARGOCD_APP_SOURCE_TARGET_REVISION"
)
[
{
    "apiVersion": "argoproj.io/v1alpha1",
    "kind": "Application",
    "metadata": {
        "annotations": {
            "argocd.argoproj.io/sync-wave": "-1"
        },
        "name": "dapr"
    },
    "spec": {
        "destination": {
            "namespace": "dapr",
            "server": "https://kubernetes.default.svc"
        },
        "project": "cluster-services",
        "sources": [
            {
                "chart": "dapr",
                "helm": {
                    "valueFiles": [
                        "$myRepo/cluster/dapr/values.yaml"
                    ]
                },
                "repoURL": "https://dapr.github.io/helm-charts/",
                "targetRevision": "1.10.3"
            },
            {
                "repoURL": repoUrl,
                "targetRevision": branchName,
                "ref": "myRepo"
            }
        ],
        "syncPolicy": {
            "automated": {},
            "syncOptions": [
                "CreateNamespace=true",
                "ServerSideApply=true"
            ]
        }
    }
}
]