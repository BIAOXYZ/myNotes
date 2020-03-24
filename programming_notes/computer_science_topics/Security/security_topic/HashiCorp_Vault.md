
# Vault官方

HashiCorp Vault https://www.hashicorp.com/blog/vault-announcement/
- > Today ***{APR 28 2015}*** we announce Vault—a tool for securely managing secrets and encrypting data in-transit. From storing credentials and API keys to encrypting passwords for user signups, Vault is meant to be a solution for all secret management needs.

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
```
