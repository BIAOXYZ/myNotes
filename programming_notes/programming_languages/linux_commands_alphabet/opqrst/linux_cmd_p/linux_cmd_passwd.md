
# 相关命令

- `chpasswd`
- `echo`  // 因为可以和echo结合直接非交互式改密码，但是注意Ubuntu和CentOS的不同。

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

跳板机的工作原理和简单的跳板机实现 https://www.cnblogs.com/feng0919/p/11215884.html + Alternative to passwd --stdin in Ubuntu https://askubuntu.com/questions/1115795/alternative-to-passwd-stdin-in-ubuntu
```sh
// 个人实战，ubuntu 16.04.6下类似 “echo 密码 | passwd --stdin 用户名” 的命令不行，因为ubuntu下
// 的passwd没有 --stdin 参数。。。于是搜了一下，在 askubuntu 上找到了一个可以用的方法。

$ cat /etc/os-release
NAME="Ubuntu"
VERSION="16.04.6 LTS (Xenial Xerus)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 16.04.6 LTS"
VERSION_ID="16.04"
HOME_URL="http://www.ubuntu.com/"
SUPPORT_URL="http://help.ubuntu.com/"
BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"
VERSION_CODENAME=xenial
UBUNTU_CODENAME=xenial
$
$ whoami
root
$ useradd code1
$ useradd test
$
$ echo 123456 | passwd --stdin code1
passwd: unrecognised option '--stdin'
Usage: passwd [options] [LOGIN]

Options:
  -a, --all                     report password status on all accounts
  -d, --delete                  delete the password for the named account
  -e, --expire                  force expire the password for the named account
  -h, --help                    display this help message and exit
  -k, --keep-tokens             change password only if expired
  -i, --inactive INACTIVE       set password inactive after expiration
                                to INACTIVE
  -l, --lock                    lock the password of the named account
  -n, --mindays MIN_DAYS        set minimum number of days before password
                                change to MIN_DAYS
  -q, --quiet                   quiet mode
  -r, --repository REPOSITORY   change password in REPOSITORY repository
  -R, --root CHROOT_DIR         directory to chroot into
  -S, --status                  report password status on the named account
  -u, --unlock                  unlock the password of the named account
  -w, --warndays WARN_DAYS      set expiration warning days to WARN_DAYS
  -x, --maxdays MAX_DAYS        set maximum number of days before password
                                change to MAX_DAYS

// 上面报错提示说不认识 --stdin 参数，于是搜索了下，从下面的链接里找到了新方法： 
// https://askubuntu.com/questions/1115795/alternative-to-passwd-stdin-in-ubuntu
//     echo "username:cleartext_password" | sudo chpasswd

$ echo "code1:123456" | chpasswd

// root可以直接切换到test用户，然后test用户切code1用户的时候就可以验证修改code1密码的命令是否成功
$ su - test
No directory, logging in with HOME=/
$ whoami
test
$ su - code1
Password: // 此处输入code1用户的密码123456，成功登陆！
No directory, logging in with HOME=/
$ whoami
code1

----------------------------------------------------------------------------------------------------

// CentOS只是看了确实有 --stdin 参数，公司密码策略烦人，又没有别的CentOS虚机，就不再试了。
[root@temptest ~]# passwd --help
Usage: passwd [OPTION...] <accountName>
  -k, --keep-tokens       keep non-expired authentication tokens
  -d, --delete            delete the password for the named account (root only)
  -l, --lock              lock the password for the named account (root only)
  -u, --unlock            unlock the password for the named account (root only)
  -e, --expire            expire the password for the named account (root only)
  -f, --force             force operation
  -x, --maximum=DAYS      maximum password lifetime (root only)
  -n, --minimum=DAYS      minimum password lifetime (root only)
  -w, --warning=DAYS      number of days warning users receives before password expiration (root only)
  -i, --inactive=DAYS     number of days after password expiration when an account becomes disabled (root only)
  -S, --status            report password status on the named account (root only)
  --stdin                 read new tokens from stdin (root only)

Help options:
  -?, --help              Show this help message
  --usage                 Display brief usage message

```
