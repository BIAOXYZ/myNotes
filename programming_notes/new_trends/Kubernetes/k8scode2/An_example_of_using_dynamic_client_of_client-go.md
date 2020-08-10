
【[:star:][`*`]】 An example of using dynamic client of k8s.io/client-go https://ymmt2005.hatenablog.com/entry/2020/04/14/An_example_of_using_dynamic_client_of_k8s.io/client-go
- > **Background: Server Side Apply**
  * > Recently, I wrote a program that applies Kubernetes resources using [Server Side Apply](https://kubernetes.io/docs/reference/using-api/api-concepts/#server-side-apply). Server Side Apply, or **SSA**, is a new way to create or update resources in Kubernetes API server added as a beta feature to Kubernetes 1.16.
  * > One of the advantage of SSA is that it introduces better patching strategy than [Strategic Merge Patch](https://github.com/kubernetes/community/blob/7c0bf261abe149bf2308c1ec05454d10ad396b57/contributors/devel/sig-api-machinery/strategic-merge-patch.md). For example, if a Service has two ports sharing the same port number but with different protocol, Strategic Merge Patch could not identify which port should be updated because it uses `port` as the key.
  * > When developing a Kubernetes client in Go, the most commonly used package is `k8s.io/client-go`. The package contains two kinds of client library, namely, **dynamic** and **typed**. For SSA, you need to use the dynamic client because you cannot send a partial object using typed clients.
- > **Kubernetes API Basics**
  * > Most of the Kubernetes API are **resources** stored in the API server. Each resource type has a concrete representation in JSON or equivalent YAML called **kind**.
  * > The resources and kinds are grouped and versioned. For example, `deployments` resource is in `apps` group and versioned as `v1`. The kind of `deployments` is [Deployment](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#deployment-v1-apps).
  * > A ***resource type*** can be uniquely identified by a tuple of Group, Version, and Resource (**GVR** for short). Similarly, a ***kind*** can be uniquely identified by a tuple of Group, Version, and Kind (**GVK** for short).
  * > **Mapping between GVK and GVR**
    + > GVR is used to compose a REST API request. For example, a REST API request for `apps`, `v1`, `deployments` looks like:
      ```
      GET /apis/apps/v1/namespaces/{namespace}/deployments/{name}
      ```
    + > By reading JSON or YAML of a resource, you can obtain the GVK for it. If there is a mapping between GVK and GVR, you can send a REST API request of a resource read from YAML. Such a mapping is called ***REST mapping***.
    + > The Kubernetes API server provides a **discovery API** to find all available REST mappings. You can see the human readable result of the discovery API through `kubectl api-resources` output as follows:
- > **Go client libraries**
  * > **Typed clients**
    + > This kind of clients uses Go structs to represent a kind. You can edit resources in a type-safe way with them. Moreover, they can automatically find the REST mappings to send API requests. Following is an example of using a typed client to create a Deployment resource.
