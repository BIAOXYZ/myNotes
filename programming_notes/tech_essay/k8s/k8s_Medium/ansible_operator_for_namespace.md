
# 0. 链接

- A Practical kubernetes Operator using Ansible — an example https://itnext.io/a-practical-kubernetes-operator-using-ansible-an-example-d3a9d3674d5b
- An OpenShift Operator to deploy workshops ans demos https://github.com/jduncan-rva/workshop-operator

# 1. 整个过程

文章里有些小错误，最关键的一处是

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
