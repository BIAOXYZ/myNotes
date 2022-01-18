
# docker rm

- `docker rm container` = `docker rm`
- `docker rm image` = `docker rmi`

# 其他

How To Remove Docker Images, Containers, and Volumes https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes
- > **Purging All Unused or Dangling Images, Containers, Volumes, and Networks**
  * > Docker provides a single command that will clean up any resources — `images`, `containers`, `volumes`, and `networks` — ***that are `dangling`*** (not tagged or associated with a container):
    ```sh
    docker system prune
    ```
  * > To ***additionally remove*** any ***stopped `containers`*** and all ***unused `images`*** (not just dangling images), add the `-a` flag to the command:
    ```sh
    docker system prune -a
    ```
    >> //notes：所以其实可以考虑把需要的容器都启动，然后用上面这个命令。不过这个命令的一点坏处是：比如第一层镜像是 ubuntu，虽然没有容器直接用了，但是有时候（机器网速不行，下载不便时）是希望保留的，因为可能是别的镜像的依赖。
- > **Remove one or more specific images**
  ```sh
  # List:
  docker images -a
  # Remove:
  docker rmi Image Image
  ```
- > **Remove dangling images**
  * > Docker images consist of multiple layers. ***`Dangling images` are layers that have no relationship to any `tagged images`***. They ***no longer serve a purpose and consume disk space***. They can be located by adding the filter flag `-f` with a value of `dangling=true` to the `docker images` command. When you’re sure you want to delete them, you can use the `docker image prune` command:
  * > **List**:
    ```sh
    docker images -f dangling=true
    ```
  * > **Remove**:
    ```sh
    docker image prune
    ```
- > **Removing images according to a pattern**
  * > You can find all the images that match a pattern using a combination of `docker images` and [`grep`](https://www.digitalocean.com/community/tutorials/using-grep-regular-expressions-to-search-for-text-patterns-in-linux). ***Once you’re satisfied, you can delete them by using [`awk`](https://www.digitalocean.com/community/tutorials/how-to-use-the-awk-language-to-manipulate-text-in-linux) to pass the IDs to `docker rmi`***. Note that these utilities are not supplied by Docker and are not necessarily available on all systems:
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
- > **Remove one or more specific containers**
  ```sh
  # List:
  docker ps -a
  # Remove:
  docker rm ID_or_Name ID_or_Name
  ```
- > **Remove a container upon exiting**
  * > If you know when you’re creating a container that you won’t want to keep it around once you’re done, you can run `docker run --rm` to automatically delete it when it exits:
    ```sh
    docker run --rm image_name
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
  * > Docker filters can be combined by repeating the filter flag with an additional value. This results in a list of containers ***that meet either condition***. For example, if you want to delete all containers marked as either `created` (a state which can result when you run a container with an invalid command) or `exited`, you can use two filters:
  * > **List**:
    ```sh
    docker ps -a -f status=exited -f status=created
    ```
  * > **Remove**:
    ```sh
    docker rm $(docker ps -a -f status=exited -f status=created -q)
    ```
- > **Remove containers according to a pattern**
  * > **List**:
    ```sh
    docker ps -a |  grep "pattern”
    ```
  * > **Remove**:
    ```sh
    docker ps -a | grep "pattern" | awk '{print $1}' | xargs docker rm
    ```
- > **Stop and remove all containers**
  * > **List**:
    ```sh
    docker ps -a
    ```
  * > **Remove**:
    ```sh
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q)
    ```
- > **Remove one or more specific volumes - Docker 1.9 and later**
  * > Use the `docker volume ls` command to locate the volume name or names you wish to delete. Then you can remove one or more volumes with the `docker volume rm` command:
  * > **List**:
    ```sh
    docker volume ls
    ```
  * > **Remove**:
    ```sh
    docker volume rm volume_name volume_name
    ```
- > **Remove dangling volumes - Docker 1.9 and later**
  * > Since the point of `volumes` is to exist independent from `containers`, when a container is removed, a volume is not automatically removed at the same time. ***When a volume exists and is no longer connected to any containers, it’s called a `dangling volume`***. To locate them to confirm you want to remove them, you can use the `docker volume ls` command with a filter to limit the results to dangling volumes. When you’re satisfied with the list, you can remove them all with `docker volume prune`:
  * > **List**:
    ```sh
    docker volume ls -f dangling=true
    ```
  * > **Remove**:
    ```sh
    docker volume prune
    ```
- > **Remove a container and its volume**
  * > If you created an `unnamed volume`, it can be deleted at the same time as the container with the `-v` flag. Note that ***this only works with `unnamed volumes`***. When the container is successfully removed, its ID is displayed. Note that ***no reference is made to the removal of the volume. If it is unnamed, it is silently removed from the system***. If it is named, it silently stays present.
  * > Remove:
    ```sh
    docker rm -v container_name
    ```
