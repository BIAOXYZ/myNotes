
- 《Linux Shell Scripting Cookbook》 2nd edition 2013
- 《LINUX SHELL脚本攻略》2011年翻译，所以应该是第一版————确定是第一版，因为翻译版第一章开头部分只有14个任务，英文版第一章开头有16个。

# 1 Shell Something Out

```
In this chapter, we will cover:
   Printing in the terminal
   Playing with variables and environment variables
   Function to prepend to environment variables
   Math with the shell
   Playing with file descriptors and redirection
   Arrays and associative array
   Visiting aliases
   Grabbing information about the terminal
   Getting and setting dates and delays
   Debugging the script
   Functions and arguments
   Reading output of a sequence of commands in a variable
   Reading n characters without pressing the return key
   Running a command until it succeeds
   Field separators and iterators
   Comparisons and tests
```

## Introduction

#### page 8

> "$ represents regular users and # represents the administrative user root."

```
A shell script is a text file that typically begins with a shebang, as follows:
    #!/bin/bash
Shebang is a line on which #! is prefixed to the interpreter path. /bin/bash is the
interpreter command path for Bash.
```

#### page 9

> "Execution of a script can be done in two ways. Either we can run the script as a command-line argument to bash or we can grant execution permission to the script so it becomes executable."

> "When a shell is started, it initially executes a set of commands to define various settings such as prompt text, colors, and much more. This set of commands are read from a shell script at ~/.bashrc (or ~/.bash_profile for login shells) located in the home directory of the user. The Bash shell also maintains a history of commands run by the user. It is available in the ~/.bash_history file."

> [Tips] "A login shell is the shell which you get just after logging in to a machine. However, if you open up a shell while logged in to a graphical environment (such as GNOME, KDE, and so on), then it is not a login shell."

## Printing in the terminal

#### page 10-11 

总结(上)：书中原文内容主要在11页上，大致是叙述了echo命令打印时`加无引号字符串`，`加单引号字符串`，`加双引号字符串`情况下的局限性。说实话，我在两个系统里（`Windows 10 上的 WSL Ubuntu 18.04.1 LTS \n \l` 以及 `VitualBox 5.2.20 r125813 上的 CentOS 7.5.2`）实战了下之后发现不论哪个系统`echo+双引号字符串`的打印方式都和原文的叙述并不完全相符（其他两种是符合的），先列出原文然后是实战：

> 原文："Hence, if you want to print special characters such as !, either do not use them within double
quotes or escape them with a special escape character (\) prefixed with it"
>> 这段的意思是说想打印诸如叹号之类的特殊字符的话，或者别用双引号，或者在双引号里加斜杠转义该字符。

```
原文：
The side effects of each of the methods are as follows:
    ● When using echo without quotes, we cannot use a semicolon, as it acts as a
    delimiter between commands in the Bash shell
    ● `echo hello; hello` takes echo hello as one command and the second hello
    the second command
    ● Variable substitution, which is discussed in the next recipe, will not work within
    single quotes
```
>> 这段的意思是说`echo+不带引号字符串`的打印方式**无法处理中间有分号的情形**。`echo+单引号字符串`的打印方式**无法做变量替换**。


**(1)**`echo+不带引号字符串`的打印方式**无法处理中间有分号的情形**：
```shell
两个系统的实战结果均和书上的叙述是一致的。

1.WSL Ubuntu 18.04.1

wsl@DESKTOP-5LVLGG9:~$ echo hello; hello
hello

Command 'hello' not found, but can be installed with:

sudo apt install hello
sudo apt install hello-traditional

2. VitualBox CentOS 7.5.2

test2@localhost:~\> echo hello; hello
hello
-bash: hello: 未找到命令
```

**(2)**`echo+单引号字符串`的打印方式**无法做变量替换**。
```shell
两个系统的实战结果均和书上的叙述是一致的。

1.WSL Ubuntu 18.04.1

wsl@DESKTOP-5LVLGG9:~$ echo $PWD
/home/wsl
wsl@DESKTOP-5LVLGG9:~$ echo '$PWD'
$PWD
wsl@DESKTOP-5LVLGG9:~$ echo "$PWD"
/home/wsl

2. VitualBox CentOS 7.5.2

test2@localhost:~\> echo $PWD
/home/test2
test2@localhost:~\> echo '$PWD'
$PWD
test2@localhost:~\> echo "$PWD"
/home/test2
```

**(3)**`echo+双引号字符串`的打印方式**对特殊符号（如叹号）必须转义**。
```shell
全部都用书上的例子，首先实验不加转义的情况下打印叹号。书上认为最后两个例子都不可能打印成功，
但是实际上Ubuntu全部打印成功；CentOS一个成功一个失败（这点我也觉得很怪，本以为都该失败的）。。。

1.WSL Ubuntu 18.04.1

wsl@DESKTOP-5LVLGG9:~$ echo hello world!
hello world!
wsl@DESKTOP-5LVLGG9:~$ echo 'hello world!'
hello world!
wsl@DESKTOP-5LVLGG9:~$ echo "hello world!"
hello world!
wsl@DESKTOP-5LVLGG9:~$ echo "cannot include exclamation - ! within double quotes"
cannot include exclamation - ! within double quotes

2. VitualBox CentOS 7.5.2

test2@localhost:~\> echo hello world!
hello world!
test2@localhost:~\> echo 'hello world!'
hello world!
test2@localhost:~\> echo "hello world!"
-bash: !": event not found
test2@localhost:~\> echo "cannot include exclamation - ! within double quotes"
cannot include exclamation - ! within double quotes

再实验一下有转义字符的情况。结果全都和书上叙述不符：都把转义字符原封不动打印出来了。

1.WSL Ubuntu 18.04.1

wsl@DESKTOP-5LVLGG9:~$ echo "Hello world \!"
Hello world \!

2. VitualBox CentOS 7.5.2

test2@localhost:~\> echo "Hello world \!"
Hello world \!
```

总结(下)：浪费了不少时间（主要是记录，实验的时间其实用的不多），实际还有不少点没有覆盖到，比如：`其他特殊符号是什么情况？单引号双引号混合是什么情况？反引号是什么情况？`等等。网上也能查到不少，但是不在这里记了，因为一旦展开就没完没了了，所以这里只记录和书上直接相关的吧。最后的结论就是要用的时候根据系统和脚本多查查多试试吧。。。

#### page 12-13
```shell
%-5s can be described as a string substitution with left alignment (- represents left
alignment) with width equal to 5. If - was not specified, the string would have been aligned to
the right. The width specifies the number of characters reserved for that variable.
```
```shell
By default, echo has a newline appended at the end of its output text. This can be avoided
by using the -n flag. echo can also accept escape sequences in double-quoted strings as an
argument. When using escape sequences, use echo as echo -e "string containing
escape sequences".
```
```shell
Colors are represented by color codes, some examples being, reset = 0, black = 30, red = 31,
green = 32, yellow = 33, blue = 34, magenta = 35, cyan = 36, and white = 37.

For a colored background, reset = 0, black = 40, red = 41, green = 42, yellow = 43, blue = 44,
magenta = 45, cyan = 46, and white=47, are the color codes that are commonly used.
```
```shell
echo命令和其flag在 WSL Ubuntu 18.04.1 上的实战：

(1)echo -e 将 \t 转义序列转义为tab：
wsl@DESKTOP-5LVLGG9:~$ echo -e "1\t2\t3"
1       2       3
wsl@DESKTOP-5LVLGG9:~$ echo "1\t2\t3"
1\t2\t3

(2)echo打印默认带换行符，用 -n 标志忽略结尾的换行符：
wsl@DESKTOP-5LVLGG9:~$ echo 123
123
wsl@DESKTOP-5LVLGG9:~$ echo -n 123
123wsl@DESKTOP-5LVLGG9:~$

(3)echo的flag必须在字符串之前，不然会被当成字符串的一部分：
wsl@DESKTOP-5LVLGG9:~$ echo "1\t2\t3" -n
1\t2\t3 -n
wsl@DESKTOP-5LVLGG9:~$ echo "1\t2\t3" -e
1\t2\t3 -e

(4)echo打印彩色字体和彩色背景——不过这边应该显示不出来吧：
wsl@DESKTOP-5LVLGG9:~$ echo -e "\e[1;31m This is red text \e[0m"
 This is red text
wsl@DESKTOP-5LVLGG9:~$ echo -e "\e[1;42m Green Background \e[0m"
 Green Background
```

