
Kubernetes Security 101: Risks and 29 Best Practices https://www.stackrox.com/post/2020/05/kubernetes-security-101/

Managing the Security of Kubernetes Container Workloads https://www.giantswarm.io/blog/managing-the-security-of-kubernetes-container-workloads
- > Kubernetes has an in-built ImagePolicyWebhook admission controller for this purpose, which relies on an external backend to authorize the use of the images defined for a Pod’s containers. When configured appropriately - before a pod is admitted to the cluster - the backend is sent an ImageReview object containing the details of the container images, which it allows or disallows based on the policy it’s configured with.
