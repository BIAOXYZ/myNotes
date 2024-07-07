
How to Install Redis CLI Only https://www.baeldung.com/linux/redis-client-alone-installation
- > **4. Using redis-tools Package**
  ```sh
  sudo apt install redis-tools -y
  ```
- > **7. Using a Docker Image**
  * > Using Docker to install Redis CLI is a possible alternative too. Actually, the Redis Docker image is based on the popular Alpine Linux Project and comes with Redis CLI preinstalled on it. The benefit of that is that the Alpine Linux image is smaller than most other distributions, so it’s a convenient container for Redis CLI users despite the host OS.
  * > Basically, the deployment and usage process boils down to a single command:
    ```sh
    docker run -it --rm redis:latest-alpine redis-cli -h my.redis.host -p 6379
    ```
