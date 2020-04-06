
# 利用AWX从Ansible Tower中获得HashiCorp Vault Secret Lookup类型证书的Test操作发了些啥

## 0.环境信息

```console
Tower环境的地址为： https://9.46.74.222/#/login
Vault Server地址为： http://9.12.248.133:8200
```
## 1.AWX命令初试

```sh
[root@agentavtone-worker1 ~]# awx --conf.host https://localhost --help
usage: awx [--help] [--version] [--conf.host https://example.awx.org]
           [--conf.token TEXT] [--conf.username TEXT] [--conf.password TEXT]
           [-k] [-f {yaml,json,jq,human}] [--filter TEXT]
           [--conf.color BOOLEAN] [-v]
           resource ...

positional arguments:
  resource
    login               authenticate and retrieve an OAuth2 token
    config              print current configuration values

optional arguments:
  --help                prints usage information for the awx tool
  --version             display awx CLI version

authentication:
  --conf.host https://example.awx.org
  --conf.token TEXT     an OAuth2.0 token (get one by using `awx login`)
  --conf.username TEXT
  --conf.password TEXT
  -k, --conf.insecure   Allow insecure server connections when using SSL

output formatting:
  -f {yaml,json,jq,human}, --conf.format {yaml,json,jq,human}
                        specify an output format
  --filter TEXT         specify an output filter (only valid with jq or human
                        format)
  --conf.color BOOLEAN  Display colorized output. Defaults to True
  -v, --verbose         print debug-level logs, including requests made

awx: too few arguments
[root@agentavtone-worker1 ~]#


#// 如果要用外网IP就必须有类似认证的东西了，下面这俩语句都会失败
#// awx --conf.host https://9.46.74.222 --help
#// awx --conf.host https://9.46.74.222 --conf.insecure users --help


[root@agentavtone-worker1 ~]# awx --conf.host https://9.46.74.222 --conf.username admin --conf.password Zhu88jie --conf.insecure users list
{
     "count": 1,
     "next": null,
     "results": [
          {
               "username": "admin",
               "last_name": "",
               "is_system_auditor": false,
               "ldap_dn": "",
               "external_account": null,
               "related": {
                    "admin_of_organizations": "/api/v2/users/1/admin_of_organizations/",
                    "organizations": "/api/v2/users/1/organizations/",
                    "roles": "/api/v2/users/1/roles/",
                    "authorized_tokens": "/api/v2/users/1/authorized_tokens/",
                    "access_list": "/api/v2/users/1/access_list/",
                    "teams": "/api/v2/users/1/teams/",
                    "tokens": "/api/v2/users/1/tokens/",
                    "personal_tokens": "/api/v2/users/1/personal_tokens/",
                    "credentials": "/api/v2/users/1/credentials/",
                    "activity_stream": "/api/v2/users/1/activity_stream/",
                    "projects": "/api/v2/users/1/projects/"
               },
               "auth": [],
               "id": 1,
               "first_name": "",
               "created": "2020-02-05T04:28:17.722947Z",
               "url": "/api/v2/users/1/",
               "summary_fields": {
                    "user_capabilities": {
                         "edit": true,
                         "delete": false
                    }
               },
               "is_superuser": true,
               "last_login": "2020-04-06T07:08:17.797084Z",
               "type": "user",
               "email": "admin@example.com"
          }
     ],
     "previous": null
}
[root@agentavtone-worker1 ~]#


[root@agentavtone-worker1 ~]# awx --conf.host https://9.46.74.222 --conf.username admin --conf.password Zhu88jie --conf.insecure users --help
usage: awx users [-h] action ...

positional arguments:
  action
    create
    list
    get
    modify
    delete
    grant
    revoke

optional arguments:
  -h, --help  show this help message and exit

awx users: too few arguments
[root@agentavtone-worker1 ~]#
[root@agentavtone-worker1 ~]# awx --conf.host https://9.46.74.222 --conf.username admin --conf.password Zhu88jie --conf.insecure users create --help
usage: awx users create [-h] --username TEXT [--first_name TEXT]
                        [--last_name TEXT] [--is_system_auditor BOOLEAN]
                        [--is_superuser BOOLEAN] [--last_login LAST_LOGIN]
                        --password TEXT [--email TEXT]

required arguments:
  --username TEXT       Required. 150 characters or fewer. Letters, digits and
                        @/./+/-/_ only.
  --password TEXT       Write-only field used to change the password.

optional arguments:
  -h, --help            show this help message and exit
  --first_name TEXT
  --last_name TEXT
  --is_system_auditor BOOLEAN
  --is_superuser BOOLEAN
                        Designates that this user has all permissions without
                        explicitly assigning them.
  --last_login LAST_LOGIN
  --email TEXT

awx users create: argument --username is required
[root@agentavtone-worker1 ~]#
[root@agentavtone-worker1 ~]# awx --conf.host https://9.46.74.222 --conf.username admin --conf.password Zhu88jie --conf.insecure credentials --help
usage: awx credentials [-h] action ...

positional arguments:
  action
    create
    list
    get
    modify
    delete

optional arguments:
  -h, --help  show this help message and exit

awx credentials: too few arguments
[root@agentavtone-worker1 ~]#


#// 后续都假定做了这个alias，因为每次都打上host，username和password太长了。
alias awx="awx --conf.host https://9.46.74.222 --conf.username admin --conf.password Zhu88jie --conf.insecure"
```

```sh
# 从旧版tower-cli，经过改编，找到目前对应的cli语句的过程：

#// https://medium.com/@claudio.domingos/ansible-awx-from-scratch-to-rest-api-part-7-of-8-c84bc443de6e
##// tower-cli credential create --organization "Default" --name="Vault AWX" --credential-type="Vault" --inputs='{"vault_password": "myvaultpass"}'  

#// 根据上面的语句先改编了这个：
##// awx credential create --organization "Default" --name="Vault AWX1234" --credential-type="Vault" --inputs='{"vault_password": "myvaultpass"}'  
##// 结果提示：awx credentials create: argument --credential_type is required 看来是短横线变底横线

#// 下面这俩创建Vault类型和Hash 语句均成功
##// http://9.12.248.133:8200 就是我在temptest上的vault服务器的地址。
awx credential create --organization "Default" --name="Vault AWX1234" --credential_type="Vault" --inputs='{"vault_password": "myvaultpass"}'
awx credential create --organization "Default" --name="test_vault_credential_from_api" --credential_type="HashiCorp Vault Secret Lookup" --inputs='{"url": "http://9.12.248.133:8200", "token": "s.PXt2I4TrXMu9NMCa15ePW2P2", "api_version": "v1"}'

[root@agentavtone-worker1 ~]# alias awx="awx --conf.host https://9.46.74.222 --conf.username admin --conf.password Zhu88jie --conf.insecure"
[root@agentavtone-worker1 ~]#
[root@agentavtone-worker1 ~]# awx credential create --organization "Default" --name="Vault AWX1234" --credential_type="Vault" --inputs='{"vault_password": "myvaultpass"}'
{
     "inputs": {
          "vault_password": "$encrypted$"
     },
     "kind": "vault",
     "name": "Vault AWX1234",
     "kubernetes": false,
     "created": "2020-04-06T07:33:58.313338Z",
     "url": "/api/v2/credentials/7/",
     "summary_fields": {
          "owners": [
               {
                    "url": "/api/v2/organizations/1/",
                    "type": "organization",
                    "description": "",
                    "name": "Default",
                    "id": 1
               }
          ],
          "modified_by": {
               "username": "admin",
               "first_name": "",
               "last_name": "",
               "id": 1
          },
          "user_capabilities": {
               "edit": true,
               "use": true,
               "copy": true,
               "delete": true
          },
          "organization": {
               "description": "",
               "name": "Default",
               "id": 1
          },
          "object_roles": {
               "admin_role": {
                    "id": 50,
                    "name": "Admin",
                    "description": "Can manage all aspects of the credential"
               },
               "use_role": {
                    "id": 51,
                    "name": "Use",
                    "description": "Can use the credential in a job template"
               },
               "read_role": {
                    "id": 52,
                    "name": "Read",
                    "description": "May view settings for the credential"
               }
          },
          "created_by": {
               "username": "admin",
               "first_name": "",
               "last_name": "",
               "id": 1
          }
     },
     "modified": "2020-04-06T07:33:58.313370Z",
     "credential_type": 3,
     "organization": 1,
     "type": "credential",
     "id": 7,
     "cloud": false,
     "description": ""
}
[root@agentavtone-worker1 ~]#
[root@agentavtone-worker1 ~]# awx credential create --organization "Default" --name="test_vault_credential_from_api" --credential_type="HashiCorp Vault Secret Lookup" --inputs='{"url": "http://9.12.248.133:8200", "token": "s.PXt2I4TrXMu9NMCa15ePW2P2", "api_version": "v1"}'
{
     "inputs": {
          "url": "http://9.12.248.133:8200",
          "token": "$encrypted$",
          "api_version": "v1"
     },
     "kind": "hashivault_kv",
     "name": "test_vault_credential_from_api",
     "kubernetes": false,
     "created": "2020-04-06T07:34:14.840899Z",
     "url": "/api/v2/credentials/8/",
     "summary_fields": {
          "owners": [
               {
                    "url": "/api/v2/organizations/1/",
                    "type": "organization",
                    "description": "",
                    "name": "Default",
                    "id": 1
               }
          ],
          "modified_by": {
               "username": "admin",
               "first_name": "",
               "last_name": "",
               "id": 1
          },
          "user_capabilities": {
               "edit": true,
               "use": true,
               "copy": true,
               "delete": true
          },
          "organization": {
               "description": "",
               "name": "Default",
               "id": 1
          },
          "object_roles": {
               "admin_role": {
                    "id": 53,
                    "name": "Admin",
                    "description": "Can manage all aspects of the credential"
               },
               "use_role": {
                    "id": 54,
                    "name": "Use",
                    "description": "Can use the credential in a job template"
               },
               "read_role": {
                    "id": 55,
                    "name": "Read",
                    "description": "May view settings for the credential"
               }
          },
          "created_by": {
               "username": "admin",
               "first_name": "",
               "last_name": "",
               "id": 1
          }
     },
     "modified": "2020-04-06T07:34:14.840926Z",
     "credential_type": 21,
     "organization": 1,
     "type": "credential",
     "id": 8,
     "cloud": false,
     "description": ""
}
[root@agentavtone-worker1 ~]#
```

## 2.但是上面AWX没有Test相关的cli命令，Test时只有restful api的。所以只能换个方法。

### 首先这个链接里说可以用`Firebug`

https://docs.ansible.com/ansible-tower/2.3.0/html/towerapi/intro.html
> You may find it helpful see which API calls Tower makes in sequence. To do this, you can use the UI from `Firebug` or Chrome with developer plugins.

### 但是后来查了下`Firebug`已经弃用了基本，现在是用Firefox开发者工具。

>> 用Firefox打开Tower的网页，成功Test一次，能抓到如下信息：

```
请求网址:https://9.46.74.222/api/v2/credentials/2/test/
请求方法:POST
远程地址:9.46.74.222:443

#// key用target可以成功（因为Vault里就是这个key）
{"inputs":{"url":"http://9.12.248.133:8200","token":"$encrypted$","api_version":"v1"},"metadata":{"secret_path":"kv/hello","secret_key":"target"}}

#// key用target123就肯定失败了
{"inputs":{"url":"http://9.12.248.133:8200","token":"$encrypted$","api_version":"v1"},"metadata":{"secret_path":"kv/hello","secret_key":"target123"}}
```

>> 后来发现可以直接复制完整的语句出来。。。Chrome开发者工具也可以。
>>> curl 'https://9.46.74.222/api/v2/credentials/2/test/' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:74.0) Gecko/20100101 Firefox/74.0' -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2' --compressed -H 'Content-Type: application/json;charset=utf-8' -H 'X-Requested-With: XMLHttpRequest' -H 'X-CSRFToken: 2lawqXEnzkmr7nFIurCh7Zd0Lv5sZrhZszKv30EmlNC9bLhGiPn4wGrn7lOda8TK' -H 'Origin: https://9.46.74.222' -H 'Connection: keep-alive' -H 'Referer: https://9.46.74.222/' -H 'Cookie: csrftoken=2lawqXEnzkmr7nFIurCh7Zd0Lv5sZrhZszKv30EmlNC9bLhGiPn4wGrn7lOda8TK; sessionExpired=false; lastPath=%2Fcredentials%2F2; current_user=%7B%22id%22%3A1%2C%22type%22%3A%22user%22%2C%22url%22%3A%22%2Fapi%2Fv2%2Fusers%2F1%2F%22%2C%22related%22%3A%7B%22teams%22%3A%22%2Fapi%2Fv2%2Fusers%2F1%2Fteams%2F%22%2C%22organizations%22%3A%22%2Fapi%2Fv2%2Fusers%2F1%2Forganizations%2F%22%2C%22admin_of_organizations%22%3A%22%2Fapi%2Fv2%2Fusers%2F1%2Fadmin_of_organizations%2F%22%2C%22projects%22%3A%22%2Fapi%2Fv2%2Fusers%2F1%2Fprojects%2F%22%2C%22credentials%22%3A%22%2Fapi%2Fv2%2Fusers%2F1%2Fcredentials%2F%22%2C%22roles%22%3A%22%2Fapi%2Fv2%2Fusers%2F1%2Froles%2F%22%2C%22activity_stream%22%3A%22%2Fapi%2Fv2%2Fusers%2F1%2Factivity_stream%2F%22%2C%22access_list%22%3A%22%2Fapi%2Fv2%2Fusers%2F1%2Faccess_list%2F%22%2C%22tokens%22%3A%22%2Fapi%2Fv2%2Fusers%2F1%2Ftokens%2F%22%2C%22authorized_tokens%22%3A%22%2Fapi%2Fv2%2Fusers%2F1%2Fauthorized_tokens%2F%22%2C%22personal_tokens%22%3A%22%2Fapi%2Fv2%2Fusers%2F1%2Fpersonal_tokens%2F%22%7D%2C%22summary_fields%22%3A%7B%22user_capabilities%22%3A%7B%22edit%22%3Atrue%2C%22delete%22%3Afalse%7D%7D%2C%22created%22%3A%222020-02-05T04%3A28%3A17.722947Z%22%2C%22username%22%3A%22admin%22%2C%22first_name%22%3A%22%22%2C%22last_name%22%3A%22%22%2C%22email%22%3A%22admin%40example.com%22%2C%22is_superuser%22%3Atrue%2C%22is_system_auditor%22%3Afalse%2C%22ldap_dn%22%3A%22%22%2C%22last_login%22%3A%222020-04-03T05%3A13%3A32.253388Z%22%2C%22external_account%22%3Anull%2C%22auth%22%3A%5B%5D%7D; sessionid=xtc9rttxntt2efwc980dbskt4jeaufrz; userLoggedIn=true' --data '{"inputs":{"url":"http://9.12.248.133:8200","token":"$encrypted$","api_version":"v1"},"metadata":{"secret_path":"kv/hello","secret_key":"target"}}'

## 3.到这里算是把Tower图形界面里点Test时的完整命令抓出来了，但是希望更进一步。

```sh
#//【网址】 HTTP API https://www.vaultproject.io/api/index.html
$ curl \
    -H "X-Vault-Token: f3b09679-3001-009d-2b80-9c306ab81aa6" \
    -X GET \
    http://127.0.0.1:8200/v1/ns1/ns2/secret/foo


[root@agentavtone-worker1 ~]# curl -H "X-Vault-Token: s.PXt2I4TrXMu9NMCa15ePW2P2" -X GET http://9.12.248.133:8200/v1/kv/hello/target
{"errors":[]}
[root@agentavtone-worker1 ~]#
[root@agentavtone-worker1 ~]# curl -H "X-Vault-Token: s.PXt2I4TrXMu9NMCa15ePW2P2" -X GET http://9.12.248.133:8200/v1/kv
{"errors":[]}
[root@agentavtone-worker1 ~]#
[root@agentavtone-worker1 ~]# curl -H "X-Vault-Token: s.PXt2I4TrXMu9NMCa15ePW2P2" -X GET http://9.12.248.133:8200/v1/kv/hello
{"request_id":"df034a31-5bae-435c-4ebb-704c1dd3d754","lease_id":"","renewable":false,"lease_duration":2764800,"data":{"target":"world"},"wrap_info":null,"warnings":null,"auth":null}
[root@agentavtone-worker1 ~]# curl -i -H "X-Vault-Token: s.PXt2I4TrXMu9NMCa15ePW2P2" -X GET http://9.12.248.133:8200/v1/kv/hello
HTTP/1.1 200 OK
Cache-Control: no-store
Content-Type: application/json
Date: Fri, 03 Apr 2020 05:18:52 GMT
Content-Length: 182

{"request_id":"0c9a728f-804f-3ef0-0e4f-4af61b44ffca","lease_id":"","renewable":false,"lease_duration":2764800,"data":{"target":"world"},"wrap_info":null,"warnings":null,"auth":null}
```

```sh
#//【网址】 KV Secrets Engine - Version 1 (API) https://www.vaultproject.io/api-docs/secret/kv/kv-v1/
$ curl \
    --header "X-Vault-Token: ..." \
    --request LIST \
    https://127.0.0.1:8200/v1/secret/my-secret


root@temptest ~ $ curl --header "X-Vault-Token: s.PXt2I4TrXMu9NMCa15ePW2P2" --request LIST http://9.12.248.133:8200/v1/kv
{"request_id":"a0448313-9c72-9e35-562c-9bd0a5e44adc","lease_id":"","renewable":false,"lease_duration":0,"data":{"keys":["hello"]},"wrap_info":null,"warnings":null,"auth":null}
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
