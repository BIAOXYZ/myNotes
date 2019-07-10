
# 0. Preliminaries

Let's dispaly the whole procedure of utilizing `ansible k8s_scale module` to scale up and down an (nginx) deployment. It may be useful for future development of `ansible operator`.

## 0.1 References/Links 

k8s_scale – Set a new size for a Deployment, ReplicaSet, Replication Controller, or Job https://docs.ansible.com/ansible/latest/modules/k8s_scale_module.html
>> personal notes: A more general ansible module for kubernetes is [k8s – Manage Kubernetes (K8s) objects](https://docs.ansible.com/ansible/latest/modules/k8s_module.html)

## 0.2 Enviroment info

```
$ oc version
oc v3.11.0+e5dbec2-186
kubernetes v1.11.0+d4cacc0
features: Basic-Auth GSSAPI Kerberos SPNEGO

Server https://master:8443
openshift v3.11.0+9b1e777-164
kubernetes v1.11.0+d4cacc0

$ ansible --version
ansible 2.7.1
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/root/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/site-packages/ansible
  executable location = /usr/bin/ansible
  python version = 2.7.5 (default, Apr  9 2019, 14:30:50) [GCC 4.8.5 20150623 (Red Hat 4.8.5-36)]
```

## 0.3 Prepared files

> mydeploymentnginx.yaml
>> It will be used to generate a test deployment.
```
cat << EOF > mydeploymentnginx.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  replicas: 2
  template:
    metadata:
      name: nginx
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        imagePullPolicy: IfNotPresent
      restartPolicy: Always
  selector:
    matchLabels:
      app: nginx
EOF      
```

> k8s-scale-obj.yaml
>> This is the main file which will be used for ansbile operator.
```
cat << EOF > k8s-scale-obj.yaml
- hosts: localhost
  tasks:
  - name: Scale a k8s object and extend timeout
    k8s_scale:
      api_version: "{{ apiversion }}"
      kind: "{{ kind }}"
      name: "{{ name }}"
      namespace: "{{ namespace }}"
      replicas: "{{ replicas }}"
      wait_timeout: 60
EOF      
```

# 1. The whole procedure

```
// Create the deployment and query for the origin state.

$ oc apply -f mydeploymentnginx.yaml
deployment.apps/nginx created

$ oc get deployment
NAME      DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
nginx     2         2         2            0           11s

$ oc get pods
NAME                       READY     STATUS    RESTARTS   AGE
docker-registry-1-v2tx7    1/1       Running   0          1h
nginx-5d44458958-mdfp4     1/1       Running   0          17s
nginx-5d44458958-qkg6s     1/1       Running   0          17s
registry-console-1-stz66   1/1       Running   0          1h
router-1-xlp7j             1/1       Running   0          1h
```

```
// Conduct scale up step.

$ ansible-playbook k8s-scale-obj.yaml --extra-vars "apiversion=extensions/v1beta1 kind=deployment namespace=default name=nginx replicas=3"
 [WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'

 [WARNING]: Found variable using reserved name: name


PLAY [localhost] ***************************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************
ok: [localhost]

TASK [Scale a k8s object and extend timeout] ***********************************************************************************************************
changed: [localhost]

PLAY RECAP *********************************************************************************************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0
```

```
// Scale up succeeds.

$ oc get deployment
NAME      DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
nginx     3         3         3            3           1m
$
$ oc get pods
NAME                       READY     STATUS    RESTARTS   AGE
docker-registry-1-v2tx7    1/1       Running   0          1h
nginx-5d44458958-mdfp4     1/1       Running   0          1m
nginx-5d44458958-mzgcx     1/1       Running   0          20s
nginx-5d44458958-qkg6s     1/1       Running   0          1m
registry-console-1-stz66   1/1       Running   0          1h
router-1-xlp7j             1/1       Running   0          1h
```

```
// Conduct scale down step.

$ ansible-playbook k8s-scale-obj.yaml --extra-vars "apiversion=extensions/v1beta1 kind=deployment namespace=default name=nginx replicas=1"
 [WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'

 [WARNING]: Found variable using reserved name: name


PLAY [localhost] ***************************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************
ok: [localhost]

TASK [Scale a k8s object and extend timeout] ***********************************************************************************************************
changed: [localhost]

PLAY RECAP *********************************************************************************************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0
```

```
// Scale down succeeds.

$ oc get deployment
NAME      DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
nginx     1         1         1            1           4m
$
$ oc get pods
NAME                       READY     STATUS    RESTARTS   AGE
docker-registry-1-v2tx7    1/1       Running   0          1h
nginx-5d44458958-qkg6s     1/1       Running   0          4m
registry-console-1-stz66   1/1       Running   0          1h
router-1-xlp7j             1/1       Running   0          1h
```
