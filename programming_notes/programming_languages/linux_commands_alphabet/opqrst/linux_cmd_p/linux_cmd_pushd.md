
# links before

## dirs, pushd, popd

<<方便的目录转换－－－－－pushd、popd、dirs>>
http://blog.csdn.net/houqizhixiu12/article/details/45119407

<<linux 命令之 pushd、popd、dirs，以及栈的基础知识>>
http://blog.csdn.net/u011641885/article/details/45576533

# newly added links

Linux下目录栈操作详解 https://blog.csdn.net/xiaoying5191/article/details/79482811

【:star:】 Linux命令行技巧——使用目录栈进行导航 https://blog.csdn.net/sch0120/article/details/80607747

# 实战

## 使用`pushd .`（或`pushd $PWD`，但是明显前者简单。。。）将“已经确定的常用目录推入目录栈”。

> 1. `pushd`尽管能简化操作，但是很多时候我们**并不是一开始就知道哪些目录比较常用**。比如下面的例子，开始时先进到`~/go/src/`目录，但是这个目录不算常用目录（所以用`cd`进去），后面又进到`~/go/src/k8s.io/sample-controller/`，发现这个才算常用。此时直接用`pushd .`把当前目录压入栈即可（不然还得先`pwd`看看当前目录，然后复制(完整的)目录名，然后`pushd ${粘贴目录名}`）。
> 2. 不要被`pushd .`后弹出的结果误导（比如下面例子中第一次`pushd .`后的结果里有两个`~/go/src/k8s.io/sample-controller`）：目录栈栈顶总是当前目录，但是并没有真正被记录，只有显式地用`pushd`推进去的才会被记录。然后就是不要多次推同一个目录，不然还得`popd`删除。
```
$ pwd
/root
$ dirs
~

// 先cd进到 $GOPATH/src 下看看，确定哪个才是常用的、需要推入目录栈的目录。
$ cd go/src/
$ dirs
~/go/src

// 找到了，这个目录才应该推进目录栈。
$ cd k8s.io/sample-controller/
$ dirs
~/go/src/k8s.io/sample-controller

// 不要被重复的 `~/go/src/k8s.io/sample-controller` 误导，实际上栈顶那个并不是真正在栈里。
$ pushd .
~/go/src/k8s.io/sample-controller ~/go/src/k8s.io/sample-controller
$ dirs
~/go/src/k8s.io/sample-controller ~/go/src/k8s.io/sample-controller

$ cd ~
$ dirs
~ ~/go/src/k8s.io/sample-controller

// 也可以用 `pushd $PWD` ————不过估计没人用。。。
$ pushd $PWD
~ ~ ~/go/src/k8s.io/sample-controller
$ dirs
~ ~ ~/go/src/k8s.io/sample-controller

// 再次验证下，当前目录虽然在栈顶，但是其实并不是真正在栈的记录中。
$ cd /etc/
$ dirs
/etc ~ ~/go/src/k8s.io/sample-controller
$
$ cd /var/lib/
$ dirs
/var/lib ~ ~/go/src/k8s.io/sample-controller

// 不要把同一个目录两次压入栈，不然后面还得手动popd。
$ cd ~
$ dirs
~ ~ ~/go/src/k8s.io/sample-controller
$ pushd .
~ ~ ~ ~/go/src/k8s.io/sample-controller
$ dirs
~ ~ ~ ~/go/src/k8s.io/sample-controller
$ cd /etc/
$ dirs
/etc ~ ~ ~/go/src/k8s.io/sample-controller
```
