
# Vault官方

HashiCorp Vault https://www.hashicorp.com/blog/vault-announcement/
- > Today ***{APR 28 2015}*** we announce Vault—a tool for securely managing secrets and encrypting data in-transit. From storing credentials and API keys to encrypting passwords for user signups, Vault is meant to be a solution for all secret management needs.

## Vault官方github

Vault -- A tool for secrets management, encryption as a service, and privileged access management https://github.com/hashicorp/vault

Helm chart to install Vault and other associated components. https://github.com/hashicorp/vault-helm

Vault + Kubernetes (vault-k8s) -- First-class support for Vault and Kubernetes. https://github.com/hashicorp/vault-k8s

## Vault官方文档

Transit Secrets Engine https://www.vaultproject.io/docs/secrets/transit/index.html

Transit Secrets Re-wrapping https://learn.hashicorp.com/vault/encryption-as-a-service/eaas-transit-rewrap

### 官方getting start

**GETTING STARTED**
- Install Vault https://learn.hashicorp.com/vault/getting-started/install
```sh
# 就一个二进制，下载安装好
wget https://releases.hashicorp.com/vault/1.3.4/vault_1.3.4_linux_amd64.zip
unzip vault_1.3.4_linux_amd64.zip
mv vault /usr/local/bin/vault

root@temptest packages $ vault
Usage: vault <command> [args]

Common commands:
    read        Read data and retrieves secrets
    write       Write data, configuration, and secrets
    delete      Delete secrets and configuration
    list        List data or secrets
    login       Authenticate locally
    agent       Start a Vault agent
    server      Start a Vault server
    status      Print seal and HA status
    unwrap      Unwrap a wrapped secret

Other commands:
    audit          Interact with audit devices
    auth           Interact with auth methods
    debug          Runs the debug command
    kv             Interact with Vault's Key-Value storage
    lease          Interact with leases
    namespace      Interact with namespaces
    operator       Perform operator-specific tasks
    path-help      Retrieve API help for paths
    plugin         Interact with Vault plugins and catalog
    policy         Interact with policies
    print          Prints runtime configurations
    secrets        Interact with secrets engines
    ssh            Initiate an SSH session
    token          Interact with tokens

root@temptest packages $ vault -autocomplete-install
root@temptest packages $ cat ~/.bashrc
// ...
// 前面一堆省略
// ...
complete -C /usr/local/bin/vault vault

// 这句执行完不只是vault自动完成可以了，bash的一些变量也变了，导致外观变了。
root@temptest packages $ exec $SHELL
[root@temptest packages]#
```
- Starting the Server https://learn.hashicorp.com/vault/getting-started/dev-server
```sh
[root@temptest packages]# vault server -dev
==> Vault server configuration:

             Api Address: http://127.0.0.1:8200
                     Cgo: disabled
         Cluster Address: https://127.0.0.1:8201
              Listener 1: tcp (addr: "127.0.0.1:8200", cluster address: "127.0.0.1:8201", max_request_duration: "1m30s", max_request_size: "33554432", tls: "disabled")
               Log Level: info
                   Mlock: supported: true, enabled: false
           Recovery Mode: false
                 Storage: inmem
                 Version: Vault v1.3.4

WARNING! dev mode is enabled! In this mode, Vault runs entirely in-memory
and starts unsealed with a single unseal key. The root token is already
authenticated to the CLI, so you can immediately begin using Vault.

You may need to set the following environment variable:

    $ export VAULT_ADDR='http://127.0.0.1:8200'

The unseal key and root token are displayed below in case you want to
seal/unseal the Vault or re-authenticate.

Unseal Key: FvCU6vYjiSB5303xfICjeDpnf2tuw+nhELk87Ofh+TQ=
Root Token: s.coU0qNEvBQbEFfxuqLKaCK7Q

Development mode should NOT be used in production installations!

==> Vault server started! Log data will stream in below:
// ...
// 其他日志信息省略
// ...


# 另起一个terminal
// 故意试试先不export那个环境变量会怎么样
root@temptest ~ $ vault status
Error checking seal status: Get https://127.0.0.1:8200/v1/sys/seal-status: http: server gave HTTP response to HTTPS client
root@temptest ~ $ export VAULT_ADDR='http://127.0.0.1:8200'
root@temptest ~ $ vault status
Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    1
Threshold       1
Version         1.3.4
Cluster Name    vault-cluster-0c58c058
Cluster ID      4429c4e6-726e-abc3-49f1-fa73c79952a1
HA Enabled      false
root@temptest ~ $
```
- Your First Secret https://learn.hashicorp.com/vault/getting-started/first-secret
```sh
root@temptest ~ $
root@temptest ~ $ vault kv put secret/hello foo=world
Key              Value
---              -----
created_time     2020-03-24T06:14:14.485735661Z
deletion_time    n/a
destroyed        false
version          1
root@temptest ~ $
root@temptest ~ $ vault kv put secret/hello foo=world excited=yes
Key              Value
---              -----
created_time     2020-03-24T06:15:10.887013874Z
deletion_time    n/a
destroyed        false
version          2
root@temptest ~ $
root@temptest ~ $ vault kv get secret/hello
====== Metadata ======
Key              Value
---              -----
created_time     2020-03-24T06:15:10.887013874Z
deletion_time    n/a
destroyed        false
version          2

===== Data =====
Key        Value
---        -----
excited    yes
foo        world
root@temptest ~ $
root@temptest ~ $ vault kv get -field=excited secret/hello
yes
root@temptest ~ $
root@temptest ~ $ vault kv get -format=json secret/hello | jq -r .data.data.excited
yes
root@temptest ~ $
root@temptest ~ $ vault kv delete secret/hello
Success! Data deleted (if it existed) at: secret/hello
root@temptest ~ $
```
- Secrets Engines https://learn.hashicorp.com/vault/getting-started/secrets-engines
  * > As mentioned above, Vault behaves similarly to a [virtual filesystem](https://en.wikipedia.org/wiki/Virtual_file_system). The read/write/delete/list operations are forwarded to the corresponding secrets engine, and the secrets engine decides how to react to those operations. <br> This abstraction is incredibly powerful. It enables Vault to interface directly with physical systems, databases, HSMs, etc. But in addition to these physical systems, Vault can interact with more unique environments like AWS IAM, dynamic SQL user creation, etc. all while using the same read/write interface.

# Vault与其他整合

Kubernetes https://www.vaultproject.io/docs/platform/k8s/index.html

## 与Terraform整合

Vault Provider https://www.terraform.io/docs/providers/vault/index.html

# Vault其他帖子

【shuhari.dev/】
- 私密信息管理利器 HashiCorp Vault——简介 https://juejin.im/entry/5a7c0fcd5188255efc5f457e || https://shuhari.dev/blog/2018/02/vault-introduction
- 私密信息管理利器 HashiCorp Vault——启动和读写 https://juejin.im/entry/5a7d34dc5188257a7e3f1b84 || https://shuhari.dev/blog/2018/02/vault-upstart
- 私密信息管理利器 HashiCorp Vault——部署 https://juejin.im/entry/5a94d4755188257a5911edb4

Vault 笔记 https://huangjunwen.github.io/post/2017/vault/

# Vault实战

```sh
# 获取当前的token数量
pguser@temptest ~ $ vault read sys/internal/counters/tokens
Key         Value
---         -----
counters    map[service_tokens:map[total:1]]
```

# Vault竞品

Vault vs. Keywhiz https://www.vaultproject.io/docs/vs/keywhiz/

Keywhiz vs Vault https://stackshare.io/stackups/keywhiz-vs-vault

互联网项目里，如何以正确的姿势保存密码？ - 陈天的文章 - 知乎 https://zhuanlan.zhihu.com/p/20135083
