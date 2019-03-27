

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

***Ensuring Container Uptime With Restart Policies*** https://www.katacoda.com/courses/docker/9
- > The option `--restart=on-failure:#` allows you to say how many times Docker should try again. In the example below, Docker will restart the container three times before stopping.
  >> `docker run -d --name restart-3 --restart=on-failure:3 scrapbook/docker-restart-example`
- > Use the `always` flag to automatically restart the container when is crashes, for example 
  >> `docker run -d --name restart-always --restart=always scrapbook/docker-restart-example`

***Adding Docker Metadata & Labels*** https://www.katacoda.com/courses/docker/15
- > Labels can be attached to containers when they are launched via `docker run`. A container can have multiple labels attached to them at any one time.
  >
  > To add a single label you use the `l =<value>` option. The example below assigns a label called user with an ID to the container. This would allow us to query for all the containers running related to that particular user.
  >> `docker run -l user=12345 -d redis`
- > If you're adding multiple labels, then these can come from an external file. The file needs to have a label on each line, and then these will be attached to the running container.
  >
  > The `--label-file=<filename>` option will create a label for each line in the file.
  >> `docker run --label-file=labels -d redis`
- > Labelling images work in the same way as containers but are set in the `Dockerfile` when the image is built. When a container has launched the labels of the image will be applied to the container instance.
  ``` 
  Single Label   
      LABEL vendor=Katacoda

  Multiple Labels
      LABEL vendor=Katacoda \ 
      com.katacoda.version=0.0.5 \ 
      com.katacoda.build-date=2016-07-01T10:47:29Z \ 
      com.katacoda.course=Docker
  ```
- > Labels and Metadata are only useful if you can view/query them later. The first approach to viewing all the labels for a particular container or image is by using `docker inspect`.
  >
  > By providing the running container's friendly name or hash id, you can query all of it's metadata.
  >> `docker inspect rd`
  ```
  Using the -f option you can filter the JSON response to just the Labels section we're interested in.

  $ docker inspect -f "{{json .Config.Labels }}" rd
  {"com.katacoda.created":"automatically","com.katacoda.private-msg":"magic","user":"scrapbook"}
  ```
- > Inspecting images works in the same way however the JSON format is slightly different, naming it `ContainerConfig` instead of Config.
  ```
  $ docker inspect -f "{{json .ContainerConfig.Labels }}" katacoda-label-example
  {"com.katacoda.build-date":"2015-07-01T10:47:29Z","com.katacoda.course":"Docker","com.katacoda.private-msg":"HelloWorld","com.katacoda.version":"0.0.5","vendor":"Katacoda"}
  ```
  > These labels will remain even if the image has been untagged. When an image is untagged, it will have the name `<none>`.
- > The `docker ps` command allows you to specify a filter based on a label name and value. For example, the query below will return all the containers which have a user label key with the value *katacoda*.
  >> `docker ps --filter "label=user=scrapbook"`
- > The same filter approach can be applied to images based on the labels used when the image was built.
  >> `docker images --filter "label=vendor=Katacoda"`
- > Labels are not only applied to images and containers but also the Docker Daemon itself. When you launch an instance of the daemon, you can assign it labels to help identify how it should be used, for example, if it's a development or production server or if it's more suited to particular roles such running databases.
  ```
  docker -d \
      -H unix:///var/run/docker.sock \
      --label com.katacoda.environment="production" \
      --label com.katacoda.storage="ssd"
  ```

***Load Balancing Containers*** https://www.katacoda.com/courses/docker/10
- > Finally, we can set an optional `-e DEFAULTHOST=<domain>`. If a request comes in and doesn't make any specified hosts, then this is the container where the request will be handled. This enables you to run multiple websites with different domains on a single machine with a fall-back to a known website.
  >> `docker run -d -p 80:80 -e DEFAULT_HOST=proxy.example -v /var/run/docker.sock:/tmp/docker.sock:ro --name nginx jwilder/nginx-proxy`
- > For Nginx-proxy to start sending requests to a container you need to specify the `VIRTUAL_HOST` environment variable. This variable defines the domain where requests will come from and should be handled by the container.
  > 
  > In this scenario we'll set our HOST to match our DEFAULT_HOST so it will accept all requests.
  >> `docker run -d -p 80 -e VIRTUAL_HOST=proxy.example katacoda/docker-http-server`
- > We now have successfully created a container to handle our HTTP requests. If we launch a second container with the same VIRTUAL_HOST then nginx-proxy will configure the system in a `round-robin` load balanced scenario. This means that the first request will go to one container, the second request to a second container and then repeat in a circle. There is no limit to the number of nodes you can have running.
- > While nginx-proxy automatically creates and configures NGINX for us, if you're interested in what the final configuration looks like then you can output the complete config file with docker exec as shown below.
  >> `docker exec nginx cat /etc/nginx/conf.d/default.conf`
  >
  > Additional information about when it reloads configuration can be found in the logs using `docker logs nginx`.


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:
