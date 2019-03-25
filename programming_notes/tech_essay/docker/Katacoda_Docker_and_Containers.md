

# Katacoda -- Docker & Containers

***Create Data Containers*** https://www.katacoda.com/courses/docker/data-containers
- > `docker run --volumes-from dataContainer ubuntu ls /config`
  >> Using the --volumes-from <container> option we can use the mount volumes from other containers inside the container being launched. In this case, we'll launch an Ubuntu container which has reference to our Data Container. When we list the config directory, it will show the files from the attached container.

***Creating Networks Between Containers using Links*** https://www.katacoda.com/courses/docker/5
- >> `docker run --link redis-server:redis alpine env`
- > Secondly, Docker will update the HOSTS file of the container with an entry for our source container with three names, the original, the alias and the hash-id. You can output the containers host entry using `cat /etc/hosts`
  >> `docker run --link redis-server:redis alpine cat /etc/hosts`
- > With a link created you can ping the source container in the same way as if it were a server running in your network.
  >> `docker run --link redis-server:redis alpine ping -c 1 redis`
- > With a link created, applications can connect and communicate with the source container in the usual way, independent of the fact both services are running in containers. Here is a simple node.js application which connects to redis using the hostname redis.
  >> `docker run -d -p 3000:3000 --link redis-server:redis katacoda/redis-node-docker-example`
- > In the same way, you can connect source containers to applications, you can also connect them to their own CLI tools. The command below will launch an instance of the Redis-cli tool and connect to the redis server via its alias.
  >> `docker run -it --link redis-server:redis redis redis-cli -h redis`

***Creating Networks Between Containers using Networks*** https://www.katacoda.com/courses/docker/networking-intro
- > To start with we create the network with our predefined name. 
  >> `docker network create backend-network`
- > When we launch new containers, we can use the `--net` attribute to assign which network they should be connected to. 
  >> `docker run -d --name=redis --net=backend-network redis`
- > Instead, the way containers can communicate via an Embedded DNS Server in Docker. This DNS server is assigned to all containers via the IP 127.0.0.11 and set in the resolv.conf file.
  >> `docker run --net=backend-network alpine cat /etc/resolv.conf`
- > When using the connect command it is possible to attach existing containers to the network.
  >> `docker network connect frontend-network redis`
- > The following command will connect our Redis instance to the frontend-network with the alias of db.
  >> `docker network create frontend-network2`
  >> <br> `docker network connect --alias db frontend-network2 redis`  
- > The following command will list all the networks on our host.
  >> `docker network ls`
- > We can then explore the network to see which containers are attached and their IP addresses.
  >> `docker network inspect frontend-network`
- > The following command disconnects the redis container from the frontend-network.
  >> `docker network disconnect frontend-network redis` 

***Persisting Data Using Volumes*** https://www.katacoda.com/courses/docker/persisting-data-using-volumes
- > In this case, we're mapping our Redis container's volume to an Ubuntu container. The /data directory only exists within our Redis container, however, because of -volumes-from our Ubuntu container can access the data.
  >> `docker run --volumes-from r1 -it ubuntu ls /data`
  >
  > This allows us to access volumes from other containers without having to be concerned how they're persisted on the host.
- > Mounting Volumes gives the container full read and write access to the directory. You can specify read-only permissions on the directory by adding the permissions :ro to the mount. If the container attempts to modify data within the directory it will error.
  >> `docker run -v /docker/redis-data:/data:ro -it ubuntu rm -rf /data`
  
***Manage Container Log Files*** https://www.katacoda.com/courses/docker/8
- > In the background, there is an instance of Redis running with the name redis-server. Using the Docker client, we can access the standard out and standard error outputs using 
  >> `docker logs redis-server`
- > The command below will redirect the redis logs to syslog.
  >> `docker run -d --name redis-syslog --log-driver=syslog redis`
- > The third option is to disable logging on the container. This is particularly useful for containers which are very verbose in their logging.
  >
  > When the container is launched simply set the log-driver to none. No output will be logged.
  >> `docker run -d --name redis-none --log-driver=none redis`
- > The inspect command allows you to identify the logging configuration for a particular container. The command below will output the LogConfig section for each of the containers.
  ```
  $ docker inspect --format '{{ .HostConfig.LogConfig }}' redis-server
  {json-file map[]}
  $ docker inspect --format '{{ .HostConfig.LogConfig }}' redis-syslog
  {syslog map[]}
  $ docker inspect --format '{{ .HostConfig.LogConfig }}' redis-none
  {none map[]}
  ```

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:
