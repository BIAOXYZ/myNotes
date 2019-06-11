
# 链接

Ansible Operator Overview 
- https://www.katacoda.com/openshift/courses/ansibleop/ansible-operator-overview 
- https://learn.openshift.com/ansibleop/ansible-operator-overview/

# 1. The Ansible Operator

## Why an Operator?
Operators make it easy to manage complex stateful applications on top of Kubernetes. However writing an operator today can be difficult because of challenges such as using low level APIs, writing boilerplate, and a lack of modularity which leads to duplication.

The Operator SDK is a framework that uses the controller-runtime library to make writing operators easier by providing:
- High level APIs and abstractions to write the operational logic more intuitively
- Tools for scaffolding and code generation to bootstrap a new project fast
- Extensions to cover common operator use cases

## What is an Ansible Operator?
A collection of building blocks from Operator SDK that enables Ansible to handle the reconciliation logic for an Operator.

## Included in Operator Framework
Ansible Operator is one of the available type of Operators that Operator SDK is able to generate. As of Fall 2018, Operator SDK assists with Golang, Helm, and Ansible.

## How do I use it?
Build your Ansible code on top of a provided base image along with some metadata to map Kubernetes events to Ansible Playbooks or Roles.

The following workflow is for a new **Ansible** operator:
1. Create a new Operator project using the Operator SDK Command Line Interface (CLI)
2. Write the reconciling logic for your object using Ansible Playbooks and Roles
3. Use the SDK CLI to build and generate the operator deployment manifests
4. Optionally add additional CRD's using the SDK CLI and repeat steps 2 and 3

# 2. The role of the Watches File

Now that we have demonstrated the Ansible k8s modules, we want to trigger this Ansible logic when a Custom Resource changes. The Ansible Operator uses a Watches file, written in YAML, which holds the mapping between Custom Resources and Ansible Roles/Playbooks.

**NOTE**: It is incredibly important that the Ansible Roles/Playbooks packaged into an Ansible Operator are **idempotent**, as these tasks will be executed frequently to ensure the application is in its proper state.

## Structure of a Watches file
The **Watches file** maps Custom Resources (identified by Group, Version, and Kind [GVK]) to Ansible Roles and Playbooks. The Operator expects this mapping file in a predefined location: /opt/ansible/watches.yaml

Each mapping within the Watches file has mandatory fields:
- **group**: Group of the Custom Resource that you will be watching.
- **version**: Version of the Custom Resource that you will be watching.
- **kind**: Kind of the Custom Resource that you will be watching.
- **role** (default): Path to the Role that should be run by the Operator for a particular Group-Version-Kind (GVK). This field is mutually exclusive with the "playbook" field.
- **playbook** (optional): Path to the Playbook that should be run by the Operator for a particular Group-Version-Kind (GVK). This Playbook can be a composition of Roles. This field is mutually exclusive with the "role" field.

### Sample watches.yaml
```
---
- version: v1alpha1
  group: foo.example.com
  kind: Foo
  # associates GVK with Role
  role: /opt/ansible/roles/Foo
```
By default, `operator-sdk new --type ansible` creates 'watches.yaml' configured to execute a role in response to a Custom Resource event.

This works well for smaller projects, but for more complex Ansible we might not want all of our logic in a single role.

## Triggering a Playbook instead of a Role
Configuring the Watches file to run a Playbook allows the developer more flexibility in consuming other Ansible roles and enabling more customized application deployments.

To use a Playbook in your operator, you would modify `watches.yaml` as shown below:
```
---
- version: v1alpha1
  group: foo.example.com
  kind: Foo
  # associating a Custom Resource GVK with a Playbook
  playbook: /opt/ansible/playbook.yaml
```
For this to work, we would need to copy `playbook.yaml` into the container image.

You would accomplish this by modifying the Operator Dockerfile to COPY 'playbook.yaml' into the container as shown below:
```
# Dockerfile at <project-name>/build/Dockerfile

FROM quay.io/water-hole/ansible-operator

COPY roles/ ${HOME}/roles
COPY watches.yaml ${HOME}/watches.yaml

# New 'COPY' build step for playbook.yaml
COPY playbook.yaml ${HOME}/playbook.yaml
```

## Preconfiguration for a Playbook
If you know from the start that you want your Operator to use a Playbook instead of a Role, you can generate your project scaffolding with the `--generate-playbook` flag:

`operator-sdk new --type ansible --kind Foo --api-version foo.example.com/v1alpha1 foo-operator --generate-playbook --skip-git-init`

# 3. The Custom Resource File

Using Ansible Operator, a change in the state of a Custom Resource (CR) signals to the Operator that certain Playbooks/Roles should be executed. So what does a Custom Resource look like?

As a creator/user of an Ansible Operator, you'll create CRs to test that your Operator has the expected response to each CR trigger.

## Structure of a Custom Resource
The Custom Resource takes the format of a Kubernetes resource. The object definition has mandatory fields:

## Mandatory Fields
- **apiVersion**: Version of the Custom Resource that will be created

- **kind**: Kind of the Custom Resource that will be created

- **metadata**: Kubernetes metadata that will be created

- **spec**: Key-value list of variables which are passed to Ansible. Optional and will be empty by default.

- **annotations**: Kubernetes annotations to be appended to the CR. See the below section for Ansible Operator specific annotations.

## Annotations
Custom Resource annotations can be applied to modify Ansible Operator behavior:

- **ansible.operator-sdk/reconcile-period**: Used to specify the reconciliation interval for the CR.
  * This value is parsed using the standard Golang 'Package time'. Specifically, ParseDuration is used which will use the default of an 's' suffix giving the value in seconds (e.g. "30" would become "30s" as shown below).

## Custom Resource Example
If an Ansible Operator was watching for events from `kind: Foo` with `apiVersion: foo.example.com/v1alpha1`, an Ansible Playbook/Role could be triggered in response to creation of the resource shown below.
```
apiVersion: "foo.example.com/v1alpha1"
kind: "Foo"
metadata:
  name: "example"
annotations:
  ansible.operator-sdk/reconcile-period: "30s"
```

# 4. Handle Extra Vars

To pass 'extra vars' to the Playbooks/Roles being run by the Operator, you can embed key-value pairs in the 'spec' section of the Custom Resource (CR).

This is equivalent to how `--extra-vars` can be passed into the ansible-playbook command.

## Example CR with extra-vars
The CR snippet below shows two 'extra vars' (message, newParamater) being passed in via `spec`. Passing 'extra vars' through the CR allows for customization of Ansible logic based on the contents of each CR instance.
```
# Sample CR definition where some 
# 'extra vars' are passed via the spec
apiVersion: "app.example.com/v1alpha1"
kind: "Database"
metadata:
  name: "example"
spec:
  message: "Hello world 2"
  newParameter: "newParam"
```

## Accessing CR Fields
Now that you've passed 'extra vars' to your Playbook through the CR `spec`, we need to read them from the Ansible logic that makes up your Operator.

Variables passed in through the CR spec are made available at the top-level to be read from Jinja templates. For the CR example above, we could read the vars 'message' and 'newParameter' from a Playbook like so:
```
- debug:
    msg: "message value from CR spec: {{ message }}"

- debug:
    msg: "newParameter value from CR spec: {{ new_parameter }}"
```

Did you notice anything strange about the snippet above? The 'newParameter' variable that we set on our CR spec was accessed as 'new_parameter'. Keep this automatic conversion from camelCase to snake_case in mind, as it will happen to all 'extra vars' passed into the CR spec.

Refer to the next section for further info on reaching into the JSON structure exposed in the Ansible Operator runtime environment.

## JSON Structure
When a reconciliation job runs, the content of the associated CR is made available as variables in the Ansible runtime environment.

The JSON below is an example of what gets passed into ansible-runner (the Ansible Operator runtime).

Note that vars added to the 'spec' section of the CR ('message' and 'new_parameter') are placed at the top-level of this structure for easy access.
```
{ "meta": {
        "name": "<cr-name>",
        "namespace": "<cr-namespace>",
  },
  "message": "Hello world 2",
  "new_parameter": "newParam",
  "_app_example_com_database": {
     <Full CR>
   },
}
```

## Accessing CR metadata
The `meta` fields provide the CR 'name' and 'namespace' associated with a reconciliation job. These and other nested fields can be accessed with dot notation in Ansible.
```
- debug:
    msg: "name: {{ meta.name }}, namespace: {{ meta.namespace }}"
```
In the next step, we'll use `operator-sdk` to generate our Operator project scaffolding.

# 5. Create a new Operator
Next, we'll learn how to use the operator-sdk CLI to create an Ansible Operator project with the 'new' command.

A basic (but incomplete) 'new' command looks like this:
```
operator-sdk new <project-name> --type ansible
```
This command tells operator-sdk to initialize a new Ansible Operator project scaffolding with a name of your choosing.

However, we need to add a few more required arguments via flags before running the command.

- `--api-version` Kubernetes apiVersion, has a format of $GROUP_NAME/$VERSION (e.g myapp.example.com/v1alpha1)
- `--kind` Kubernetes Custom Resource kind (e.g MyOperatedApp)

These flags are used by operator-sdk to generate:

- Custom Resource files customized according to flag arguments
- An Ansible Role whose name matches the input for `--kind`.
Putting it all together, we end up with a command that looks like this:
```
$ operator-sdk new my-project --type=ansible --api-version=myapi.example.com/v1alpha1 --kind=MyOperatedApp
[...]

# See if you can spot similarities between command args and generated scaffolding.

$ tree my-project/

my-project/
├── build
│   └── Dockerfile
├── deploy
│   ├── crds
│   │   ├── myapi_v1alpha1_myoperatedapp_crd.yaml
│   │   └── myapi_v1alpha1_myoperatedapp_cr.yaml
│   ├── operator.yaml
│   ├── role_binding.yaml
│   ├── role.yaml
│   └── service_account.yaml
├── roles
│   └── MyOperatedApp
│       ├── defaults
│       │   └── main.yml
│       ├── files
│       ├── handlers
│       │   └── main.yml
│       ├── meta
│       │   └── main.yml
│       ├── README.md
│       ├── tasks
│       │   └── main.yml
│       ├── templates
│       ├── tests
│       │   ├── inventory
│       │   └── test.yml
│       └── vars
│           └── main.yml
└── watches.yaml
```

## Running 'operator-sdk new'
Now it's your turn! We'll be building a Memcached Ansible Operator for the remainder of this scenario.

Go ahead and run the command below to generate the Ansible Operator project scaffolding.
> operator-sdk new memcached-operator --type=ansible --api-version=cache.example.com/v1alpha1 --kind=Memcached --skip-git-init

This creates a new memcached-operator project specifically for watching the Memcached resource with APIVersion 'cache.example.com/v1apha1' and Kind 'Memcached'.

## Inspecting 'operator-sdk new' results
Inspect the memcached-operator directory structure for yourself with 'tree', and then 'cd' into it.

> tree memcached-operator

> cd memcached-operator

## Project Scaffolding Layout
After creating a new operator project using `operator-sdk new --type ansible`, the project directory has numerous generated folders and files. The following table describes a basic rundown of each generated file/directory.

|File/Folders|	Purpose|
|--|--|
|deploy |Contains a generic set of Kubernetes manifests for deploying this operator on a Kubernetes cluster.|
|roles |Contains an Ansible Role initialized using Ansible Galaxy.|
|build |Contains scripts that the operator-sdk uses for build and initialization.|
|watches.yaml |Contains Group, Version, Kind, and Ansible invocation method.|

# 6. Customize the Operator Logic
Thus far, we have created the memcached-operator project specifically for watching the Memcached resource with APIVersion 'cache.example.com/v1apha1' and Kind 'Memcached'. Now it's time to define the Operator logic.

## Customize the Operator logic
For this example the memcached-operator will execute the following reconciliation logic for each 'Memcached' Custom Resource (CR):

- Create a memcached Deployment if it doesn't exist
- Ensure that the Deployment size is the same as specified by the 'Memcached' CR

## Installing an existing Role from Ansible Galaxy
To speed development of our Operator up, we can reuse an existing Role. We will install a Role from Ansible Galaxy into our Operator:

[dymurray.memcached_operator_role (galaxy.ansible.com)](https://galaxy.ansible.com/dymurray/memcached_operator_role)

Run to install the Ansible Role inside of the project:
> ansible-galaxy install dymurray.memcached_operator_role -p ./roles

```
$ ls roles/
dymurray.memcached_operator_role Memcached
```

## Removing the unneeded Role
Since we'll be reusing the logic from 'dymurray.memcached_operator_role', we can safely delete the placeholder Role generated by the the 'operator-sdk new' command we ran previously.
> rm -rf ./roles/Memcached  //实际上应该是小写m，这个教程有问题。不过这里不删除这个目录也没啥影响。

## Taking a Closer Look: dymurray.memcached_operator_role
We can use the 'tree' command to get a general sense of the memcached Role installed from Ansible Galaxy.
> tree roles/dymurray.memcached_operator_role

## Role Variables
This Role provides the user with a variable `size` which is an integer to control the number of Deployment replicas to create. You can find the default for this variable in the memcached Role defaults/main.yml file:
```
---
# defaults file for Memcached
size: 1
```

## Role Tasks
Be sure to examine the memcached Role tasks/main.yml file, which uses the k8s (Kubernetes) Ansible module to create a Deployment of memcached.
```
---
# tasks file for Memcached
- name: start memcached
  k8s:
    definition:
      kind: Deployment
      apiVersion: apps/v1
      metadata:
        name: '{{ meta.name }}-memcached'
        namespace: '{{ meta.namespace }}'
      spec:
        replicas: "{{size}}"
        selector:
          matchLabels:
            app: memcached

  [ ... continued ...]
```

Next, we'll modify the necessary files to ensure that our Operator uses this Role instead of the generated scaffolding Role. Let's modify `watches.yaml`.

## Correcting the Watches File
By default, the memcached-operator watches `Memcached` resource events as shown in `watches.yaml` and executes Ansible Role `Memcached`.

Since we have swapped out the original Role for one from Ansible Galaxy, lets change the Watches file to reflect this:
```
---
- version: v1alpha1
  group: cache.example.com
  kind: Memcached
  role: /opt/ansible/roles/dymurray.memcached_operator_role
```
In the next step, we'll build and run our Ansible Operator.

# 7. Build and run the Operator
Before running the Operator, Kubernetes needs to know about the new custom resource definition the Operator will be watching.

## Deploy the Memcached Custom Resource Definition (CRD):
> oc create -f deploy/crds/cache_v1alpha1_memcached_crd.yaml

By running this command, we are creating a new resource type, `memcached`, on the cluster. **We will give our Operator work to do by creating and modifying resources of this type**.

## Ways to Run an Operator
Once the CRD is registered, there are two ways to run the Operator:

- As a pod inside an Openshift cluster
- As a go program outside the cluster using operator-sdk

For the sake of this tutorial, we will run the Operator as a pod inside of a Openshift Cluster. If you are interested in learning more about running the Operator using operator-sdk, see the `up local` instructions in Step 9 of this scenario.

## Run as a pod inside an Openshift cluster
Running as a pod inside a Openshift cluster is preferred for production use.

Let's build the memcached-operator image:
> operator-sdk build memcached-operator:v0.0.1

## Modifying the Operator deploy manifest
Kubernetes deployment manifests are generated by 'operator-sdk new' in `deploy/operator.yaml`. We need to make a few changes to this file.

- `image` placeholder 'REPLACE_IMAGE' should be set to the previously-built image.
- `imagePullPolicy` from 'Always' to 'Never' since we aren't pushing our image to a registry.
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: memcached-operator
spec:
# [...]
      containers:
        - name: memcached-operator
          # Replace 'REPLACE_IMAGE' with the built image name
          image: REPLACE_IMAGE
          # Replace 'Always' with 'Never'
          imagePullPolicy: Always
# [...]
```

The commands below will change the Deployment 'image' and 'imagePullPolicy' respectively.

> sed -i 's|{{ REPLACE_IMAGE }}|memcached-operator:v0.0.1|g' deploy/operator.yaml

> sed -i "s|{{ pull_policy\|default('Always') }}|Never|g" deploy/operator.yaml

## Creating the Operator from deploy manifests
Now, we are ready to deploy the memcached-operator:

Create a Project for the Operator to run in 
> oc new-project tutorial

Create Service Account for Operator to run as 
> oc create -f deploy/service_account.yaml

Create OpenShift Role specifying Operator Permissions 
> oc create -f deploy/role.yaml

Create OpenShift Role Binding assigning Permissions to Service Account 
> oc create -f deploy/role_binding.yaml

Create Operator Deployment Object 
> oc create -f deploy/operator.yaml

Note: role.yaml and role_binding.yaml describe cluster-wide resources. Creating these requires elevated permissions.

## Verify that the memcached-operator is running
> oc get deployment
```
NAME                DESIRED CURRENT UP-TO-DATE AVAILABLE AGE
memcached-operator  1       1       1          1         1m
```
# 8. Using the Operator
Now that we have deployed our Operator, let's create a CR and deploy an instance of memcached.

There is a sample CR in the scaffolding created as part of the Operator SDK:
```
apiVersion: cache.example.com/v1alpha1
kind: Memcached
metadata:
  name: example-memcached
spec:
  # Add fields here
  size: 3
```
Let's go ahead and apply this in our Tutorial project to deploy 3 memcached pods, using our Operator:

## Create a Memcached CR instance
Inspect `deploy/crds/cache_v1alpha1_memcached_cr.yaml`, and then use it to create a `Memcached` custom resource:
```
# deploy/crds/cache_v1alpha1_memcached_cr.yaml
apiVersion: cache.example.com/v1alpha1
kind: Memcached
metadata:
  name: example-memcached
spec:
  size: 3
```
> oc create -f deploy/crds/cache_v1alpha1_memcached_cr.yaml

## Check that the Memcached Operator works as intended
Ensure that the memcached-operator creates the deployment for the CR:
```
$ oc get deployment
NAME                 DESIRED CURRENT UP-TO-DATE AVAILABLE AGE
memcached-operator   1       1       1          1         2m
example-memcached    3       3       3          3         1m
```

Check the pods to confirm 3 replicas were created:
```
$ oc get pods
NAME                                READY STATUS   RESTARTS AGE
example-memcached-6cc844747c-2hbln  1/1   Running  0        1m
example-memcached-6cc844747c-54q26  1/1   Running  0        1m
example-memcached-6cc844747c-7jfhc  1/1   Running  0        1m
memcached-operator-68b5b558c5-dxjwh 1/1   Running  0        2m
```

## Change the Memcached CR to deploy 4 replicas
Change the `spec.size` field in `deploy/crds/cache_v1alpha1_memcached_cr.yaml` from 3 to 4 and apply the change:
```
apiVersion: cache.example.com/v1alpha1
kind: Memcached
metadata:
  name: example-memcached
spec:
  size: 4
```
> oc apply -f deploy/crds/cache_v1alpha1_memcached_cr.yaml

Confirm that the Operator changes the deployment size:
```
$ oc get deployment
NAME                DESIRED CURRENT  UP-TO-DATE  AVAILABLE  AGE
example-memcached   4       4        4           4          53s
memcached-operator  1       1        1           1          5m
```

Inspect the YAML list of 'memcached' resources in your project, noting that the 'spec.size' field is now set to 4.
> oc get memcached  -o yaml

## Removing Memcached from the cluster
First, delete the 'memcached' CR, which will remove the 4 Memcached pods and the associated deployment.
> oc delete -f deploy/crds/cache_v1alpha1_memcached_cr.yaml
```
$ oc get pods
NAME                                 READY STATUS  RESTARTS AGE
memcached-operator-7cc7cfdf86-vvjqk  1/1   Running 0        8m
```

Then, delete the memcached-operator deployment.
> oc delete -f deploy/operator.yaml

Finally, verify that the memcached-operator is no longer running.
> oc get deployment

Now let's take a look at using the built-in 'local install' functionality of the SDK.

# ~~9. Running the Operator Locally (Outside the Cluster)~~ //这部分不常用，先不管了。

# 实战记录（部分）

```
$ cd ~/tutorial
$ operator-sdk new memcached-operator --type=ansible --api-version=cache.example.com/v1alpha1 --kind=Memcached --skip-git-init
INFO[0000] Creating new Ansible operator 'memcached-operator'.
INFO[0000] Created deploy/service_account.yaml
INFO[0000] Created deploy/role.yaml
INFO[0000] Created deploy/role_binding.yaml
INFO[0000] Created deploy/crds/cache_v1alpha1_memcached_crd.yaml
INFO[0000] Created deploy/crds/cache_v1alpha1_memcached_cr.yaml
INFO[0000] Created build/Dockerfile
INFO[0000] Created roles/memcached/README.md
INFO[0000] Created roles/memcached/meta/main.yml
INFO[0000] Created roles/memcached/files/.placeholder
INFO[0000] Created roles/memcached/templates/.placeholder
INFO[0000] Created roles/memcached/vars/main.yml
INFO[0000] Created molecule/test-local/playbook.yml
INFO[0000] Created roles/memcached/defaults/main.yml
INFO[0000] Created roles/memcached/tasks/main.yml
INFO[0000] Created molecule/default/molecule.yml
INFO[0000] Created build/test-framework/Dockerfile
INFO[0000] Created molecule/test-cluster/molecule.yml
INFO[0000] Created molecule/default/prepare.yml
INFO[0000] Created molecule/default/playbook.yml
INFO[0000] Created build/test-framework/ansible-test.sh
INFO[0000] Created molecule/default/asserts.yml
INFO[0000] Created molecule/test-cluster/playbook.yml
INFO[0000] Created roles/memcached/handlers/main.yml
INFO[0000] Created watches.yaml
INFO[0000] Created deploy/operator.yaml
INFO[0000] Created .travis.yml
INFO[0000] Created molecule/test-local/molecule.yml
INFO[0000] Created molecule/test-local/prepare.yml
INFO[0000] Project creation complete.
$ tree memcached-operator
memcached-operator
├── build
│   ├── Dockerfile
│   └── test-framework
│       ├── ansible-test.sh
│       └── Dockerfile
├── deploy
│   ├── crds
│   │   ├── cache_v1alpha1_memcached_crd.yaml
│   │   └── cache_v1alpha1_memcached_cr.yaml
│   ├── operator.yaml
│   ├── role_binding.yaml
│   ├── role.yaml
│   └── service_account.yaml
├── molecule
│   ├── default
│   │   ├── asserts.yml
│   │   ├── molecule.yml
│   │   ├── playbook.yml
│   │   └── prepare.yml
│   ├── test-cluster
│   │   ├── molecule.yml
│   │   └── playbook.yml
│   └── test-local
│       ├── molecule.yml
│       ├── playbook.yml
│       └── prepare.yml
├── roles
│   └── memcached
│       ├── defaults
│       │   └── main.yml
│       ├── files
│       ├── handlers
│       │   └── main.yml
│       ├── meta
│       │   └── main.yml
│       ├── README.md
│       ├── tasks
│       │   └── main.yml
│       ├── templates
│       └── vars
│           └── main.yml
└── watches.yaml

17 directories, 25 files
$ cd memcached-operator
$ ansible-galaxy install dymurray.memcached_operator_role -p ./roles
- downloading role 'memcached_operator_role', owned by dymurray
- downloading role from https://github.com/dymurray/memcached-operator-role/archive/master.tar.gz
- extracting dymurray.memcached_operator_role to /root/tutorial/memcached-operator/roles/dymurray.memcached_operator_role
- dymurray.memcached_operator_role (master) was installed successfully
$ ls
build  deploy  molecule  roles  watches.yaml
$ rm -rf ./roles/memcached
$ ls roles/
dymurray.memcached_operator_role
$ tree roles/dymurray.memcached_operator_role/
roles/dymurray.memcached_operator_role/
├── defaults
│   └── main.yml
├── handlers
│   └── main.yml
├── meta
│   └── main.yml
├── README.md
├── tasks
│   └── main.yml
├── tests
│   ├── inventory
│   └── test.yml
└── vars
    └── main.yml

6 directories, 8 files



$ cat watches.yaml
---
- version: v1alpha1
  group: cache.example.com
  kind: Memcached
  role: /opt/ansible/roles/memcached
$
$ cp watches.yaml watches.yaml2
$ vi watches.yaml
$
$ cat watches.yaml
---
- version: v1alpha1
  group: cache.example.com
  kind: Memcached
  role: /opt/ansible/roles/dymurray.memcached_operator_role



$ oc create -f deploy/crds/cache_v1alpha1_memcached_crd.yaml
customresourcedefinition.apiextensions.k8s.io/memcacheds.cache.example.com created
$ operator-sdk build memcached-operator:v0.0.1
INFO[0000] Building Docker image memcached-operator:v0.0.1
Sending build context to Docker daemon 51.71 kB
Step 1/3 : FROM quay.io/operator-framework/ansible-operator:v0.6.0
Trying to pull repository quay.io/operator-framework/ansible-operator ...
v0.6.0: Pulling from quay.io/operator-framework/ansible-operator
a02a4930cb5d: Already exists
1bdeea372afe: Pulling fs layer
3b057581d180: Pulling fs layer
12618e5abaa7: Pulling fs layer
6f75beb67357: Pulling fs layer
b241f86d9d40: Pulling fs layer
e990bcb94ae6: Pulling fs layer
3cd07ac53955: Pulling fs layer
3fdda52e2c22: Pulling fs layer
517fc10b1cf8: Pull complete
fcfd0776c90c: Pull complete
4c5c493bb7c8: Pull complete
bfbe5d602652: Pull complete
4cc4113d56f3: Pull complete
9674913b05b1: Pull complete
332792f0ee28: Pull complete
ce029f48e54a: Pull complete
ff9e652cb0c0: Pull complete
fcc78d808a3d: Pull complete
Digest: sha256:db7f3692cf805ceec5ea2334a0dc600d8e234b678169402316abe96a76b89bea
Status: Downloaded newer image for quay.io/operator-framework/ansible-operator:v0.6.0
 ---> 5c51606d3f0e
Step 2/3 : COPY roles/ ${HOME}/roles/
 ---> 1a941d2a0c94
Removing intermediate container b7325d397165
Step 3/3 : COPY watches.yaml ${HOME}/watches.yaml
 ---> 5d4e7a6ae144
Removing intermediate container 66c4c4ea13ba
Successfully built 5d4e7a6ae144
INFO[0026] Operator build complete.



$ sed -i 's|{{ REPLACE_IMAGE }}|memcached-operator:v0.0.1|g' deploy/operator.yaml
$ sed -i "s|{{ pull_policy\|default('Always') }}|Never|g" deploy/operator.yaml
$ oc new-project tutorial
Now using project "tutorial" on server "https://master:8443".

You can add applications to this project with the 'new-app' command. For example, try:

    oc new-app centos/ruby-25-centos7~https://github.com/sclorg/ruby-ex.git

to build a new example application in Ruby.
$ oc create -f deploy/service_account.yaml
serviceaccount/memcached-operator created
$ oc create -f deploy/role.yaml
role.rbac.authorization.k8s.io/memcached-operator created
$ oc create -f deploy/role_binding.yaml
rolebinding.rbac.authorization.k8s.io/memcached-operator created
$ oc create -f deploy/operator.yaml
deployment.apps/memcached-operator created
$ oc get deployment
NAME                 DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
memcached-operator   1         1         1            0           2s
$ oc get po
NAME                                  READY     STATUS    RESTARTS   AGE
memcached-operator-6d8ddd677d-nztpp   2/2       Running   0          15s



$ oc create -f deploy/crds/cache_v1alpha1_memcached_cr.yaml
memcached.cache.example.com/example-memcached created
$
$ oc get deployment
NAME                          DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
example-memcached-memcached   3         3         3            0           6s
memcached-operator            1         1         1            1           37s
$
$ oc get po
NAME                                           READY     STATUS              RESTARTS   AGE
example-memcached-memcached-6cc844747c-4mxct   1/1       Running             0          12s
example-memcached-memcached-6cc844747c-9p6nq   1/1       Running             0          12s
example-memcached-memcached-6cc844747c-hqm7r   0/1       ContainerCreating   0          12s
memcached-operator-6d8ddd677d-nztpp            2/2       Running             0          43s
$
$ oc get po
NAME                                           READY     STATUS    RESTARTS   AGE
example-memcached-memcached-6cc844747c-4mxct   1/1       Running   0          31s
example-memcached-memcached-6cc844747c-9p6nq   1/1       Running   0          31s
example-memcached-memcached-6cc844747c-hqm7r   1/1       Running   0          31s
memcached-operator-6d8ddd677d-nztpp            2/2       Running   0          1m
$
$ vi deploy/crds/cache_v1alpha1_memcached_cr.yaml
$ oc apply -f deploy/crds/cache_v1alpha1_memcached_cr.yaml
Warning: oc apply should be used on resource created by either oc create --save-config or oc apply
memcached.cache.example.com/example-memcached configured
$
$ oc get po
NAME                                           READY     STATUS    RESTARTS   AGE
example-memcached-memcached-6cc844747c-4mxct   1/1       Running   0          3m
example-memcached-memcached-6cc844747c-9p6nq   1/1       Running   0          3m
example-memcached-memcached-6cc844747c-hqm7r   1/1       Running   0          3m
example-memcached-memcached-6cc844747c-p5d58   1/1       Running   0          5s
memcached-operator-6d8ddd677d-nztpp            2/2       Running   0          4m
$
$
$ oc get memcached  -o yaml
apiVersion: v1
items:
- apiVersion: cache.example.com/v1alpha1
  kind: Memcached
  metadata:
    annotations:
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"cache.example.com/v1alpha1","kind":"Memcached","metadata":{"annotations":{},"name":"example-memcached","namespace":"tutorial"},"spec":{"size":4}}
    creationTimestamp: 2019-05-30T17:56:44Z
    generation: 2
    name: example-memcached
    namespace: tutorial
    resourceVersion: "11206"
    selfLink: /apis/cache.example.com/v1alpha1/namespaces/tutorial/memcacheds/example-memcached
    uid: 498c84dd-8304-11e9-a05b-0242ac110019
  spec:
    size: 4
  status:
    conditions:
    - ansibleResult:
        changed: 0
        completion: 2019-05-30T18:00:36.169273
        failures: 0
        ok: 2
        skipped: 0
      lastTransitionTime: 2019-05-30T17:56:44Z
      message: Awaiting next reconciliation
      reason: Successful
      status: "True"
      type: Running
kind: List
metadata:
  resourceVersion: ""
  selfLink: ""
```
