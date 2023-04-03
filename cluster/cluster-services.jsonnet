function (
    containerPort=80, 
    image="gcr.io/heptio-images/ks-guestbook-demo:0.2", 
    name="jsonnet-guestbook-ui",
    replicas=1,
    servicePort=80, 
    type="LoadBalancer"
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
                "repoURL": "$ARGOCD_APP_SOURCE_REPO_URL",
                "targetRevision": "$ARGOCD_APP_SOURCE_TARGET_REVISION",
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