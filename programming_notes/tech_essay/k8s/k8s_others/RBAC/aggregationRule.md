
# 1

kubernetes笔记: RBAC鉴权 https://ieevee.com/tech/2018/05/05/k8s-rbac.html#aggregated-clusterroles
- > 1.9版本以后，可以用 `aggregationRule` 来聚合其他 `ClusterRole`，从而创建一个新的具有更多权限的 `ClusterRole`。聚合的方法是通过 `matchLabels`（即 `rbac.example.com/aggregate-to-monitoring: "true"`），来匹配所有 `metadata` 符合该label的 `ClusterRole`。`aggregationRule` 不需要配置 `rules` 段，它是由controller收集所有匹配的ClusterRole的rules后填充的。
  ```yaml
  kind: ClusterRole
  apiVersion: rbac.authorization.k8s.io/v1
  metadata:
    name: monitoring
  aggregationRule:
    clusterRoleSelectors:
    - matchLabels:
        rbac.example.com/aggregate-to-monitoring: "true"
  rules: [] # Rules are automatically filled in by the controller manager.
  ```
- > 注意，***创建新的符合 `matchLabel` 的 `clusterRole`，controller会将新的rules添加到 `aggregationRule`***。如下会将 ***monitoring-endpoints*** 的rules添加到上面的`ClusterRole` ***monitoring***。
- > 注：之所以要设计这么个功能，可能是为了进一步简化配置，例如要给整个集群配置管理员，这样只要给用户授予一个ClusterRole就可以了。
  ```yaml
  kind: ClusterRole
  apiVersion: rbac.authorization.k8s.io/v1
  metadata:
    name: monitoring-endpoints
    labels:
      rbac.example.com/aggregate-to-monitoring: "true"
  # These rules will be added to the "monitoring" role.
  rules:
  - apiGroups: [""]
    Resources: ["services", "endpoints", "pods"]
    verbs: ["get", "list", "watch"]
  ```
- > 默认的面向用户的role使用了aggregationRule。这样admin可以自动拥有 CustomResourceDefinitions CRD的权限。
- > 如下，集群范围内的 `ClusterRole` ***admin*** 会聚合所有label为 `rbac.authorization.k8s.io/aggregate-to-admin: "true"` 的ClusterRole，而 ***view*** 则会聚合所有label为 `rbac.authorization.k8s.io/aggregate-to-view: "true"` 的 `ClusterRole`。
  ```yaml
  apiVersion: rbac.authorization.k8s.io/v1
  kind: ClusterRole
  metadata:
    name: admin
    annotations:
      rbac.authorization.kubernetes.io/autoupdate: "true"
    labels:
      kubernetes.io/bootstrapping: rbac-defaults
  aggregationRule:
    clusterRoleSelectors:
    - matchLabels:
        rbac.authorization.k8s.io/aggregate-to-admin: "true"
  ---
  apiVersion: rbac.authorization.k8s.io/v1
  kind: ClusterRole
  metadata:
    name: view
    annotations:
      rbac.authorization.kubernetes.io/autoupdate: "true"
    labels:
      kubernetes.io/bootstrapping: rbac-defaults
  aggregationRule:
    clusterRoleSelectors:
    - matchLabels:
        rbac.authorization.k8s.io/aggregate-to-view: "true"
  ```
- > 例如下面这两个。
  ```yaml
  kind: ClusterRole
  apiVersion: rbac.authorization.k8s.io/v1
  metadata:
    name: aggregate-cron-tabs-edit
    labels:
      # Add these permissions to the "admin" and "edit" default roles.
      rbac.authorization.k8s.io/aggregate-to-admin: "true"
      rbac.authorization.k8s.io/aggregate-to-edit: "true"
  rules:
  - apiGroups: ["stable.example.com"]
    resources: ["crontabs"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
  ---
  kind: ClusterRole
  apiVersion: rbac.authorization.k8s.io/v1
  metadata:
    name: aggregate-cron-tabs-view
    labels:
      # Add these permissions to the "view" default role.
      rbac.authorization.k8s.io/aggregate-to-view: "true"
  rules:
  - apiGroups: ["stable.example.com"]
    resources: ["crontabs"]
    verbs: ["get", "list", "watch"]
  ```

Kubernetes RBAC 101: authorization https://www.cncf.io/blog/2020/08/28/kubernetes-rbac-101-authorization/
- > You must specify an aggregation rule for your cluster role which is essentially a set of label matching rules.  Kubernetes will then find all cluster roles that match those label matching rules and aggregate them into this Cluster Role dynamically. You can add and remove matching cluster roles and the aggregated cluster role will change the set of permissions accordingly — very useful for predefined cluster roles (we’ll come back to that in a bit).
  ```yaml
  apiVersion: rbac.authorization.k8s.io/v1
  kind: ClusterRole
  metadata:
    name: aggregatedClusterRole1
  aggregationRule:
    clusterRoleSelectors:
    - matchLabels:
        label1: value1
  # The control plane automatically fills in the rules
  rules: []
  ```
  > ![](https://kublr.com/wp-content/uploads/2020/08/Screen-Shot-2020-08-13-at-11.17.56-AM.png)
