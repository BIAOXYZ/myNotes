
# kubernetes从私有仓库拖镜像

从私有仓库拉取镜像 https://v1-18.docs.kubernetes.io/zh/docs/tasks/configure-pod-container/pull-image-private-registry/

k8s实战之从私有仓库拉取镜像 https://www.cnblogs.com/justmine/p/8678758.html

## 个人实战

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
