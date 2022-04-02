
# 1

探究Presto SQL引擎(1)-巧用Antlr https://segmentfault.com/a/1190000040490309 || https://juejin.cn/post/6994614394621526047 || http://blog.itpub.net/69912579/viewspace-2786120/
- > **五、总结**
  * > 本文基于四则运算器和使用SQL查询csv数据两个案例阐述了ANTLR4在项目开发中的应用思路和过程，相关的代码可以在[github](https://github.com/shgy/db-practice)上看到。
    >> //notes：另外自己也fork了一个，方便后续回顾： https://github.com/BIAOXYZ/forked--db-practice  -->  因为完全没接触过 java，作者原版仓库里的代码去编译都踩了坑，所以还是 fork 一份省得作者更新后再想回顾的时候更麻烦。。。


## 参考链接
>> //notes：基本没接触过 java，所以开始时甚至用原版的代码都没法验证。。。还是网上搜了搜，参考下面这个文章里靠前的部分，才算编过。。。
  
第1期：抛开IDE，了解一下javac如何编译 - 毛帅的文章 - 知乎 https://zhuanlan.zhihu.com/p/74229762
- > **带个包名**
  * > 一切都很顺利，但没有包名是不专业的，所以我们加一个牛逼的包 `com.imshuai.javalinux`：
    ```java
    package com.imshuai.javalinux;
    public class HelloWorld{
        public static void main(String[] args){
            System.out.println("Hello, World!");
        }
    }
    ```
    > 还是一样用 `javac` 编译，查看当前目录下 `HelloWorld.class` 生成了，很顺利。
  * > 还是一样用 `java` 命令，瞬间被打脸：
    ```console
    maoshuai@ms:~/javaLinux/w1$ java HelloWorld 
    Error: Could not find or load main class HelloWorld
    ```
  * > 想了想，`HelloWorld` 已经有自己的包名了，所以它的名字不在是没有姓氏的 `HelloWorld`，新名字叫 `com.imshuai.javalinux.HelloWorld`，那么传给 `java` 自然要用新名字，再试一试：
    ```console
    maoshuai@ms:~/javaLinux/w1$ java com.imshuai.javalinux.HelloWorld
    Error: Could not find or load main class com.imshuai.javalinux.HelloWorld
    ```
  * > 还是被打脸，这时候老司机告诉你，创建一个 `com/imshuai/javalinux` 目录，然后把 `HelloWorld.class` 放进来，执行：
    ```console
    maoshuai@ms:~/javaLinux/w1$ mkdir -p com/imshuai/javalinux
    maoshuai@ms:~/javaLinux/w1$ mv HelloWorld.class com/imshuai/javalinux
    maoshuai@ms:~/javaLinux/w1$ java com.imshuai.javalinux.HelloWorld
    Hello, World!
    ```
    > 果然，正常打印出了Hello, World!
  * > 上面的步骤，说明了两点： 1. 增加了package名，所以class名也变了，行不改名坐不改姓，自然要带上姓（即所谓全限定名）。 2. Java 会根据包名对应出目录结构，并从class path搜索该目录去找class文件。由于默认的class path是当前目录，所以 `com.imshuai.javalinux.HelloWorld` 必须存储在 `./com/imshuai/javalinux/HelloWorld.class`
  * > 当然每次自己创建包路径的目录太麻烦。`-d` 参数可以代劳上面的工作：
    ```console
    maoshuai@ms:~/javaLinux/w1$ javac -d . HelloWorld.java 
    maoshuai@ms:~/javaLinux/w1$ ls
    com  HelloWorld.java
    maoshuai@ms:~/javaLinux/w1$ java com.imshuai.javalinux.HelloWorld
    Hello, World!
    ```
    > `-d` 指定了生成class文件的根目录（这里用的是当前目录），并且会根据class的包路径创建子目录。
