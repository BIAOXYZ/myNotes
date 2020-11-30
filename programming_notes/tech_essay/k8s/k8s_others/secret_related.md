
# kubernetes从私有仓库拖镜像

从私有仓库拉取镜像 https://kubernetes.io/zh/docs/tasks/configure-pod-container/pull-image-private-registry/ || https://v1-18.docs.kubernetes.io/zh/docs/tasks/configure-pod-container/pull-image-private-registry/
- > 要了解 `dockerconfigjson` 字段中的内容，请将 Secret 数据转换为可读格式：
  >> `kubectl get secret regcred --output="jsonpath={.data.\.dockerconfigjson}" | base64 --decode`
- > 输出和下面类似：`{"auths":{"yourprivateregistry.com":{"username":"janedoe","password":"xxxxxxxxxxx","email":"jdoe@example.com","auth":"c3R...zE2"}}}`
- > 要了解 `auth` 字段中的内容，请将 base64 编码过的数据转换为可读格式：
  >> `echo "c3R...zE2" | base64 --decode`

k8s实战之从私有仓库拉取镜像 https://www.cnblogs.com/justmine/p/8678758.html

# 个人实战

## 实战1

```sh
# 这里只想说明一点：docker-username这里也可能是类似邮箱的用户名！我开始只用了liulliu，结果错了。
# 总之就是原封不动的 登陆用户名/登陆密码

$ kubectl create secret docker-registry uiupdate1 -n kube-system --docker-server=hyc-cp4mcm-team-docker-local.artifactory.swg-devops.com --docker-username=liulliu@cn.ibm.com --docker-password=<your_password> --docker-email=liulliu@cn.ibm.com

$ kubectl edit deployment -n kube-system multicluster-hub-console-mcmapplicationui

# 1. imagePullSecrets主要是针对pod的，但是pod最终是deployment控制的，所以这里在deployment的spec.template.spec下添加imagePullSecrets相关内容。
spec:
  template:
    spec:
      imagePullSecrets:
      - name: uiupdate1
# 2. 用新镜像 hyc-cp4mcm-team-docker-local.artifactory.swg-devops.com/ibmcom/cp4mcm-application-ui-amd64:3.6.0 替换deployment里的老镜像。
```

## 实战2

From: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/#registry-secret-existing-credentials
```sh
# 这种创建secret方式的好处我觉得应该是可以用不同账号登陆多个docker registry（因为你每登陆一个不同的registry，"auths"里键值对就会增加），
# 然后用生成的config.json一次只创建一个secret就够用了。如果是上面那种方式每个docker registry的每个不同账户都得创建一个secret。

[root@centos11 ~]# docker login hyc-cp4mcm-team-docker-local.artifactory.swg-devops.com
Username: liulliu@cn.ibm.com
Password:
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
[root@centos11 ~]#
[root@centos11 ~]#
[root@centos11 ~]# cat /root/.docker/config.json
{
        "auths": {
                "hyc-cp4mcm-team-docker-local.artifactory.swg-devops.com": {
                        "auth": "bGl1bGxpdUBjbi5pYm0uY29tOmxsMTk4NTE5ODUxOTg1Ng=="
                }
        },
        "HttpHeaders": {
                "User-Agent": "Docker-Client/19.03.12 (linux)"
        }
}[root@centos11 ~]#

[root@centos11 ~]# kubectl create secret generic regcred --from-file=.dockerconfigjson="/root/.docker/config.json" --type=kubernetes.io/dockerconfigjson
secret/regcred created
[root@centos11 ~]#
[root@centos11 ~]#
[root@centos11 ~]# oc get secret regcred -oyaml
apiVersion: v1
data:
  .dockerconfigjson: ewoJImF1dGhzIjogewoJCSJoeWMtY3A0bWNtLXRlYW0tZG9ja2VyLWxvY2FsLmFydGlmYWN0b3J5LnN3Zy1kZXZvcHMuY29tIjogewoJCQkiYXV0aCI6ICJiR2wxYkd4cGRVQmpiaTVwWW0wdVkyOXRPbXhzTVRrNE5URTVPRFV4T1RnMU5nPT0iCgkJfQoJfSwKCSJIdHRwSGVhZGVycyI6IHsKCQkiVXNlci1BZ2VudCI6ICJEb2NrZXItQ2xpZW50LzE5LjAzLjEyIChsaW51eCkiCgl9Cn0=
kind: Secret
metadata:
  creationTimestamp: "2020-09-04T06:41:16Z"
  managedFields:
  - apiVersion: v1
    fieldsType: FieldsV1
    fieldsV1:
      f:data:
        .: {}
        f:.dockerconfigjson: {}
      f:type: {}
    manager: kubectl
    operation: Update
    time: "2020-09-04T06:41:16Z"
  name: regcred
  namespace: default
  resourceVersion: "10027"
  selfLink: /api/v1/namespaces/default/secrets/regcred
  uid: 285be4d8-37d4-4034-a7db-2cb4ea3cfe1e
type: kubernetes.io/dockerconfigjson
[root@centos11 ~]#
```

```sh
# 如何反向查询

{root@bandore1 ~}$ kubectl get secret ibm-management-pull-secret -n openshift-marketplace --output="jsonpath={.data.\.dockerconfigjson}" | base64 --decode
{
        "auths": {
                "hyc-cloud-private-integration-docker-local.artifactory.swg-devops.com": {
                        "auth": "bGl1bGxpdUBjbi5pYm0uY29tOmxsMTk4NTE5ODUxOTg1Ng=="
                },
                "hyc-cp4mcm-team-docker-local.artifactory.swg-devops.com": {
                        "auth": "bGl1bGxpdUBjbi5pYm0uY29tOmxsMTk4NTE5ODUxOTg1Ng=="
                },
                "orpheus-local-docker.artifactory.swg-devops.com": {
                        "auth": "bGl1bGxpdUBjbi5pYm0uY29tOmxsMTk4NTE5ODUxOTg1Ng=="
                }
        },
        "HttpHeaders": {
                "User-Agent": "Docker-Client/19.03.12 (linux)"
        }
}{root@bandore1 ~}$
{root@bandore1 ~}$
{root@bandore1 ~}$
{root@bandore1 ~}$ echo "bGl1bGxpdUBjbi5pYm0uY29tOmxsMTk4NTE5ODUxOTg1Ng==" | base64 -d
liulliu@cn.ibm.com:ll1985198519856{root@bandore1 ~}$
```

# For OCP（至少`OCP 4.5.x`和`OCP 4.6.x`都可以这样）

起因就是docker搞了那个pull limite。。。解决的主要思路就是不能再匿名拉取镜像了，只能用自己的dockerhub账号登陆。
- Download rate limit https://docs.docker.com/docker-hub/download-rate-limit/
- Mitigate impact of Docker Hub Pull Request Limits https://www.openshift.com/blog/mitigate-impact-of-docker-hub-pull-request-limits

具体做法是，在OCP的 `openshift-config` namespace下有个secret就叫`pull-secret`（从OCP的webconsole登陆切换到这个namespace下的secret，会发现这个一般在最底部。我猜它应该是通用的镜像拉取的secret——也就是如果deployment里没有显式设置，应该都会用这个secret？）。
<br> 然后编辑这个secret（`选中该secret`--右侧`Actions`--`Edit Secret`--`Add Credentials`），把自己dockerhub的账号、密码填一下，保存即可。
