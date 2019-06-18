
# 用\cp进行强制复制

linux cp拷贝覆盖不提示 https://blog.csdn.net/sunny05296/article/details/78607277
```
cp -f 如果文件存在则不提示，直接覆盖。但是有时加了-f，怎么还会有提示呢？
原因是一些服务器会默认增加别名alias cp='cp -i'，当你执行cp时，其实执行的是cp –i。


[root@localhost]# alias
alias cp='cp -i'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias mv='mv -i'
alias rm='rm -i'
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'


解决方法：

方法1）修改.bashrc
#vi ~/.bashrc
在alias cp='cp -i'行前面加#注释掉，然后保存退出，重新登录shell生效。

方法2）直接使用\cp
# \cp  ./a.txt   /home/a.txt
```

> 个人实战（包括复制单个文件的情形和多个文件的情形）过程。另外先补充三点：
- 这种加反斜杠的方式对`mv`也适用。
- 原文中`方法1）`，也就是注释掉系统修改的`alias cp='cp -i'`这一行，有时候并不起作用。所以还是直接反斜杠的方法就好。
- 通过原文发现原来`alias`也可以只打一下然后看所有的alias。这点类似`set`（linux和windows的set都算），`echo $ [tab][tab]`
```
root@openshiftsingle etc $ cp resolv.confbak resolv.conf
cp: overwrite ‘resolv.conf’? no
root@openshiftsingle etc $ \cp resolv.confbak resolv.conf


root@cloudsec2:controller-runtime {master}$ pwd
/root/go/src/github.com/example-inc/app-operator/vendor/sigs.k8s.io/controller-runtime
root@cloudsec2:controller-runtime {master}$ \cp -r pkg/* /root/go/src/github.com/podset-operator/vendor/sigs.k8s.io/controller-runtime/pkg/
```
