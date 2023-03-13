
## `Warning: Stopping docker.service, but it can still be activated by: docker.socket`

无法正常停止docker进程 https://blog.51cto.com/wutengfei/2946943

Warning: Stopping docker.service, but it can still be activated by: docker.socket https://stackoverflow.com/questions/47489631/warning-stopping-docker-service-but-it-can-still-be-activated-by-docker-socke

## `Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get http://%2Fvar%2Frun%2Fdocker.sock/v1.39/version: dial unix /var/run/docker.sock: connect: permission denied`

Docker启动Get Permission Denied https://www.runoob.com/note/51562
- > **解决方法2**
  * > docker守护进程启动的时候，会默认赋予名字为docker的用户组读写Unix socket的权限，因此只要创建docker用户组，并将当前用户加入到docker用户组中，那么当前用户就有权限访问Unix socket了，进而也就可以执行docker相关命令
    ```sh
    sudo groupadd docker     #添加docker用户组
    sudo gpasswd -a $USER docker     #将登陆用户加入到docker用户组中
    newgrp docker     #更新用户组
    docker ps    #测试docker命令是否可以使用sudo正常使用
    ```
    >> //notes：主要是有的时候必须要执行 `newgrp docker` 这句更新 `docker` 用户组后才行，但是有的时候不需要执行这句。
