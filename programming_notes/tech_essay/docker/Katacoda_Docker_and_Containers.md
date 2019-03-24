

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
 
:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:
