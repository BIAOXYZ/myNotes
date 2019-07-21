
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

后来发现

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

```
// 把pip装上

yum install -y 
```

```
// 装上pip后先是版本过低————我现在越来越相信CentOS不如Ubuntu了。。。大版本都19了，结果自带的才8（还是epel带的，CentOS基本库没有！）

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

root@openshiftsingle 1-dynamic-param $ pip install --upgrade pip
Collecting pip
  Downloading https://files.pythonhosted.org/packages/5c/e0/be401c003291b56efc55aeba6a80ab790d3d4cece2778288d65323009420/pip-19.1.1-py2.py3-none-any.whl (1.4MB)
    100% |████████████████████████████████| 1.4MB 570kB/s 
Installing collected packages: pip
  Found existing installation: pip 8.1.2
    Uninstalling pip-8.1.2:
      Successfully uninstalled pip-8.1.2
Successfully installed pip-19.1.1


// 
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


// python – find_package()错误,通过pip安装包 https://codeday.me/bug/20190222/699735.html
// 最佳答案：pip install -U setuptools
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
// 

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

