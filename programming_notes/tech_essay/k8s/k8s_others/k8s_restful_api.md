
# 官方

使用 Kubernetes API 访问集群 https://kubernetes.io/zh/docs/tasks/administer-cluster/access-cluster-api/ || Access Clusters Using the Kubernetes API || https://kubernetes.io/docs/tasks/administer-cluster/access-cluster-api/

```sh
# 个人实战该文章内容

[root@centos11 ~]# kubectl config view -o jsonpath='{"Cluster name\tServer\n"}{range .clusters[*]}{.name}{"\t"}{.cluster.server}{"\n"}{end}'
Cluster name    Server
kubernetes      https://9.46.89.76:6443
[root@centos11 ~]#
[root@centos11 ~]# export CLUSTER_NAME=kubernetes
[root@centos11 ~]#
[root@centos11 ~]# APISERVER=$(kubectl config view -o jsonpath="{.clusters[?(@.name==\"$CLUSTER_NAME\")].cluster.server}")
[root@centos11 ~]# echo $APISERVER
https://9.46.89.76:6443
[root@centos11 ~]#
[root@centos11 ~]# TOKEN=$(kubectl get secrets -o jsonpath="{.items[?(@.metadata.annotations['kubernetes\.io/service-account\.name']=='default')].data.token}"|base64 -d)
[root@centos11 ~]# echo $TOKEN
eyJhbGciOiJSUzI1NiIsImtpZCI6InowcGd5SWNJMGVvZlRTcnhVa0lOa2Y5ZlVCd3N4aWFDODdfTFFWYmxHdXcifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRlZmF1bHQtdG9rZW4taHh6NzciLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGVmYXVsdCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjZkZDE0YzA3LTc3MzUtNDE4NS1iMzBmLTdmOTU2MzRjMDExNSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmRlZmF1bHQifQ.M1t-Uy2wj_OpZuNb143HEaKomINUuvG03-ka5DIZr_OnmUD1o-M0OuJ6JWBe9CVyAd2ruAslPEcuECON2Njcs0TDKleYbWb9kmDoGbYVP8GlDO0kIV6NRH2_o5TAydorh4CwnlbPPpc1XvDlErSYovCZ1F9SWZI27B4V8_VtrwnhUBKRXProkeq9i3sVoL2h18JEhoEYLh-l52NmYoz7gGT4VKDW9O1rCSDdj2LGWyPGYJwewd0MQWJF_nuFsuaXfK6FTWl7k7zC0XfFNGFTYYz5xvLqZaxneHQM_P5j6e3T06S_md_gFyBP6jMBB00RTgvVHS-lzCS13QhyKnjx6A
[root@centos11 ~]#
[root@centos11 ~]# curl -X GET $APISERVER/api --header "Authorization: Bearer $TOKEN" --insecure
{
  "kind": "APIVersions",
  "versions": [
    "v1"
  ],
  "serverAddressByClientCIDRs": [
    {
      "clientCIDR": "0.0.0.0/0",
      "serverAddress": "9.46.89.76:6443"
    }
  ]
[root@centos11 ~]#

----------------------------------------------------------------------------------------------------

[root@centos11 ~]# APISERVER=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')
[root@centos11 ~]# TOKEN=$(kubectl get secret $(kubectl get serviceaccount default -o jsonpath='{.secrets[0].name}') -o jsonpath='{.data.token}' | base64 --decode )
[root@centos11 ~]# curl $APISERVER/api --header "Authorization: Bearer $TOKEN" --insecure
{
  "kind": "APIVersions",
  "versions": [
    "v1"
  ],
  "serverAddressByClientCIDRs": [
    {
      "clientCIDR": "0.0.0.0/0",
      "serverAddress": "9.46.89.76:6443"
    }
  ]
[root@centos11 ~]#

```

# 其他

kubernetes之使用http rest api访问集群 https://www.cnblogs.com/tylerzhou/p/11094872.html

User "system:serviceaccount:default:default" cannot get at the cluster scope. https://github.com/fabric8io/fabric8/issues/6840

Executing commands in Pods using K8s API https://www.openshift.com/blog/executing-commands-in-pods-using-k8s-api
- > The first one is Authorization, with a value of Bearer <token> that authenticates the request. For Kubernetes, follow this guide. With OpenShift, simply get the token for your user: `oc whoami -t`
  
