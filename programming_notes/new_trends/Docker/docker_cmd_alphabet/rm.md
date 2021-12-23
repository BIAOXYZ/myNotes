
# docker rm

- `docker rm container` = `docker rm`
- `docker rm image` = `docker rmi`

How To Remove Docker Images, Containers, and Volumes https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes
- > **Purging All Unused or Dangling Images, Containers, Volumes, and Networks**
  * > Docker provides a single command that will clean up any resources — images, containers, volumes, and networks — ***that are dangling*** (not tagged or associated with a container):
    ```sh
    docker system prune
    ```
  * > To ***additionally remove*** any ***stopped containers*** and all ***unused images*** (not just dangling images), add the `-a` flag to the command:
    ```sh
    docker system prune -a
    ```
    >> //notes：所以其实可以考虑把需要的容器都启动，然后用上面这个命令。不过这个命令的一点坏处是：比如第一层镜像是 ubuntu，虽然没有容器直接用了，但是有时候（机器网速不行，下载不便时）是希望保留的，因为可能是别的镜像的依赖。
- > **Remove dangling images**
  * > **List**:
    ```sh
    docker images -f dangling=true
    ```
  * > **Remove**:
    ```sh
    docker image prune
    ```
- > **Removing images according to a pattern**
  * > You can find all the images that match a pattern using a combination of `docker images` and [`grep`](https://www.digitalocean.com/community/tutorials/using-grep-regular-expressions-to-search-for-text-patterns-in-linux). Once you’re satisfied, you can delete them by using [`awk`](https://www.digitalocean.com/community/tutorials/how-to-use-the-awk-language-to-manipulate-text-in-linux) to pass the IDs to `docker rmi`. Note that these utilities are not supplied by Docker and are not necessarily available on all systems:
  * > **List**:
    ```sh
    docker images -a |  grep "pattern"
    ```
  * > **Remove**:
    ```sh
    docker images -a | grep "pattern" | awk '{print $3}' | xargs docker rmi
    ```
- > **Remove all images**
  * > **List**:
    ```sh
    docker images -a
    ```
  * > **Remove**:
    ```sh
    docker rmi $(docker images -a -q)
    ```
- > **Remove all exited containers**
  * > You can locate containers using `docker ps -a` and filter them by their status: `created`, `restarting`, `running`, `paused`, or `exited`. To review the list of `exited` containers, use the `-f` flag to filter based on status. When you’ve verified you want to remove those containers, use `-q` to pass the IDs to the `docker rm` command:
  * > **List**:
    ```sh
    docker ps -a -f status=exited
    ```
  * > **Remove**:
    ```sh
    docker rm $(docker ps -a -f status=exited -q)
    ```
- > **Remove containers using more than one filter**
