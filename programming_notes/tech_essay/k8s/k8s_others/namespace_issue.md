
How to fix — Kubernetes namespace deleting stuck in Terminating state https://medium.com/@clouddev.guru/how-to-fix-kubernetes-namespace-deleting-stuck-in-terminating-state-5ed75792647e
```sh
Step 1: Dump the descriptor as JSON to a file
``
kubectl get namespace logging -o json > logging.json
``

Open the file for editing:
``
{
    "apiVersion": "v1",
    "kind": "Namespace",
    "metadata": {
        "creationTimestamp": "2019-05-14T13:55:20Z",
        "labels": {
            "name": "logging"
        },
        "name": "logging",
        "resourceVersion": "29571918",
        "selfLink": "/api/v1/namespaces/logging",
        "uid": "e9516a8b-764f-11e9-9621-0a9c41ba9af6"
    },
    "spec": {
        "finalizers": [
            "kubernetes"
        ]
    },
    "status": {
        "phase": "Terminating"
    }
}
``

Remove kubernetes from the finalizers array:
``
{
    "apiVersion": "v1",
    "kind": "Namespace",
    "metadata": {
        "creationTimestamp": "2019-05-14T13:55:20Z",
        "labels": {
            "name": "logging"
        },
        "name": "logging",
        "resourceVersion": "29571918",
        "selfLink": "/api/v1/namespaces/logging",
        "uid": "e9516a8b-764f-11e9-9621-0a9c41ba9af6"
    },
    "spec": {
        "finalizers": [
        ]
    },
    "status": {
        "phase": "Terminating"
    }
}
``

Step 2: Executing our cleanup command
``
kubectl replace --raw "/api/v1/namespaces/logging/finalize" -f ./logging.json
``

Where: `/api/v1/namespaces/<your_namespace_here>/finalize` # 这里logging就是处于Terminating状态一直删不掉的namespace的名称
```
- 回复：
  * > This is not the right way, especially in a production environment. Today I got into the same problem. By removing the finalizer you’ll end up with leftovers in various states. You should actually find what is keeping the deletion from complete.

deleting namespace stuck at "Terminating" state https://github.com/kubernetes/kubernetes/issues/60807

A namespace is stuck in the Terminating state https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.1/troubleshoot/ns_terminating.html
