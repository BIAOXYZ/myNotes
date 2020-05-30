
# 官网

https://podman.io/

# 其他

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
