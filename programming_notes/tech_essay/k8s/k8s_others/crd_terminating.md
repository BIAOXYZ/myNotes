
Not able to completely remove Kubernetes CustomResource https://stackoverflow.com/questions/52009124/not-able-to-completely-remove-kubernetes-customresource
- > Custom resources with finalizers can "deadlock" customresourcecleanup.apiextensions.k8s.io finalizer https://github.com/kubernetes/kubernetes/issues/60538
  ```sh
  # remove the CRD finalizer blocking on custom resource cleanup
  kubectl patch crd/crontabs.stable.example.com -p '{"metadata":{"finalizers":[]}}' --type=merge
  ```
- > Worked like a charm! Thank you! `kubectl patch crd/MY_CRD_NAME -p '{"metadata":{"finalizers":[]}}' --type=merge`

Namespace Issues when Removing CRD/Operators https://blog.2vcps.io/2019/04/19/namespace-issues-when-removing-crd-operators/
