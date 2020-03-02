
# 官方网址

IBM Cloud Private 3.1.2 -- CLI tools guide https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.2/manage_cluster/cli_guide.html

# 故障排除

Deployment errors for ClusterImagePolicy and PodSecurityPolicy https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/troubleshoot/deploy_cluster_impo.html

Enforcing container image security https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.0/manage_images/image_security.html

# 个人实战

```sh
[root@c4-infra02 ~]# cloudctl login -a https://30.0.4.2:8443 -n kube-system --skip-ssl-validation -u admin -p ${PASSWD}
Authenticating...
OK

Targeted account mycluster Account (id-mycluster-account)

Targeted namespace kube-system

Configuring kubectl ...
Property "clusters.mycluster" unset.
Property "users.mycluster-user" unset.
Property "contexts.mycluster-context" unset.
Cluster "mycluster" set.
User "mycluster-user" set.
Context "mycluster-context" created.
Switched to context "mycluster-context".
OK

Configuring helm: /root/.helm
OK
[root@c4-infra02 ~]#
```
