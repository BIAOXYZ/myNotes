
# 环境

https://www.katacoda.com/courses/kubernetes/launch-single-node-cluster

# 过程

```sh
cat << 1234 > demo.sh
#!/bin/bash
mkdir demo
cd demo

function echostar()
{
    echo -e "****************************************************************************************************"
}

function printmsgwithcolor()
{
    printf "\033[43;34m $1 \033[0m \n"
}
# printmsgwithcolor "test msg color"


echostar
echo -e "\033[43;34m Start to prepare essential manifests. \033[0m"
echostar
echo -e "\n"

################################################## For sa, clusterrole, clusterrolebinding 
cat << EOF > sarole.yaml
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: scaler-operator
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  creationTimestamp: null
  name: scaler-operator
rules:
- apiGroups:
  - '*'
  resources:
  - '*'
  verbs:
  - '*'
---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: scaler-operator
subjects:
- kind: ServiceAccount
  name: scaler-operator
  ##namespace: scaler-operator
  namespace: default
roleRef:
  kind: ClusterRole
  name: scaler-operator
  apiGroup: rbac.authorization.k8s.io
EOF
##################################################

################################################## For CRD
cat << EOF > scalerop_v1_scaler_crd.yaml
apiVersion: apiextensions.k8s.io/v1beta1
kind: CustomResourceDefinition
metadata:
  name: scalers.scalerop.com
spec:
  group: scalerop.com
  names:
    kind: Scaler
    listKind: ScalerList
    plural: scalers
    singular: scaler
  scope: Namespaced
  subresources:
    status: {}
  version: v1
  versions:
  - name: v1
    served: true
    storage: true
EOF
##################################################

################################################## For operator
cat << EOF > operator.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: scaler-operator
spec:
  replicas: 1
  selector:
    matchLabels:
      name: scaler-operator
  template:
    metadata:
      labels:
        name: scaler-operator
    spec:
      serviceAccountName: scaler-operator
      containers:
        - name: ansible
          command:
          - /usr/local/bin/ao-logs
          - /tmp/ansible-operator/runner
          - stdout
          # Replace this with the built image name
          image: "biaoxyz/scaler-operator:v2"
          imagePullPolicy: "Always"
          volumeMounts:
          - mountPath: /tmp/ansible-operator/runner
            name: runner
            readOnly: true
        - name: operator
          # Replace this with the built image name
          image: "biaoxyz/scaler-operator:v2"
          imagePullPolicy: "Always"
          volumeMounts:
          - mountPath: /tmp/ansible-operator/runner
            name: runner
          env:
            - name: WATCH_NAMESPACE
              valueFrom:
                fieldRef:
                  fieldPath: metadata.namespace
            - name: POD_NAME
              valueFrom:
                fieldRef:
                  fieldPath: metadata.name
            - name: OPERATOR_NAME
              value: "scaler-operator"
      volumes:
        - name: runner
          emptyDir: {}
EOF
##################################################

################################################## For CRs
cat << EOF > scalerop_v1_scaler_cr.yaml
apiVersion: scalerop.com/v1
kind: Scaler
metadata:
  ##name: example-scaler
  name: scaler-cr-nginx
spec:
  # Add fields here
  size: 3
  appname: nginx
  appnamespace: default
EOF

cat << EOF > scalerop_v1_scaler_cr2.yaml
apiVersion: scalerop.com/v1
kind: Scaler
metadata:
  name: scaler-cr-wordpress
spec:
  # Add fields here
  size: 4
  appname: wordpress
  appnamespace: default
EOF
##################################################


##########----------After manifests----------##########

echostar
echo -e "\033[43;34m Manifests are all prepared. Demo starts! \033[0m"
echostar
echo -e "\n"

echostar
echo -e "\033[43;34m First create essential objects: sa, clusterrole, clusterrolebinding, CRD and operator itself. \033[0m"
echostar
kubectl create -f sarole.yaml
kubectl create -f scalerop_v1_scaler_crd.yaml
kubectl create -f operator.yaml
sleep 15
echo -e "\n"

echostar
echo -e "\033[43;34m At that time, we have no workload (except the operator itself). \033[0m"
echostar
kubectl get pod
echo -e "\n"

echostar
echo -e "\033[43;34m After we create two CR (CRD instance), we have 3 nginx pods and 4 wordpress pods. \033[0m"
echostar
kubectl create -f scalerop_v1_scaler_cr.yaml
kubectl create -f scalerop_v1_scaler_cr2.yaml
sleep 15
kubectl get pod | grep nginx
kubectl get pod | grep wordpress
echo -e "\n"

echostar
echo -e "\033[43;34m We try to scale up nginx pods to 5, the operator will watch and do this automatically. \033[0m"
echostar
sed -i "s|size: 3|size: 5|g" scalerop_v1_scaler_cr.yaml
kubectl apply -f scalerop_v1_scaler_cr.yaml
sleep 25
kubectl get pod | grep nginx
echo -e "\n"

echostar
echo -e "\033[43;34m The operator can also be used to scale down different kinds of workload, here, wordpress. \033[0m"
echostar
sed -i "s|size: 4|size: 2|g" scalerop_v1_scaler_cr2.yaml
kubectl apply -f scalerop_v1_scaler_cr2.yaml
sleep 25
kubectl get pod | grep wordpress
echo -e "\n"

echostar
echo -e "\033[43;34m Clear the environment \033[0m"
echostar
### echo -e "\033[43;34m黄底蓝字\033[0m"
cd ..
kubectl delete -f demo/sarole.yaml
kubectl delete -f demo/operator.yaml
kubectl delete -f demo/scalerop_v1_scaler_crd.yaml
rm -rf demo/ demo.sh
1234

chmod 755 demo.sh && ./demo.sh
```

# 结果
***// 注意，所有两行星号之间的文字实际上是有颜色的（黄底蓝字），只是github的markdown显示不出来。。。***

```console
...
...
//上述脚本的绝大部分内容省略
...
...
> 1234
$
$ chmod 755 demo.sh && ./demo.sh
****************************************************************************************************
 Start to prepare essential manifests.
****************************************************************************************************


****************************************************************************************************
 Manifests are all prepared. Demo starts!
****************************************************************************************************


****************************************************************************************************
 First create essential objects: sa, clusterrole, clusterrolebinding, CRD and operator itself.
****************************************************************************************************
serviceaccount/scaler-operator created
clusterrole.rbac.authorization.k8s.io/scaler-operator created
clusterrolebinding.rbac.authorization.k8s.io/scaler-operator created
customresourcedefinition.apiextensions.k8s.io/scalers.scalerop.com created
deployment.apps/scaler-operator created


****************************************************************************************************
 At that time, we have no workload (except the operator itself).
****************************************************************************************************
NAME                               READY   STATUS    RESTARTS   AGE
scaler-operator-6cdbfd54f5-md8hd   2/2     Running   0          16s


****************************************************************************************************
 After we create two CR (CRD instance), we have 3 nginx pods and 4 wordpress pods.
****************************************************************************************************
scaler.scalerop.com/scaler-cr-nginx created
scaler.scalerop.com/scaler-cr-wordpress created
nginx-6cb454fbc7-fc6tb             1/1     Running   0          11s
nginx-6cb454fbc7-rptbf             1/1     Running   0          11s
nginx-6cb454fbc7-tfthl             1/1     Running   0          11s
wordpress-66f554b8f-bftx7          1/1     Running   0          7s
wordpress-66f554b8f-hr4hj          1/1     Running   0          7s
wordpress-66f554b8f-jxf79          1/1     Running   0          7s
wordpress-66f554b8f-kq29n          1/1     Running   0          7s


****************************************************************************************************
 We try to scale up nginx pods to 5, the operator will watch and do this automatically.
****************************************************************************************************
Warning: kubectl apply should be used on resource created by either kubectl create --save-config or kubectl apply
scaler.scalerop.com/scaler-cr-nginx configured
nginx-6cb454fbc7-2kfbp             1/1     Running   0          20s
nginx-6cb454fbc7-fbbxz             1/1     Running   0          20s
nginx-6cb454fbc7-fc6tb             1/1     Running   0          37s
nginx-6cb454fbc7-rptbf             1/1     Running   0          37s
nginx-6cb454fbc7-tfthl             1/1     Running   0          37s


****************************************************************************************************
 The operator can also be used to scale down different kinds of workload, here, wordpress.
****************************************************************************************************
Warning: kubectl apply should be used on resource created by either kubectl create --save-config or kubectl apply
scaler.scalerop.com/scaler-cr-wordpress configured
wordpress-66f554b8f-bftx7          1/1     Running   0          58s
wordpress-66f554b8f-hr4hj          1/1     Running   0          58s


****************************************************************************************************
 Clear the environment
****************************************************************************************************
serviceaccount "scaler-operator" deleted
clusterrole.rbac.authorization.k8s.io "scaler-operator" deleted
clusterrolebinding.rbac.authorization.k8s.io "scaler-operator" deleted
deployment.apps "scaler-operator" deleted
customresourcedefinition.apiextensions.k8s.io "scalers.scalerop.com" deleted
$
```
