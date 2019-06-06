
# 链接

Ansible Kubernetes Module 
- https://www.katacoda.com/openshift/courses/ansibleop/ansible-k8s-modules
- https://learn.openshift.com/ansibleop/ansible-k8s-modules/

# 0. 补充内容

```
$ pwd
/root/tutorial

$ ll
total 20
drwxr-xr-x. 10 root root 4096 Jun  6 07:25 example-role
drwxr-xr-x.  5 root root 4096 May 29 00:01 go
-rw-r--r--.  1 root root   63 Jun  6 07:25 myhosts
-rw-r--r--.  1 root root  308 Jun  6 07:25 nginx-deployment.yml
-rw-r--r--.  1 root root  114 Jun  6 07:41 playbook.yml

$ tree example-role/
example-role/
├── defaults
│   └── main.yml
├── files
├── handlers
│   └── main.yml
├── meta
│   └── main.yml
├── README.md
├── tasks
│   └── main.yml
├── templates
├── tests
│   ├── inventory
│   └── test.yml
└── vars
    └── main.yml

8 directories, 8 files
```

```
$ cat myhosts
[group1]
host01 ansible_ssh_user=cent ansible_connection=local

$ cat playbook.yml
-
  name: Create a new file named names in the current directory
  hosts: localhost
  roles:
  -
    example-role
```

# 1. Running the k8s Ansible modules locally

For this example we will create and delete a namespace with the switch of an Ansible variable.

## a. Modify tasks file `example-role/tasks/main.yml` to contain the Ansible shown below.
```
---
- name: set test namespace to {{ state }}
  k8s:
    api_version: v1
    kind: Namespace
    name: test
    state: "{{ state }}"
  ignore_errors: true
```

## b. Modify vars file `example-role/defaults/main.yml`, setting `state: present` by default.
```
---
state: present
```

## c. Run playbook.yml, which will execute `'example-role'`.
> ansible-playbook -i myhosts playbook.yml
```
$ ansible-playbook -i myhosts playbook.yml

PLAY [Create a new file named names in the current directory] **************************************

TASK [Gathering Facts] *****************************************************************************
ok: [localhost]

TASK [example-role : set test namespace to present] ************************************************
changed: [localhost]

PLAY RECAP *****************************************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0

```

## d. Check that the namespace `test` was created.
> oc get projects
```
NAME              DISPLAY NAME   STATUS
default                          Active
kube-public                      Active
kube-system                      Active
openshift                        Active
openshift-infra                  Active
test                             Active
```

# 2. Leveraging existing k8s Resource Files inside of Ansible

Next, we'll use the Ansible `k8s module` to leverage existing Kubernetes and OpenShift Resource files. Let's take the nginx deployment example from the Kubernetes docs.

Note: We've modified the resource file slightly as we will be deploying on OpenShift.

## a. Copy the nginx deployment definition `nginx-deployment.yml` into `example-role/templates`, adding a `.j2` extension
> cp nginx-deployment.yml ./example-role/templates/nginx-deployment.yml.j2
```
$ cat ./example-role/templates/nginx-deployment.yml.j2

kind: DeploymentConfig
apiVersion: v1
metadata:
  name: nginx-deployment
spec:
  template:
    metadata:
      labels:
        name: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:1.15.4
          ports:
          - containerPort: 80
  replicas: 3
  selector:
    name: nginx
```

## b. Update tasks file `example-role/tasks/main.yml` to create the nginx deployment using the k8s module
```
---
- name: set test namespace to {{ state }}
  k8s:
   api_version: v1
   kind: Namespace
   name: test
   state: "{{ state }}"

- name: set nginx deployment to {{ state }}
  k8s:
   state: "{{ state }}"
   definition: "{{ lookup('template', 'nginx-deployment.yml.j2') }}"
   namespace: test
```

## c. Run the Playbook to deploy nginx onto OpenShift
Running the Playbook with the command below will read the `state` variable defined in `example-role/defaults/main.yml`

> ansible-playbook -i myhosts playbook.yml
```
$ ansible-playbook -i myhosts playbook.yml

PLAY [Create a new file named names in the current directory] **************************************

TASK [Gathering Facts] *****************************************************************************
ok: [localhost]

TASK [example-role : set test namespace to present] ************************************************
ok: [localhost]

TASK [example-role : set nginx deployment to present] **********************************************
changed: [localhost]

PLAY RECAP *****************************************************************************************
localhost                  : ok=3    changed=1    unreachable=0    failed=0

```

## d. Examine Playbook results
You can see the `test` namespace created and the `nginx` deployment created in the new namespace.

> oc get all -n test
```
$ oc get all -n test
NAME                           READY     STATUS    RESTARTS   AGE
pod/nginx-deployment-1-49qfh   1/1       Running   0          2m
pod/nginx-deployment-1-bkckw   1/1       Running   0          2m
pod/nginx-deployment-1-gzh62   1/1       Running   0          2m

NAME                                       DESIRED   CURRENT   READY     AGE
replicationcontroller/nginx-deployment-1   3         3         3         2m

NAME                                                  REVISION   DESIRED   CURRENT   TRIGGERED BY
deploymentconfig.apps.openshift.io/nginx-deployment   1          3         3         config
```

# 3. Customizing k8s Resource files with Ansible

Next, let's make it possible to customize the replica count for our nginx deployment by adding an `nginx_replicas` variable to the DeploymentConfig template and filling the variable value dynamically with Ansible.

## a. Modify vars file `example-role/defaults/main.yml`, setting `nginx_replicas: 2`
```
---
state: present
nginx_replicas: 2
```

## b. Modify nginx deployment definition `nginx-deployment.yml.j2` to read `replicas` from the `nginx_replicas` variable
```
kind: DeploymentConfig
apiVersion: v1
metadata:
  name: nginx-deployment
spec:
  template:
    metadata:
      labels:
        name: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:1.15.4
          ports:
          - containerPort: 80
  replicas: "{{ nginx_replicas }}"
  selector:
    name: nginx
``` 

## c. Run the Playbook to change the nginx replica count
Running the Playbook again will read the variable `nginx_replicas` and use the provided value to customize the nginx DeploymentConfig.

> ansible-playbook -i myhosts playbook.yml
```
$ ansible-playbook -i myhosts playbook.yml

PLAY [Create a new file named names in the current directory] **************************************

TASK [Gathering Facts] *****************************************************************************
ok: [localhost]

TASK [example-role : set test namespace to present] ************************************************
ok: [localhost]

TASK [example-role : set nginx deployment to present] **********************************************
changed: [localhost]

PLAY RECAP *****************************************************************************************
localhost                  : ok=3    changed=1    unreachable=0    failed=0

```

## d. Examine Playbook results
After running the Playbook, the cluster will scale down one of the nginx pods to meet the new requested replica count of 2.

> oc get pods -n test
```
$ oc get pods -n test
NAME                       READY     STATUS    RESTARTS   AGE
nginx-deployment-1-bkckw   1/1       Running   0          3m
nginx-deployment-1-gzh62   1/1       Running   0          3m
```

## e. Tear down the nginx deployment
To remove the nginx deployment, we'll override the `state` variable to contain `state=absent` using the `-e / --extra-vars` flag.

> ansible-playbook -i myhosts playbook.yml --extra-vars state=absent
```
$ ansible-playbook -i myhosts playbook.yml --extra-vars state=absent

PLAY [Create a new file named names in the current directory] **************************************

TASK [Gathering Facts] *****************************************************************************
ok: [localhost]

TASK [example-role : set test namespace to absent] *************************************************
changed: [localhost]

TASK [example-role : set nginx deployment to absent] ***********************************************
changed: [localhost]

PLAY RECAP *****************************************************************************************
localhost                  : ok=3    changed=2    unreachable=0    failed=0

```
