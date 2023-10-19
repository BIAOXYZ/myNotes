
# 1

【[:star:][`*`]】 Linux命令中的重定向(>)和管道(|) https://murphypei.github.io/blog/2018/04/linux-redirect-pipe || https://github.com/murphypei/murphypei.github.io/blob/master/archives/2018/04/index.html
- > **文件描述符**
  * > Linux的宗旨是一切皆文件，对于进程、IO等等都是通过文件的形式存在，这些文件都通过`文件描述符`的形式来表示。***Linux的文件描述符可以理解为Linux为了跟踪一个打开的文件而分配的唯一标号，可以通过这个标号对文件实现读写操作***。Linux系统的文件描述符一般都有最大的限制，可以通过 `ulimit -n` 这条命令来查看。如果想改变这个限制，需要修改 `/etc/security/limits.conf` 文件，如下：
    ```sh
    vi /etc/security/limits.conf
    * hard nofile 102400
    * soft nofile 102400
    ```
    > 保存后退出，重新登录，可以看到其被改变。
  * > 我们知道，Linux启动时，最开始会创建init进程，其余的程序都是这个进程的子进程。***而init进程默认打开3个文件描述符***：
    ```console
    标准输入：standard input(0)
    标准输出：standard output(1)
    标准错误：standard error(2)
    ```
    > ***其中`标准输入`就是`键盘`，`标准输出`和`标准错误`都是`屏幕`，后面的数字分别是他们的文件描述符***。
   * > ***对于每个Linux进程，其都是init的子进程，包括bash命令窗口，而其中执行的shell命令，则更是如此***。我们又知道，***在Linux中，子进程会继承父进程的文件描述符，所以说，Linux中每个程序，执行的每个shell命令，拥有这三个文件描述符，<ins>而程序后续打开的文件，其文件描述符则（从3开始）依次增加</ins>***。
   * > 对于一条shell命令，其从标准输入（键盘）中获得输入，如果执行成功，则将输出打印在标准输出（屏幕）上；如果执行出错，将结果打印在标准错误（屏幕）上。
   * > 关于文件描述符有很多相关知识，本文不展开，大家只要知道这个概念即可。
- > **重定向**
  * > 根据前文，我们知道了命令的输入输出默认的文件描述符，***如果我们不使用默认的文件描述符，而想自己指定，则需要用到重定向了***。
- > **输出重定向**
  * > 输出重定向是最常见的了，格式一般如下：
    ```sh
    command [1-n] > file或者文件描述符或者设备
    ```
  * > 下面示例输出重定向的操作，假设当前目录下只存在一个文件 `exists.txt`。
  * > **不重定向输出**
    + > 执行命令:
      ```sh
      ls exists.txt no-exists.txt
      ```
      > 因为 `exists.txt` 文件存在，而 `no-exists.txt` 文件不存在，***因此这个命令即具有成功执行的结果（标准输出），又具有出错的结果（标准错误）***。由于这个命令没有进行重定向，因此标准输出和标准错误都将打印在屏幕上：
      ```console
      ls: no-exists.txt: No such file or directory  # 执行错误，标准错误
      exists.txt  # 成功执行，标准输出
      ```
  * > **重定向输出**
    + > 执行命令：
      ```sh
      ls exists.txt no-exists.txt 1 > success.txt 2 > fail.txt
      ```
      > 命令执行，屏幕上将不显示任何信息，但是多了两个文件，其中 `succcess.txt` 中是执行成功的结果，标准输出重定向的文件，内容为 `exists.txt`，而 `fail.txt` 是执行出错的结果，标准错误重定向的结果，内容为 `ls: no-exists.txt: No such file or directory`。
  * > **只重定向标准输出**
