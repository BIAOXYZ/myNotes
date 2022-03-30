
# 官方

Simple management UI for Docker https://github.com/portainer/portainer || https://www.portainer.io/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 安装

Install Portainer with Docker on Linux https://docs.portainer.io/v/ce-2.9/start/install/server/docker/linux
- > First, create the volume that Portainer Server will use to store its database:
  ```sh
  docker volume create portainer_data
  ```
- > Then, download and install the Portainer Server container:
  ```sh
  docker run -d -p 8000:8000 -p 9443:9443 --name portainer \
      --restart=always \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v portainer_data:/data \
      portainer/portainer-ce:2.9.3
  ```
- > Now that the installation is complete, you can log into your Portainer Server instance by opening a web browser and going to:
  ```console
  https://localhost:9443
  ```
  > Replace `localhost` with the relevant IP address or FQDN if needed, and adjust the port if you changed it earlier.
