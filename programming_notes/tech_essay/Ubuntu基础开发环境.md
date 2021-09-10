
# `ubuntu-20.04.3-desktop-amd64.iso`

```sh
cat << EOF > setup-env.sh
#!/usr/bin/env bash
sudo apt update
sudo apt install -y git cmake automake autoconf libtool
sudo apt install -y vim wget curl openssh-server
sudo apt install -y python3-pip
sudo apt install -y docker.io
systemctl enable docker

# FOR -- `lex` and `yacc`
sudo apt install -y flex bison
# FOR -- `pyenv`
sudo apt-get install -y libreadline-dev libssl-dev libbz2-dev libsqlite3-dev
EOF
```

Ubuntu下pyenv install 3.6.5 build失败 https://www.jianshu.com/p/a8f6c5f6b273
```sh
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev
```
