
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

***书中原文内容主要在11页上，大致是叙述了echo命令打印时无引号，单引号，双引号情况下的局限性，说实话，我在两个系统里（Windows 10 上的 WSL Ubuntu 18.04.1 LTS \n \l ; VitualBox 5.2.20 r125813 上的 CentOS 7.5.2）实战了下之后发现不论哪个系统都和原文的叙述并不完全相符，先列出原文如下：***

> "Hence, if you want to print special characters such as !, either do not use them within double
quotes or escape them with a special escape character (\) prefixed with it"
>> 这段的意思是说想打印诸如叹号之类的特殊字符的话，或者别用双引号，或者在双引号里加斜杠转义该字符。

```
The side effects of each of the methods are as follows:
    ● When using echo without quotes, we cannot use a semicolon, as it acts as a
    delimiter between commands in the Bash shell
    ● `echo hello; hello` takes echo hello as one command and the second hello
    the second command
    ● Variable substitution, which is discussed in the next recipe, will not work within
    single quotes
```
>> 这段的意思是说**echo+不带引号字符串**的打印方式无法处理中间有分号的情形。**echo+单引号字符串**的打印方式无法做变量替换。

```shell
关于echo命令的无引号，单引号，双引号的实战情况：

1.WSL Ubuntu

wsl@DESKTOP-5LVLGG9:~$ echo hello world!
hello world!
wsl@DESKTOP-5LVLGG9:~$ echo 'hello world!'
hello world!
wsl@DESKTOP-5LVLGG9:~$ echo "hello world!"
hello world!
wsl@DESKTOP-5LVLGG9:~$ echo "cannot include exclamation - ! within double quotes"
cannot include exclamation - ! within double quotes


wsl@DESKTOP-5LVLGG9:~$ echo hello; hello
hello

Command 'hello' not found, but can be installed with:

sudo apt install hello
sudo apt install hello-traditional

2. VitualBox CentOS 7.5.2

test2@localhost:~\> echo hello world!
hello world!
test2@localhost:~\> echo 'hello world!'
hello world!
test2@localhost:~\> echo "hello world!"
-bash: !": event not found
test2@localhost:~\> echo "cannot include exclamation - ! within double quotes"
cannot include exclamation - ! within double quotes

test2@localhost:~\> echo hello; hello
hello
-bash: hello: 未找到命令

```
