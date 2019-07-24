
# 0. Preliminaries

Let's dispaly the whole procedure of utilizing `ansible k8s_scale module` to scale up and down an (nginx) deployment. It may be useful for future development of `ansible operator`.

## 0.1 References/Links 

k8s_scale – Set a new size for a Deployment, ReplicaSet, Replication Controller, or Job https://docs.ansible.com/ansible/latest/modules/k8s_scale_module.html
>> personal notes: A more general ansible module for kubernetes is [k8s – Manage Kubernetes (K8s) objects](https://docs.ansible.com/ansible/latest/modules/k8s_module.html)

## 0.2 Enviroment info

```
$ oc version
oc v3.11.0+e5dbec2-186
kubernetes v1.11.0+d4cacc0
features: Basic-Auth GSSAPI Kerberos SPNEGO

Server https://master:8443
openshift v3.11.0+9b1e777-164
kubernetes v1.11.0+d4cacc0

$ ansible --version
ansible 2.7.1
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/root/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/site-packages/ansible
  executable location = /usr/bin/ansible
  python version = 2.7.5 (default, Apr  9 2019, 14:30:50) [GCC 4.8.5 20150623 (Red Hat 4.8.5-36)]
```

## 0.3 Prepared files

> mydeploymentnginx.yaml
>> It will be used to generate a test deployment.
```
cat << EOF > mydeploymentnginx.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  replicas: 2
  template:
    metadata:
      name: nginx
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        imagePullPolicy: IfNotPresent
      restartPolicy: Always
  selector:
    matchLabels:
      app: nginx
EOF
```

> k8s-scale-obj.yaml
>> This is the main file which will be used for ansbile operator.
```
cat << EOF > k8s-scale-obj.yaml
- hosts: localhost
  tasks:
  - name: Scale a k8s object and extend timeout
    k8s_scale:
      api_version: "{{ apiversion }}"
      kind: "{{ kind }}"
      name: "{{ name }}"
      namespace: "{{ namespace }}"
      replicas: "{{ replicas }}"
      wait_timeout: 60
EOF
```

# 1. The whole procedure

```
// Create the deployment and query for the origin state.

$ oc apply -f mydeploymentnginx.yaml
deployment.apps/nginx created

$ oc get deployment
NAME      DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
nginx     2         2         2            0           11s

$ oc get pods
NAME                       READY     STATUS    RESTARTS   AGE
docker-registry-1-v2tx7    1/1       Running   0          1h
nginx-5d44458958-mdfp4     1/1       Running   0          17s
nginx-5d44458958-qkg6s     1/1       Running   0          17s
registry-console-1-stz66   1/1       Running   0          1h
router-1-xlp7j             1/1       Running   0          1h
```

```
// Conduct scale up step.

$ ansible-playbook k8s-scale-obj.yaml --extra-vars "apiversion=extensions/v1beta1 kind=deployment namespace=default name=nginx replicas=3"
 [WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'

 [WARNING]: Found variable using reserved name: name


PLAY [localhost] ***************************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************
ok: [localhost]

TASK [Scale a k8s object and extend timeout] ***********************************************************************************************************
changed: [localhost]

PLAY RECAP *********************************************************************************************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0
```

```
// Scale up succeeds.

$ oc get deployment
NAME      DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
nginx     3         3         3            3           1m
$
$ oc get pods
NAME                       READY     STATUS    RESTARTS   AGE
docker-registry-1-v2tx7    1/1       Running   0          1h
nginx-5d44458958-mdfp4     1/1       Running   0          1m
nginx-5d44458958-mzgcx     1/1       Running   0          20s
nginx-5d44458958-qkg6s     1/1       Running   0          1m
registry-console-1-stz66   1/1       Running   0          1h
router-1-xlp7j             1/1       Running   0          1h
```

```
// Conduct scale down step.

$ ansible-playbook k8s-scale-obj.yaml --extra-vars "apiversion=extensions/v1beta1 kind=deployment namespace=default name=nginx replicas=1"
 [WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'

 [WARNING]: Found variable using reserved name: name


PLAY [localhost] ***************************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************
ok: [localhost]

TASK [Scale a k8s object and extend timeout] ***********************************************************************************************************
changed: [localhost]

PLAY RECAP *********************************************************************************************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0
```

```
// Scale down succeeds.

$ oc get deployment
NAME      DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
nginx     1         1         1            1           4m
$
$ oc get pods
NAME                       READY     STATUS    RESTARTS   AGE
docker-registry-1-v2tx7    1/1       Running   0          1h
nginx-5d44458958-qkg6s     1/1       Running   0          4m
registry-console-1-stz66   1/1       Running   0          1h
router-1-xlp7j             1/1       Running   0          1h
```

# 2.后续的新问题

后来发现因为各种鸟原因，之前这个小实验跑的好好的，但是现在就是不能跑了。下面是解决的全过程，我认为核心点是：**机器上得有[`openshift python库`](https://github.com/openshift/openshift-restclient-python)，并且版本不能太高（<0.9.0）**。

## 2.1 按照过去的步骤去执行，结果发现报错，提示需要安装OpenShift Python client

```
root@openshiftsingle 1-dynamic-param $ ansible-playbook k8s-scale-obj.yaml --extra-vars "apiversion=extensions/v1beta1 kind=deployment namespace=default name=nginx replicas=3"
 [WARNING]: Found variable using reserved name: name


PLAY [localhost] ******************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************
ok: [localhost]

TASK [Scale a k8s object and extend timeout] **************************************************************************************************************
fatal: [localhost]: FAILED! => {"changed": false, "msg": "This module requires the OpenShift Python client. Try `pip install openshift`"}
        to retry, use: --limit @/root/migrationproj/1-dynamic-param/k8s-scale-obj.retry

PLAY RECAP ************************************************************************************************************************************************
localhost                  : ok=1    changed=0    unreachable=0    failed=1   

```

## 2.2 把pip装上

```
// 把pip装上，因为上面的报错语句里推荐的用pip安装openshift库
// 【 centos下安装Python包管理工具pip的方法总结 https://blog.csdn.net/u014236259/article/details/75212659 】

yum -y install epel-release
yum --enablerepo=epel install python-pip -y
```

## 2.3

```
// 装上pip后先是版本过低————我现在越来越相信CentOS不如Ubuntu了 --> pip大版本都到19了，结果CentOS里
// 自带的才8（还是epel带的，CentOS基本库没有！）
root@openshiftsingle 1-dynamic-param $ pip install openshift
Collecting openshift
  Downloading https://files.pythonhosted.org/packages/f7/a2/0779391c48ad70ffe3af51a03f7094d53ad5b4016a4fe87acf047ac32526/openshift-0.9.0.tar.gz
    Complete output from command python setup.py egg_info:
    Traceback (most recent call last):
      File "<string>", line 1, in <module>
      File "/tmp/pip-build-s5Xt8i/openshift/setup.py", line 50, in <module>
        packages=find_packages(include='openshift.*'),
    TypeError: find_packages() got an unexpected keyword argument 'include'
    
    ----------------------------------------
Command "python setup.py egg_info" failed with error code 1 in /tmp/pip-build-s5Xt8i/openshift/
You are using pip version 8.1.2, however version 19.1.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.

// 升级pip到19.1.1新版，很顺利。
root@openshiftsingle 1-dynamic-param $ pip install --upgrade pip
Collecting pip
  Downloading https://files.pythonhosted.org/packages/5c/e0/be401c003291b56efc55aeba6a80ab790d3d4cece2778288d65323009420/pip-19.1.1-py2.py3-none-any.whl (1.4MB)
    100% |████████████████████████████████| 1.4MB 570kB/s 
Installing collected packages: pip
  Found existing installation: pip 8.1.2
    Uninstalling pip-8.1.2:
      Successfully uninstalled pip-8.1.2
Successfully installed pip-19.1.1


// 再次安装，出现了新错误。
root@openshiftsingle 1-dynamic-param $ pip install openshift
DEPRECATION: Python 2.7 will reach the end of its life on January 1st, 2020. Please upgrade your Python as Python 2.7 won't be maintained after that date. A future version of pip will drop support for Python 2.7.
Collecting openshift
  Using cached https://files.pythonhosted.org/packages/f7/a2/0779391c48ad70ffe3af51a03f7094d53ad5b4016a4fe87acf047ac32526/openshift-0.9.0.tar.gz
    ERROR: Complete output from command python setup.py egg_info:
    ERROR: Traceback (most recent call last):
      File "<string>", line 1, in <module>
      File "/tmp/pip-install-66Lf36/openshift/setup.py", line 50, in <module>
        packages=find_packages(include='openshift.*'),
    TypeError: find_packages() got an unexpected keyword argument 'include'
    ----------------------------------------
ERROR: Command "python setup.py egg_info" failed with error code 1 in /tmp/pip-install-66Lf36/openshift/

// 试试装别的版本的openshift python库，一样的。
root@openshiftsingle 1-dynamic-param $ pip install openshift==0.6.3
DEPRECATION: Python 2.7 will reach the end of its life on January 1st, 2020. Please upgrade your Python as Python 2.7 won't be maintained after that date. A future version of pip will drop support for Python 2.7.
Collecting openshift==0.6.3
  Downloading https://files.pythonhosted.org/packages/24/56/c3cb572274871a164799a693b115971b527a9f0bb6b260ffd4feaee7af16/openshift-0.6.3.tar.gz (345kB)
     |████████████████████████████████| 348kB 595kB/s 
    ERROR: Complete output from command python setup.py egg_info:
    ERROR: Traceback (most recent call last):
      File "<string>", line 1, in <module>
      File "/tmp/pip-install-l5uAar/openshift/setup.py", line 50, in <module>
        packages=find_packages(include='openshift.*'),
    TypeError: find_packages() got an unexpected keyword argument 'include'
    ----------------------------------------
ERROR: Command "python setup.py egg_info" failed with error code 1 in /tmp/pip-install-l5uAar/openshift/

// google下，在下面帖子里找到了答案。
// python – find_package()错误,通过pip安装包 https://codeday.me/bug/20190222/699735.html
// > 最佳答案：pip install -U setuptools
root@openshiftsingle 1-dynamic-param $ pip install -U setuptools
DEPRECATION: Python 2.7 will reach the end of its life on January 1st, 2020. Please upgrade your Python as Python 2.7 won't be maintained after that date. A future version of pip will drop support for Python 2.7.
Collecting setuptools
  Downloading https://files.pythonhosted.org/packages/ec/51/f45cea425fd5cb0b0380f5b0f048ebc1da5b417e48d304838c02d6288a1e/setuptools-41.0.1-py2.py3-none-any.whl (575kB)
     |████████████████████████████████| 583kB 619kB/s 
Installing collected packages: setuptools
  Found existing installation: setuptools 0.9.8
    Uninstalling setuptools-0.9.8:
      Successfully uninstalled setuptools-0.9.8
Successfully installed setuptools-41.0.1
```

```
// 终于可以用pip装openshift库了，但是最后那个ipaddress错不敢乱搞了。卡了一会，想到可以从源码安装。

root@openshiftsingle 1-dynamic-param $ pip install openshift
DEPRECATION: Python 2.7 will reach the end of its life on January 1st, 2020. Please upgrade your Python as Python 2.7 won't be maintained after that date. A future version of pip will drop support for Python 2.7.
Collecting openshift
  Using cached https://files.pythonhosted.org/packages/f7/a2/0779391c48ad70ffe3af51a03f7094d53ad5b4016a4fe87acf047ac32526/openshift-0.9.0.tar.gz
Collecting dictdiffer (from openshift)
  Downloading https://files.pythonhosted.org/packages/ac/df/630009f1609a467b4c59bada68d2e31c8ca5565a1c8188c9b44da7d7c27a/dictdiffer-0.8.0-py2.py3-none-any.whl
Requirement already satisfied: jinja2 in /usr/lib/python2.7/site-packages (from openshift) (2.7.2)
Collecting kubernetes~=9.0.0 (from openshift)
  Downloading https://files.pythonhosted.org/packages/00/f7/4f196c55f1c2713d3edc8252c4b45326306eef4dc10048f13916fe446e2b/kubernetes-9.0.0-py2.py3-none-any.whl (1.4MB)
     |████████████████████████████████| 1.4MB 931kB/s 
Collecting python-string-utils (from openshift)
  Downloading https://files.pythonhosted.org/packages/5d/13/216f2d4a71307f5a4e5782f1f59e6e8e5d6d6c00eaadf9f92aeccfbb900c/python-string-utils-0.6.0.tar.gz
Collecting ruamel.yaml>=0.15 (from openshift)
  Downloading https://files.pythonhosted.org/packages/18/7d/58c8c0f216660226588691b2ccb19884a171539d45ed7f49855b8226c9e6/ruamel.yaml-0.15.100-cp27-cp27mu-manylinux1_x86_64.whl (600kB)
     |████████████████████████████████| 604kB 17.7MB/s 
Requirement already satisfied: six in /usr/lib/python2.7/site-packages (from openshift) (1.9.0)
Requirement already satisfied: markupsafe in /usr/lib64/python2.7/site-packages (from jinja2->openshift) (0.11)
Collecting ipaddress>=1.0.17; python_version == "2.7" (from kubernetes~=9.0.0->openshift)
  Downloading https://files.pythonhosted.org/packages/fc/d0/7fc3a811e011d4b388be48a0e381db8d990042df54aa4ef4599a31d39853/ipaddress-1.0.22-py2.py3-none-any.whl
Requirement already satisfied: websocket-client!=0.40.0,!=0.41.*,!=0.42.*,>=0.32.0 in /usr/lib/python2.7/site-packages (from kubernetes~=9.0.0->openshift) (0.32.0)
Requirement already satisfied: setuptools>=21.0.0 in /usr/lib/python2.7/site-packages (from kubernetes~=9.0.0->openshift) (41.0.1)
Collecting certifi>=14.05.14 (from kubernetes~=9.0.0->openshift)
  Downloading https://files.pythonhosted.org/packages/69/1b/b853c7a9d4f6a6d00749e94eb6f3a041e342a885b87340b79c1ef73e3a78/certifi-2019.6.16-py2.py3-none-any.whl (157kB)
     |████████████████████████████████| 163kB 36.5MB/s 
Collecting pyyaml>=3.12 (from kubernetes~=9.0.0->openshift)
  Downloading https://files.pythonhosted.org/packages/a3/65/837fefac7475963d1eccf4aa684c23b95aa6c1d033a2c5965ccb11e22623/PyYAML-5.1.1.tar.gz (274kB)
     |████████████████████████████████| 276kB 38.0MB/s 
Collecting requests-oauthlib (from kubernetes~=9.0.0->openshift)
  Downloading https://files.pythonhosted.org/packages/c2/e2/9fd03d55ffb70fe51f587f20bcf407a6927eb121de86928b34d162f0b1ac/requests_oauthlib-1.2.0-py2.py3-none-any.whl
Requirement already satisfied: requests in /usr/lib/python2.7/site-packages (from kubernetes~=9.0.0->openshift) (2.6.0)
Collecting python-dateutil>=2.5.3 (from kubernetes~=9.0.0->openshift)
  Downloading https://files.pythonhosted.org/packages/41/17/c62faccbfbd163c7f57f3844689e3a78bae1f403648a6afb1d0866d87fbb/python_dateutil-2.8.0-py2.py3-none-any.whl (226kB)
     |████████████████████████████████| 235kB 37.4MB/s 
Collecting google-auth>=1.0.1 (from kubernetes~=9.0.0->openshift)
  Downloading https://files.pythonhosted.org/packages/c5/9b/ed0516cc1f7609fb0217e3057ff4f0f9f3e3ce79a369c6af4a6c5ca25664/google_auth-1.6.3-py2.py3-none-any.whl (73kB)
     |████████████████████████████████| 81kB 18.2MB/s 
Collecting urllib3>=1.23 (from kubernetes~=9.0.0->openshift)
  Downloading https://files.pythonhosted.org/packages/e6/60/247f23a7121ae632d62811ba7f273d0e58972d75e58a94d329d51550a47d/urllib3-1.25.3-py2.py3-none-any.whl (150kB)
     |████████████████████████████████| 153kB 33.4MB/s 
Collecting ruamel.ordereddict; platform_python_implementation == "CPython" and python_version <= "2.7" (from ruamel.yaml>=0.15->openshift)
  Downloading https://files.pythonhosted.org/packages/f3/2c/fa6d75dc459b371ed3b88fdbf8042785ce1655073c884fd97bdbb9f48e01/ruamel.ordereddict-0.4.13-cp27-cp27mu-manylinux1_x86_64.whl (99kB)
     |████████████████████████████████| 102kB 18.3MB/s 
Requirement already satisfied: backports.ssl_match_hostname in /usr/lib/python2.7/site-packages (from websocket-client!=0.40.0,!=0.41.*,!=0.42.*,>=0.32.0->kubernetes~=9.0.0->openshift) (3.5.0.1)
Collecting oauthlib>=3.0.0 (from requests-oauthlib->kubernetes~=9.0.0->openshift)
  Downloading https://files.pythonhosted.org/packages/58/5e/289e98ff5ad1a321945803000c5f10f5f90eba346d13139ecdd075cfbe17/oauthlib-3.0.2-py2.py3-none-any.whl (143kB)
     |████████████████████████████████| 153kB 33.9MB/s 
Collecting pyasn1-modules>=0.2.1 (from google-auth>=1.0.1->kubernetes~=9.0.0->openshift)
  Downloading https://files.pythonhosted.org/packages/91/f0/b03e00ce9fddf4827c42df1c3ce10c74eadebfb706231e8d6d1c356a4062/pyasn1_modules-0.2.5-py2.py3-none-any.whl (74kB)
     |████████████████████████████████| 81kB 13.8MB/s 
Collecting cachetools>=2.0.0 (from google-auth>=1.0.1->kubernetes~=9.0.0->openshift)
  Downloading https://files.pythonhosted.org/packages/2f/a6/30b0a0bef12283e83e58c1d6e7b5aabc7acfc4110df81a4471655d33e704/cachetools-3.1.1-py2.py3-none-any.whl
Collecting rsa>=3.1.4 (from google-auth>=1.0.1->kubernetes~=9.0.0->openshift)
  Downloading https://files.pythonhosted.org/packages/02/e5/38518af393f7c214357079ce67a317307936896e961e35450b70fad2a9cf/rsa-4.0-py2.py3-none-any.whl
Collecting pyasn1<0.5.0,>=0.4.1 (from pyasn1-modules>=0.2.1->google-auth>=1.0.1->kubernetes~=9.0.0->openshift)
  Downloading https://files.pythonhosted.org/packages/7b/7c/c9386b82a25115cccf1903441bba3cbadcfae7b678a20167347fa8ded34c/pyasn1-0.4.5-py2.py3-none-any.whl (73kB)
     |████████████████████████████████| 81kB 7.7MB/s 
Installing collected packages: dictdiffer, ipaddress, certifi, pyyaml, oauthlib, requests-oauthlib, python-dateutil, pyasn1, pyasn1-modules, cachetools, rsa, google-auth, urllib3, kubernetes, python-string-utils, ruamel.ordereddict, ruamel.yaml, openshift
  Found existing installation: ipaddress 1.0.16
ERROR: Cannot uninstall 'ipaddress'. It is a distutils installed project and thus we cannot accurately determine which files belong to it which would lead to only a partial uninstall.
```

```
// 源码安装openshift库，按官网（https://github.com/openshift/openshift-restclient-python）语句就行

git clone https://github.com/openshift/openshift-restclient-python.git
cd openshift-restclient-python
python setup.py install
```

```
//
root@openshiftsingle openshift-restclient-python $ python setup.py install
...
...
...
Installed /usr/lib/python2.7/site-packages/cachetools-3.1.1-py2.7.egg
error: pyasn1 0.1.9 is installed but pyasn1<0.5.0,>=0.4.1 is required by set(['pyasn1-modules'])

//
root@openshiftsingle openshift-restclient-python $ pip install --upgrade pyasn1
DEPRECATION: Python 2.7 will reach the end of its life on January 1st, 2020. Please upgrade your Python as Python 2.7 won't be maintained after that date. A future version of pip will drop support for Python 2.7.
Collecting pyasn1
  Using cached https://files.pythonhosted.org/packages/7b/7c/c9386b82a25115cccf1903441bba3cbadcfae7b678a20167347fa8ded34c/pyasn1-0.4.5-py2.py3-none-any.whl
Installing collected packages: pyasn1
  Found existing installation: pyasn1 0.1.9
    Uninstalling pyasn1-0.1.9:
      Successfully uninstalled pyasn1-0.1.9
Successfully installed pyasn1-0.4.5

root@openshiftsingle openshift-restclient-python $ python setup.py install
...
...
...
Using /usr/lib/python2.7/site-packages
Finished processing dependencies for openshift==0.10.0.dev1
```

```
//

root@openshiftsingle 1-dynamic-param $ ansible-playbook k8s-scale-obj.yaml --extra-vars "apiversion=extensions/v1beta1 kind=deployment namespace=default name=nginx replicas=3" -vvv
ansible-playbook 2.7.10
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/root/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/site-packages/ansible
  executable location = /usr/bin/ansible-playbook
  python version = 2.7.5 (default, Oct 30 2018, 23:45:53) [GCC 4.8.5 20150623 (Red Hat 4.8.5-36)]
Using /etc/ansible/ansible.cfg as config file
/etc/ansible/hosts did not meet host_list requirements, check plugin documentation if this is unexpected
/etc/ansible/hosts did not meet script requirements, check plugin documentation if this is unexpected
Parsed /etc/ansible/hosts inventory source with ini plugin

PLAYBOOK: k8s-scale-obj.yaml ******************************************************************************************************************************
1 plays in k8s-scale-obj.yaml
 [WARNING]: Found variable using reserved name: name


PLAY [localhost] ******************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************
task path: /root/migrationproj/1-dynamic-param/k8s-scale-obj.yaml:1
<127.0.0.1> ESTABLISH LOCAL CONNECTION FOR USER: root
<127.0.0.1> EXEC /bin/sh -c 'echo ~root && sleep 0'
<127.0.0.1> EXEC /bin/sh -c '( umask 77 && mkdir -p "` echo /root/.ansible/tmp/ansible-tmp-1563728078.62-129276355216828 `" && echo ansible-tmp-1563728078.62-129276355216828="` echo /root/.ansible/tmp/ansible-tmp-1563728078.62-129276355216828 `" ) && sleep 0'
Using module file /usr/lib/python2.7/site-packages/ansible/modules/system/setup.py
<127.0.0.1> PUT /root/.ansible/tmp/ansible-local-63250mKG4mn/tmpD6d0UJ TO /root/.ansible/tmp/ansible-tmp-1563728078.62-129276355216828/AnsiballZ_setup.py
<127.0.0.1> EXEC /bin/sh -c 'chmod u+x /root/.ansible/tmp/ansible-tmp-1563728078.62-129276355216828/ /root/.ansible/tmp/ansible-tmp-1563728078.62-129276355216828/AnsiballZ_setup.py && sleep 0'
<127.0.0.1> EXEC /bin/sh -c '/usr/bin/python2 /root/.ansible/tmp/ansible-tmp-1563728078.62-129276355216828/AnsiballZ_setup.py && sleep 0'
<127.0.0.1> EXEC /bin/sh -c 'rm -f -r /root/.ansible/tmp/ansible-tmp-1563728078.62-129276355216828/ > /dev/null 2>&1 && sleep 0'
ok: [localhost]
META: ran handlers

TASK [Scale a k8s object and extend timeout] **************************************************************************************************************
task path: /root/migrationproj/1-dynamic-param/k8s-scale-obj.yaml:3
<127.0.0.1> ESTABLISH LOCAL CONNECTION FOR USER: root
<127.0.0.1> EXEC /bin/sh -c 'echo ~root && sleep 0'
<127.0.0.1> EXEC /bin/sh -c '( umask 77 && mkdir -p "` echo /root/.ansible/tmp/ansible-tmp-1563728080.58-240293109009317 `" && echo ansible-tmp-1563728080.58-240293109009317="` echo /root/.ansible/tmp/ansible-tmp-1563728080.58-240293109009317 `" ) && sleep 0'
Using module file /usr/lib/python2.7/site-packages/ansible/modules/clustering/k8s/k8s_scale.py
<127.0.0.1> PUT /root/.ansible/tmp/ansible-local-63250mKG4mn/tmpFtXGL8 TO /root/.ansible/tmp/ansible-tmp-1563728080.58-240293109009317/AnsiballZ_k8s_scale.py
<127.0.0.1> EXEC /bin/sh -c 'chmod u+x /root/.ansible/tmp/ansible-tmp-1563728080.58-240293109009317/ /root/.ansible/tmp/ansible-tmp-1563728080.58-240293109009317/AnsiballZ_k8s_scale.py && sleep 0'
<127.0.0.1> EXEC /bin/sh -c '/usr/bin/python2 /root/.ansible/tmp/ansible-tmp-1563728080.58-240293109009317/AnsiballZ_k8s_scale.py && sleep 0'
<127.0.0.1> EXEC /bin/sh -c 'rm -f -r /root/.ansible/tmp/ansible-tmp-1563728080.58-240293109009317/ > /dev/null 2>&1 && sleep 0'
The full traceback is:
Traceback (most recent call last):
  File "/root/.ansible/tmp/ansible-tmp-1563728080.58-240293109009317/AnsiballZ_k8s_scale.py", line 113, in <module>
    _ansiballz_main()
  File "/root/.ansible/tmp/ansible-tmp-1563728080.58-240293109009317/AnsiballZ_k8s_scale.py", line 105, in _ansiballz_main
    invoke_module(zipped_mod, temp_path, ANSIBALLZ_PARAMS)
  File "/root/.ansible/tmp/ansible-tmp-1563728080.58-240293109009317/AnsiballZ_k8s_scale.py", line 48, in invoke_module
    imp.load_module('__main__', mod, module, MOD_DESC)
  File "/tmp/ansible_k8s_scale_payload_m_pL9D/__main__.py", line 129, in <module>
  File "/tmp/ansible_k8s_scale_payload_m_pL9D/__main__.py", line 125, in main
  File "/tmp/ansible_k8s_scale_payload_m_pL9D/ansible_k8s_scale_payload.zip/ansible/module_utils/k8s/scale.py", line 97, in execute_module
  File "/tmp/ansible_k8s_scale_payload_m_pL9D/ansible_k8s_scale_payload.zip/ansible/module_utils/k8s/scale.py", line 126, in scale
  File "/tmp/ansible_k8s_scale_payload_m_pL9D/ansible_k8s_scale_payload.zip/ansible/module_utils/k8s/scale.py", line 148, in _create_stream
NameError: global name 'watch' is not defined

fatal: [localhost]: FAILED! => {
    "changed": false, 
    "module_stderr": "Traceback (most recent call last):\n  File \"/root/.ansible/tmp/ansible-tmp-1563728080.58-240293109009317/AnsiballZ_k8s_scale.py\", line 113, in <module>\n    _ansiballz_main()\n  File \"/root/.ansible/tmp/ansible-tmp-1563728080.58-240293109009317/AnsiballZ_k8s_scale.py\", line 105, in _ansiballz_main\n    invoke_module(zipped_mod, temp_path, ANSIBALLZ_PARAMS)\n  File \"/root/.ansible/tmp/ansible-tmp-1563728080.58-240293109009317/AnsiballZ_k8s_scale.py\", line 48, in invoke_module\n    imp.load_module('__main__', mod, module, MOD_DESC)\n  File \"/tmp/ansible_k8s_scale_payload_m_pL9D/__main__.py\", line 129, in <module>\n  File \"/tmp/ansible_k8s_scale_payload_m_pL9D/__main__.py\", line 125, in main\n  File \"/tmp/ansible_k8s_scale_payload_m_pL9D/ansible_k8s_scale_payload.zip/ansible/module_utils/k8s/scale.py\", line 97, in execute_module\n  File \"/tmp/ansible_k8s_scale_payload_m_pL9D/ansible_k8s_scale_payload.zip/ansible/module_utils/k8s/scale.py\", line 126, in scale\n  File \"/tmp/ansible_k8s_scale_payload_m_pL9D/ansible_k8s_scale_payload.zip/ansible/module_utils/k8s/scale.py\", line 148, in _create_stream\nNameError: global name 'watch' is not defined\n", 
    "module_stdout": "", 
    "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error", 
    "rc": 1
}
        to retry, use: --limit @/root/migrationproj/1-dynamic-param/k8s-scale-obj.retry

PLAY RECAP ************************************************************************************************************************************************
localhost                  : ok=1    changed=0    unreachable=0    failed=1   

```

```
//

root@openshiftsingle openshift-restclient-python $ git checkout -b release-0.9 origin/release-0.9
root@openshiftsingle openshift-restclient-python $ python setup.py install
...
...
...
Using /usr/lib/python2.7/site-packages
Finished processing dependencies for openshift==0.9.0


//
root@openshiftsingle openshift-restclient-python $ git checkout -b release-0.8 origin/release-0.8
root@openshiftsingle openshift-restclient-python $ python setup.py install
...
...
...
Installed /usr/lib/python2.7/site-packages/kubernetes-8.0.1-py2.7.egg
error: urllib3 1.10.2 is installed but urllib3>=1.23 is required by set(['kubernetes'])

//
root@openshiftsingle openshift-restclient-python $ yum update -y urllib3
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
...
...
...
No Match for argument: urllib3
No package urllib3 available.
No packages marked for update

root@openshiftsingle openshift-restclient-python $ pip install --upgrade urllib3
DEPRECATION: Python 2.7 will reach the end of its life on January 1st, 2020. Please upgrade your Python as Python 2.7 won't be maintained after that date. A future version of pip will drop support for Python 2.7.
Collecting urllib3
  Using cached https://files.pythonhosted.org/packages/e6/60/247f23a7121ae632d62811ba7f273d0e58972d75e58a94d329d51550a47d/urllib3-1.25.3-py2.py3-none-any.whl
ERROR: kubernetes 8.0.1 requires adal>=1.0.2, which is not installed.
ERROR: openshift 0.8.9 has requirement urllib3<1.25, but you'll have urllib3 1.25.3 which is incompatible.
ERROR: kubernetes 8.0.1 has requirement ipaddress>=1.0.17, but you'll have ipaddress 1.0.16 which is incompatible.
ERROR: kubernetes 8.0.1 has requirement python-dateutil>=2.5.3, but you'll have python-dateutil 1.5 which is incompatible.
ERROR: kubernetes 8.0.1 has requirement pyyaml>=3.12, but you'll have pyyaml 3.10 which is incompatible.
Installing collected packages: urllib3
  Found existing installation: urllib3 1.10.2
    Uninstalling urllib3-1.10.2:
      Successfully uninstalled urllib3-1.10.2
Successfully installed urllib3-1.25.3
root@openshiftsingle openshift-restclient-python $ python setup.py install
...
...
...
Using /usr/lib/python2.7/site-packages
Finished processing dependencies for openshift==0.8.9

```

```
root@openshiftsingle 1-dynamic-param $ ansible-playbook k8s-scale-obj.yaml --extra-vars "apiversion=extensions/v1beta1 kind=deployment namespace=default name=nginx replicas=3" -vvv
ansible-playbook 2.7.10
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/root/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/site-packages/ansible
  executable location = /usr/bin/ansible-playbook
  python version = 2.7.5 (default, Oct 30 2018, 23:45:53) [GCC 4.8.5 20150623 (Red Hat 4.8.5-36)]
Using /etc/ansible/ansible.cfg as config file
/etc/ansible/hosts did not meet host_list requirements, check plugin documentation if this is unexpected
/etc/ansible/hosts did not meet script requirements, check plugin documentation if this is unexpected
Parsed /etc/ansible/hosts inventory source with ini plugin

PLAYBOOK: k8s-scale-obj.yaml ******************************************************************************************************************************
1 plays in k8s-scale-obj.yaml
 [WARNING]: Found variable using reserved name: name


PLAY [localhost] ******************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************
task path: /root/migrationproj/1-dynamic-param/k8s-scale-obj.yaml:1
<127.0.0.1> ESTABLISH LOCAL CONNECTION FOR USER: root
<127.0.0.1> EXEC /bin/sh -c 'echo ~root && sleep 0'
<127.0.0.1> EXEC /bin/sh -c '( umask 77 && mkdir -p "` echo /root/.ansible/tmp/ansible-tmp-1563728613.51-242805261050432 `" && echo ansible-tmp-1563728613.51-242805261050432="` echo /root/.ansible/tmp/ansible-tmp-1563728613.51-242805261050432 `" ) && sleep 0'
Using module file /usr/lib/python2.7/site-packages/ansible/modules/system/setup.py
<127.0.0.1> PUT /root/.ansible/tmp/ansible-local-122722isO2rF/tmpWdoR7N TO /root/.ansible/tmp/ansible-tmp-1563728613.51-242805261050432/AnsiballZ_setup.py
<127.0.0.1> EXEC /bin/sh -c 'chmod u+x /root/.ansible/tmp/ansible-tmp-1563728613.51-242805261050432/ /root/.ansible/tmp/ansible-tmp-1563728613.51-242805261050432/AnsiballZ_setup.py && sleep 0'
<127.0.0.1> EXEC /bin/sh -c '/usr/bin/python2 /root/.ansible/tmp/ansible-tmp-1563728613.51-242805261050432/AnsiballZ_setup.py && sleep 0'
<127.0.0.1> EXEC /bin/sh -c 'rm -f -r /root/.ansible/tmp/ansible-tmp-1563728613.51-242805261050432/ > /dev/null 2>&1 && sleep 0'
ok: [localhost]
META: ran handlers

TASK [Scale a k8s object and extend timeout] **************************************************************************************************************
task path: /root/migrationproj/1-dynamic-param/k8s-scale-obj.yaml:3
<127.0.0.1> ESTABLISH LOCAL CONNECTION FOR USER: root
<127.0.0.1> EXEC /bin/sh -c 'echo ~root && sleep 0'
<127.0.0.1> EXEC /bin/sh -c '( umask 77 && mkdir -p "` echo /root/.ansible/tmp/ansible-tmp-1563728615.68-236905669868708 `" && echo ansible-tmp-1563728615.68-236905669868708="` echo /root/.ansible/tmp/ansible-tmp-1563728615.68-236905669868708 `" ) && sleep 0'
Using module file /usr/lib/python2.7/site-packages/ansible/modules/clustering/k8s/k8s_scale.py
<127.0.0.1> PUT /root/.ansible/tmp/ansible-local-122722isO2rF/tmpihJM1o TO /root/.ansible/tmp/ansible-tmp-1563728615.68-236905669868708/AnsiballZ_k8s_scale.py
<127.0.0.1> EXEC /bin/sh -c 'chmod u+x /root/.ansible/tmp/ansible-tmp-1563728615.68-236905669868708/ /root/.ansible/tmp/ansible-tmp-1563728615.68-236905669868708/AnsiballZ_k8s_scale.py && sleep 0'
<127.0.0.1> EXEC /bin/sh -c '/usr/bin/python2 /root/.ansible/tmp/ansible-tmp-1563728615.68-236905669868708/AnsiballZ_k8s_scale.py && sleep 0'
<127.0.0.1> EXEC /bin/sh -c 'rm -f -r /root/.ansible/tmp/ansible-tmp-1563728615.68-236905669868708/ > /dev/null 2>&1 && sleep 0'
ok: [localhost] => {
    "changed": false, 
    "invocation": {
        "module_args": {
            "api_key": null, 
            "cert_file": null, 
            "context": null, 
            "current_replicas": null, 
            "host": null, 
            "key_file": null, 
            "kubeconfig": null, 
            "password": null, 
            "replicas": 3, 
            "resource_version": null, 
            "ssl_ca_cert": null, 
            "username": null, 
            "verify_ssl": null, 
            "wait": true, 
            "wait_timeout": 60
        }
    }, 
    "result": {
        "apiVersion": "extensions/v1beta1", 
        "kind": "Deployment", 
        "metadata": {
            "annotations": {
                "deployment.kubernetes.io/revision": "1"
            }, 
            "creationTimestamp": "2019-06-30T13:03:15Z", 
            "generation": 2, 
            "labels": {
                "app": "nginx"
            }, 
            "name": "nginx", 
            "namespace": "default", 
            "resourceVersion": "4283239", 
            "selfLink": "/apis/extensions/v1beta1/namespaces/default/deployments/nginx", 
            "uid": "6c541f95-9b37-11e9-b28c-062a74cc4d27"
        }, 
        "spec": {
            "progressDeadlineSeconds": 600, 
            "replicas": 3, 
            "revisionHistoryLimit": 10, 
            "selector": {
                "matchLabels": {
                    "app": "nginx"
                }
            }, 
            "strategy": {
                "rollingUpdate": {
                    "maxSurge": "25%", 
                    "maxUnavailable": "25%"
                }, 
                "type": "RollingUpdate"
            }, 
            "template": {
                "metadata": {
                    "creationTimestamp": null, 
                    "labels": {
                        "app": "nginx"
                    }, 
                    "name": "nginx"
                }, 
                "spec": {
                    "containers": [
                        {
                            "image": "nginx", 
                            "imagePullPolicy": "IfNotPresent", 
                            "name": "nginx", 
                            "resources": {}, 
                            "terminationMessagePath": "/dev/termination-log", 
                            "terminationMessagePolicy": "File"
                        }
                    ], 
                    "dnsPolicy": "ClusterFirst", 
                    "restartPolicy": "Always", 
                    "schedulerName": "default-scheduler", 
                    "securityContext": {}, 
                    "terminationGracePeriodSeconds": 30
                }
            }
        }, 
        "status": {
            "conditions": [
                {
                    "lastTransitionTime": "2019-06-30T13:03:15Z", 
                    "lastUpdateTime": "2019-06-30T13:03:22Z", 
                    "message": "ReplicaSet \"nginx-5d44458958\" has successfully progressed.", 
                    "reason": "NewReplicaSetAvailable", 
                    "status": "True", 
                    "type": "Progressing"
                }, 
                {
                    "lastTransitionTime": "2019-07-14T05:46:15Z", 
                    "lastUpdateTime": "2019-07-14T05:46:15Z", 
                    "message": "Deployment does not have minimum availability.", 
                    "reason": "MinimumReplicasUnavailable", 
                    "status": "False", 
                    "type": "Available"
                }
            ], 
            "observedGeneration": 2, 
            "replicas": 3, 
            "unavailableReplicas": 3, 
            "updatedReplicas": 3
        }
    }
}
META: ran handlers
META: ran handlers

PLAY RECAP ************************************************************************************************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=0   

```


```
root@openshiftsingle 1-dynamic-param $ pip list | grep openshift
DEPRECATION: Python 2.7 will reach the end of its life on January 1st, 2020. Please upgrade your Python as Python 2.7 won't be maintained after that date. A future version of pip will drop support for Python 2.7.
openshift                        0.8.9    
root@openshiftsingle 1-dynamic-param $ ansible --version
ansible 2.7.10
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/root/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/site-packages/ansible
  executable location = /usr/bin/ansible
  python version = 2.7.5 (default, Oct 30 2018, 23:45:53) [GCC 4.8.5 20150623 (Red Hat 4.8.5-36)]
```

```
// 这个是Katacoda的ansible operator环境，我试了下面的 ansible 和 openshift库 版本肯定是能完成该实验的。
// https://www.katacoda.com/openshift/courses/ansibleop/ansible-operator-overview
// 所以我觉得核心点就是openshift库的版本得小于等于0.9。

$ pip list | grep openshift
DEPRECATION: Python 2.7 will reach the end of its life on January 1st, 2020. Please upgrade your Python as Python 2.7 won't be maintained after that date. A future version of pip will drop support for Python 2.7.
openshift                        0.8.9
$ ansible --version
ansible 2.7.1
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/root/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/site-packages/ansible
  executable location = /usr/bin/ansible
  python version = 2.7.5 (default, Apr  9 2019, 14:30:50) [GCC 4.8.5 20150623 (Red Hat 4.8.5-36)]
```
