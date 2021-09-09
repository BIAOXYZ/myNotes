
# `ubuntu-20.04.3-desktop-amd64.iso`

```sh
cat << EOF > setup-env.sh
#!/usr/bin/env bash
apt update

sudo apt install -y git cmake automake
sudo apt install -y openssh-server
sudo apt install -y python3-pip

sudo apt install -y docker.io
systemctl enable docker

sudo apt-get install -y libreadline-dev
sudo apt-get install -y bzip2
EOF
```
