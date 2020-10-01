
# 官网

Podman https://podman.io/

libpod is a library used to create container pods. Home of Podman. https://github.com/containers/libpod
> Libpod provides a library for applications looking to use the Container Pod concept, popularized by Kubernetes. Libpod also contains the Pod Manager tool (Podman). Podman manages pods, containers, container images, and container volumes.

# 其他

利用Podman和Buildah构建容器镜像 https://mp.weixin.qq.com/s/WQA729T78I4c24_gH1VXxw || https://www.giantswarm.io/blog/building-container-images-with-podman-and-buildah

Podman 初次体验 https://zdyxry.github.io/2019/10/12/Podman-%E5%88%9D%E6%AC%A1%E4%BD%93%E9%AA%8C/
- Buildah 初次体验 https://zdyxry.github.io/2019/10/19/Buildah-%E5%88%9D%E6%AC%A1%E4%BD%93%E9%AA%8C/
- Skopeo 初次体验 https://zdyxry.github.io/2019/10/26/Skopeo-%E5%88%9D%E6%AC%A1%E4%BD%93%E9%AA%8C/

# 个人实战

```sh
[root@worker3 ~]# podman login hyc-cp4mcm-team-docker-local.artifactory.swg-devops.com -u liulliu@cn.ibm.com -p <your_password>
Login Succeeded!
[root@worker3 ~]#
[root@worker3 ~]# podman pull hyc-cp4mcm-team-docker-local.artifactory.swg-devops.com/ibmcom/cp4mcm-application-ui-amd64:3.6.0
Trying to pull hyc-cp4mcm-team-docker-local.artifactory.swg-devops.com/ibmcom/cp4mcm-application-ui-amd64:3.6.0...
Getting image source signatures
Copying blob 03e56b46bf0b skipped: already exists
Copying blob f66dd86ccbcb skipped: already exists
Copying blob 3a13cc2f5d65 skipped: already exists
Copying blob 233d4a1f1858 done
Copying blob d31892fb467c done
Copying blob 5e56f2ce5e82 done
Copying blob c3e679ccc739 done
Copying blob 913a79266f12 done
Copying config 18f78b2dd5 done
Writing manifest to image destination
Storing signatures
18f78b2dd5f0be09226796aa922c2c391d8bf2bff4f37625f2c5166dea83d490
[root@worker3 ~]#
```
