
# 0. 链接

- A Practical kubernetes Operator using Ansible — an example https://itnext.io/a-practical-kubernetes-operator-using-ansible-an-example-d3a9d3674d5b
- An OpenShift Operator to deploy workshops ans demos https://github.com/jduncan-rva/workshop-operator

# 1. 在[Katacoda ansible operator环境](https://www.katacoda.com/openshift/courses/ansibleop/ansible-operator-overview)下的整个过程

- 文章里有些小错误，最关键的一处是在第二部分（也就是1.2节），不改的话影响过程。其他的比如多一个s少一个s之类的会有明显报错。
```
注：下面是原文（一字未改）和1.2节我改过后的那一句的对比（实际上在原文里上下两部分一对比就会发现group字段的值写的不对称）。
--------------------------------------------------
$ cat watches.yaml
---
- version: v1
  group: workshops.operator.redhatgov.io
  kind: Workshop
  playbook: /opt/ansible/playbooks/workshop.yml
- version: v1
  group: operator.redhatgov.io
  kind: Student
  playbook: /opt/ansible/playbooks/student.yml
--------------------------------------------------
  ...
  ...
  group: students.operator.redhatgov.io  // 这样就明显多了吧。
  ...
  ...
--------------------------------------------------
```
- 由于用的是`operator-sdk v0.6.0`版本，现在已经不支持`--cluster-scoped`参数了。所以在新版本的实际环境中需要改的更多，主要是deploy目录下的那些权限相关的manifest文件。这里有官方的参考：https://github.com/operator-framework/operator-sdk/blob/master/doc/operator-scope.md （我真觉得有毛病，干嘛去掉这个参数；去掉这个参数再来个攻略教你怎么弄集群范围内权限。。。）。

## 1.1

```
operator-sdk new workshop-operator --api-version=workshops.operator.redhatgov.io/v1 --kind=Workshop --type=ansible --cluster-scoped

cd workshop-operator/

cat << EOF > roles/workshop/tasks/main.yml
---
- name: Create project for global workshop content
  k8s:
    api_version: v1
    kind: Namespace
    name: "{{ meta.name }}"
EOF

operator-sdk build workshop-operator:v1

sed -i 's|{{ REPLACE_IMAGE }}|workshop-operator:v1|g' deploy/operator.yaml
sed -i "s|REPLACE_NAMESPACE|workshop-operator|g" deploy/role_binding.yaml
sed -i 's|{{ pull_policy\|default('\''Always'\'') }}|Never|g' deploy/operator.yaml

oc new-project workshop-operator
oc create -f deploy/service_account.yaml

cat << EOF > deploy/role.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  creationTimestamp: null
  name: workshop-operator
rules:
- apiGroups:
  - '*'
  resources:
  - '*'
  verbs:
  - '*'
EOF

oc create -f deploy/role.yaml

oc create -f deploy/role_binding.yaml
oc create -f deploy/crds/workshops_v1_workshop_crd.yaml
oc create -f deploy/operator.yaml

sed -i 's|size: 3|size: 1|g' deploy/crds/workshops_v1_workshop_cr.yaml

oc create -f deploy/crds/workshops_v1_workshop_cr.yaml

$ oc get ns | grep workshop
example-workshop                    Active    57s
workshop-operator                   Active    9m
```

该部分完成后，部分manifest文件的内容如下：
```
$ pwd
/root/tutorial/workshop-operator
$ cd deploy/

$ cat service_account.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: workshop-operator

$ cat role.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  creationTimestamp: null
  name: workshop-operator
rules:
- apiGroups:
  - '*'
  resources:
  - '*'
  verbs:
  - '*'

$ cat role_binding.yaml
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: workshop-operator
subjects:
- kind: ServiceAccount
  name: workshop-operator
  # Replace this with the namespace the operator is deployed in.
  namespace: workshop-operator
roleRef:
  kind: ClusterRole
  name: workshop-operator
  apiGroup: rbac.authorization.k8s.io

$ cat operator.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: workshop-operator
spec:
  replicas: 1
  selector:
    matchLabels:
      name: workshop-operator
  template:
    metadata:
      labels:
        name: workshop-operator
    spec:
      serviceAccountName: workshop-operator
      containers:
        - name: ansible
          command:
          - /usr/local/bin/ao-logs
          - /tmp/ansible-operator/runner
          - stdout
          # Replace this with the built image name
          image: "workshop-operator:v1"
          imagePullPolicy: "Never"
          volumeMounts:
          - mountPath: /tmp/ansible-operator/runner
            name: runner
            readOnly: true
        - name: operator
          # Replace this with the built image name
          image: "workshop-operator:v1"
          imagePullPolicy: "Never"
          volumeMounts:
          - mountPath: /tmp/ansible-operator/runner
            name: runner
          env:
            - name: WATCH_NAMESPACE
              value: ""
            - name: POD_NAME
              valueFrom:
                fieldRef:
                  fieldPath: metadata.name
            - name: OPERATOR_NAME
              value: "workshop-operator"
      volumes:
        - name: runner
          emptyDir: {}
```

## 1.2

```
mkdir playbooks

cat << EOF > playbooks/workshop.yml
---
- hosts: localhost
  roles:
    - workshop
EOF

cat << EOF > watches.yaml
---
- version: v1
  group: workshops.operator.redhatgov.io
  kind: Workshop
  playbook: /opt/ansible/playbooks/workshop.yml
EOF

cat << EOF > build/Dockerfile
FROM quay.io/operator-framework/ansible-operator:v0.6.0
COPY roles/ \${HOME}/roles/
COPY playbooks/ \${HOME}/playbooks/
COPY watches.yaml \${HOME}/watches.yaml
EOF

operator-sdk add crd --api-version students.operator.redhatgov.io/v1 --kind Student
cd roles/
ansible-galaxy init student
cd ..

cat << EOF > roles/student/tasks/main.yml
- name: Create project for student 
  k8s:
    api_version: v1
    kind: Namespace
    name: "{{ meta.name }}"
EOF

cat << EOF > playbooks/student.yml 
---
- hosts: localhost
  roles:
    - student
EOF

# //这里原版有一处错误，student的"group"字段值少了"students"。实际上去看这篇文章的github会发现
# //作者是把workshop和student搞到一个组里去了，他们的crd里的group都是“operator.redhatgov.io”
# //而不是现在这样，再加俩前缀搞成不同的组。
cat << EOF > watches.yaml
---
- version: v1
  group: workshops.operator.redhatgov.io
  kind: Workshop
  playbook: /opt/ansible/playbooks/workshop.yml
- version: v1
  group: students.operator.redhatgov.io
  kind: Student
  playbook: /opt/ansible/playbooks/student.yml
EOF

operator-sdk build workshop-operator:v1

oc delete deployment workshop-operator
oc create -f deploy/operator.yaml
oc create -f deploy/crds/students_v1_student_crd.yaml

# //这里注意，原版里面写的是student而不是students。所以还是推荐直接替换字段而不是完全复制下来用cat+EOF的方式写进去。
# //这中间student的单复数可能还会有些小问题，但是还好都是执行的语句的问题，而不是文件内容的问题（后者不好发觉啊）。
sed -i 's|size: 3|size: 1|g' deploy/crds/students_v1_student_cr.yaml

oc create -f deploy/crds/students_v1_student_cr.yaml

$ oc get ns | grep student
example-student                     Active    1m
```

## 1.3

```
cat << EOF > roles/workshop/tasks/main.yml
--- 
- name: Create project for global workshop content
  k8s:
    api_version: v1
    kind: Namespace
    name: "{{ meta.name }}"

- name: Create students for workshop
  k8s:
    definition: "{{ lookup('template', 'student.yaml.j2') | from_yaml }}"
  vars:
    student_number: "{{ item }}"
  loop: "{{ range(1, num_students + 1) | list }}"
  when: num_students is defined
EOF

cat << EOF > roles/workshop/templates/student.yaml.j2
apiVersion: students.operator.redhatgov.io/v1
kind: Student
metadata:
  name: "{{ 'student%02d' | format(student_number) }}"
  namespace: "{{ meta.name }}"
spec:
  workshopName: "{{ meta.name }}"
EOF

# //原文里根本没提到这点，是我按步骤执行完发现不成功，看了github仓库才发现的：还得再改student的role里的task的内容。
cat << EOF > roles/student/tasks/main.yml
---
- name: Create project for {{ meta.name }}
  k8s:
    api_version: v1
    kind: Namespace
    name: "{{ workshop_name }}-{{ meta.name }}"
EOF

# // 还得把workshop的cr里的变量名字和值换一下，也是原文没提到的，我一个一个看commit记录才发现。。。
# // https://github.com/jduncan-rva/workshop-operator/commit/6b3c26fd36cf0e1b6a2b2fe8cd9865fcf09ae89f
sed -i 's|size: 1|numStudents: 3|g' deploy/crds/workshops_v1_workshop_cr.yaml

operator-sdk build workshop-operator:v1

oc delete deployment workshop-operator
oc delete workshop example-workshop
# oc delete workshop another-workshop //这个比较trivail，我没做，所以不用执行了。
oc delete student example-student

oc create -f deploy/operator.yaml
oc create -f deploy/crds/workshops_v1_workshop_cr.yaml

$ oc get ns | grep student
example-workshop-student01          Active    1m
example-workshop-student02          Active    1m
example-workshop-student03          Active    1m
```
