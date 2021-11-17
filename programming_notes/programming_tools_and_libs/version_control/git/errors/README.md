
# `ssh: connect to host github.com port 22: Connection timed out`

Solution for 'ssh: connect to host github.com port 22: Connection timed out' error https://gist.github.com/Tamal/1cc77f88ef3e900aeae65f0e5e504794
```sh
$ git clone git@github.com:xxxxx/xxxx.git my-awesome-proj
Cloning into 'my-awesome-proj'...
ssh: connect to host github.com port 22: Connection timed out
fatal: Could not read from remote repository.

$ # This should also timeout
$ ssh -T git@github.com
ssh: connect to host github.com port 22: Connection timed out

$ # but this might work
$ ssh -T -p 443 git@ssh.github.com
Hi xxxx! You've successfully authenticated, but GitHub does not provide shell access.

$ # Override SSH settings

$ vim ~/.ssh/config
``
# Add section below to it
Host github.com
  Hostname ssh.github.com
  Port 443
``
$ ssh -T git@github.com
Hi xxxxx! You've successfully authenticated, but GitHub does not
provide shell access.

$ git clone git@github.com:xxxxxx/xxxxx.git my-awesome-proj
Cloning into 'my-awesome-proj'...
remote: Enumerating objects: 15, done.
remote: Counting objects: 100% (15/15), done.
remote: Compressing objects: 100% (14/14), done.
remote: Total 15 (delta 0), reused 15 (delta 0), pack-reused 0
Receiving objects: 100% (15/15), 22.90 KiB | 4.58 MiB/s, done.
```
>> //notes：我在windows下是在个人用户目录下的 `.ssh` 文件夹下新建了一个 `config` 文件，里面贴上需要配置的内容：
```console
# C:\Users\<your_user_name>\.ssh\config
Host github.com
  Hostname ssh.github.com
  Port 443
```
