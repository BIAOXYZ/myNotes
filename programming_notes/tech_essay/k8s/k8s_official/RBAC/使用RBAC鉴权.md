
Using RBAC Authorization https://kubernetes.io/docs/reference/access-authn-authz/rbac/ || 使用 RBAC 鉴权 https://v1-18.docs.kubernetes.io/zh/docs/reference/access-authn-authz/rbac/
- > **RoleBinding 示例**
  * > 一个 RoleBinding 可以引用同一的名字空间中的任何 Role。 或者，***一个 RoleBinding 可以引用某 ClusterRole 并将该 ClusterRole 绑定到 RoleBinding 所在的名字空间***。 如果你希望将某 ClusterRole 绑定到集群中所有名字空间，你要使用 ClusterRoleBinding。
- > 创建了绑定之后，你不能再修改绑定对象所引用的 Role 或 ClusterRole。 试图改变绑定对象的 `roleRef` 将导致合法性检查错误。 如果你想要改变现有绑定对象中 `roleRef` 字段的内容，必须删除重新创建绑定对象。
- > 这种限制有两个主要原因：
  * > 将 `roleRef` 设置为不可以改变，这使得可以为用户授予对现有绑定对象的 `update` 权限， 这样可以让他们管理主体列表，同时不能更改被授予这些主体的角色。
  * > 针对不同角色的绑定是完全不一样的绑定。要求通过删除/重建绑定来更改 `roleRef`, 这样可以确保要赋予绑定的所有主体会被授予新的角色（而不是在允许或者不小心修改 了 `roleRef` 的情况下导致所有现有主体未经验证即被授予新角色对应的权限）。
- > 命令 `kubectl auth reconcile` 可以创建或者更新包含 RBAC 对象的清单文件， 并且在必要的情况下删除和重新创建绑定对象，以改变所引用的角色。 更多相关信息请参照命令用法和示例
- > **对资源的引用**
  * > 对于某些请求，也可以通过 `resourceNames` 列表按名称引用资源。 在指定时，可以将请求限定为资源的单个实例。 下面的例子中限制可以 "get" 和 "update" 一个名为 `my-configmap` 的 ConfigMap：
    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: Role
    metadata:
      namespace: default
      name: configmap-updater
    rules:
    - apiGroups: [""]
      # 在 HTTP 层面，用来访问 ConfigMap 资源的名称为 "configmaps"
      resources: ["configmaps"]
      resourceNames: ["my-configmap"]
      verbs: ["update", "get"]
    ```
    > **说明**：你不能使用资源名字来限制 `create` 或者 `deletecollection` 请求。 对于 `create` 请求而言，这是因为在鉴权时可能还不知道新对象的名字。如果你使用 resourceName 来限制 `list` 或者 `watch` 请求， 客户端必须在它们的 `list` 或者 `watch` 请求里包含一个与指定的 resourceName 匹配的 `metadata.name` 字段选择器。 例如，`kubectl get configmaps --field-selector=metadata.name=my-configmap`
- > **聚合的 ClusterRole**【**Aggregated ClusterRoles**】
  * > 你可以将若干 ClusterRole **聚合（Aggregate）** 起来，形成一个复合的 ClusterRole。 某个控制器作为集群控制面的一部分会监视带有 aggregationRule 的 ClusterRole 对象集合。aggregationRule 为控制器定义一个标签 选择算符供后者匹配 应该组合到当前 ClusterRole 的 roles 字段中的 ClusterRole 对象。
  * > 下面是一个聚合 ClusterRole 的示例：
    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRole
    metadata:
      name: monitoring
    aggregationRule:
      clusterRoleSelectors:
      - matchLabels:
          rbac.example.com/aggregate-to-monitoring: "true"
    rules: [] # 控制面自动填充这里的规则
    ```
  * > ***如果你创建一个与某个已存在的聚合 ClusterRole 的标签选择算符匹配的 ClusterRole， 这一变化会触发新的规则被添加到聚合 ClusterRole 的操作***。下面的例子中，通过创建一个标签同样为 `rbac.example.com/aggregate-to-monitoring: true` 的 ClusterRole，新的规则可被添加到 "monitoring" ClusterRole 中。
    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRole
    metadata:
      name: monitoring-endpoints
      labels:
        rbac.example.com/aggregate-to-monitoring: "true"
    # 当你创建 "monitoring-endpoints" ClusterRole 时，
    # 下面的规则会被添加到 "monitoring" ClusterRole 中
    rules:
    - apiGroups: [""]
      resources: ["services", "endpoints", "pods"]
      verbs: ["get", "list", "watch"]
    ```
- > **对主体的引用**
  * > RoleBinding 或者 ClusterRoleBinding 可绑定角色到某 **主体（Subject）** 上。 主体可以是组，用户或者 服务账户。
  * > Kubernetes 用字符串来表示用户名。 用户名可以是普通的用户名，像 "alice"；或者是邮件风格的名称，如 "bob@example.com"， 或者是以字符串形式表达的数字 ID。 你作为 Kubernetes 管理员负责配置 [身份认证模块](https://kubernetes.io/zh/docs/reference/access-authn-authz/authentication/) 以便后者能够生成你所期望的格式的用户名。
  * > 注意：前缀 `system:` 是 Kubernetes 系统保留的，所以你要确保 所配置的用户名或者组名不能出现上述 `system:` 前缀。 除了对前缀的限制之外，RBAC 鉴权系统不对用户名格式作任何要求。
  * > 在 Kubernetes 中，鉴权模块提供用户组信息。 与用户名一样，用户组名也用字符串来表示，而且对该字符串没有格式要求，只是不能使用保留的前缀 `system:`。
  * > [服务账户](https://kubernetes.io/zh/docs/tasks/configure-pod-container/configure-service-account/) 的用户名前缀为 `system:serviceaccount:`，属于前缀为 `system:serviceaccounts:` 的用户组。
- > **默认 Roles 和 Role Bindings**
  * > API 服务器创建一组默认的 ClusterRole 和 ClusterRoleBinding 对象。 这其中许多是以 `system:` 为前缀的，用以标识对应资源是直接由集群控制面管理的。 所有的默认 ClusterRole 和 ClusterRoleBinding 都有 `kubernetes.io/bootstrapping=rbac-defaults` 标签。
