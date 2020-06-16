
```sh
# A typo ("-oyaml") in kubeadm reset...
{root@bandore1 ~}$ kubeadm reset
[reset] Reading configuration from the cluster...
[reset] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
[reset] WARNING: Changes made to this host by 'kubeadm init' or 'kubeadm join' will be reverted.
[reset] Are you sure you want to proceed? [y/N]: n

{root@bandore1 guestbook}$ kubeadm version
kubeadm version: &version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.2", GitCommit:"52c56ce7a8272c798dbc29846288d7cd9fbae032",
GitTreeState:"clean", BuildDate:"2020-04-16T11:54:15Z", GoVersion:"go1.13.9", Compiler:"gc", Platform:"linux/amd64"}
```

### kinder/pkg/cluster/manager/actions/kubeadm-reset.go

- `func KubeadmReset(c *status.Cluster, vLevel int) error {` https://github.com/kubernetes/kubeadm/blob/ffa0bf52e3fa5ec5c2139f36893c718af77e4b3b/kinder/pkg/cluster/manager/actions/kubeadm-reset.go#L26

### kinder/pkg/cluster/status/node.go

- `func (n *Node) Command(command string, args ...string) *exec.NodeCmd {` https://github.com/kubernetes/kubeadm/blob/ffa0bf52e3/kinder/pkg/cluster/status/node.go#L140
