

# general info

**当前版本信息如下：**

> This text is a brief description of the features that are present in the Bash shell (version 5.0, 7 December 2018). The Bash home page is http://www.gnu.org/software/bash/.
>
> This is Edition 5.0, last updated 7 December 2018, of The GNU Bash Reference Manual, for Bash, Version 5.0.

**在手册页面没有找到怎么切换文档版本的方法，估计就只提供最新版。本来是想下个当前版本的pdf上传一下，后来想想算了。这玩意变动不会多大，就一直最新版，用html页面的内容就行。**

GNU Bash manual https://www.gnu.org/software/bash/manual/
- HTML (776K bytes) - entirely on one web page. https://www.gnu.org/software/bash/manual/bash.html
- HTML - with one web page per node. https://www.gnu.org/software/bash/manual/html_node/index.html
- PDF file (784K bytes). https://www.gnu.org/software/bash/manual/bash.pdf

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 1 Introduction

## 1.1 What is Bash?

> Bash is the shell, or command language interpreter, for the GNU operating system.

## 1.2 What is a shell?

> At its base, a shell is simply a macro processor that executes commands. The term macro processor means functionality where text and symbols are expanded to create larger expressions.

> A Unix shell is both a command interpreter and a programming language.

> Shells also provide a small set of built-in commands (builtins) implementing functionality impossible or inconvenient to obtain via separate utilities. For example, `cd`, `break`, `continue`, and `exec` cannot be implemented outside of the shell because they directly manipulate the shell itself. The `history`, `getopts`, `kill`, or `pwd` builtins, among others, could be implemented in separate utilities, but they are more convenient to use as builtin commands.

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 2 Definitions

- exit status
  * > The value returned by a command to its caller. The value is restricted to eight bits, so the maximum value is 255.
- metacharacter
  * > A character that, when unquoted, separates words. A metacharacter is a space, tab, newline, or one of the following characters: ‘|’, ‘&’, ‘;’, ‘(’, ‘)’, ‘<’, or ‘>’.
- return status
  * > A synonym for exit status.
  

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 3 Basic Shell Features

## 3.1 Shell Syntax

### 3.1.1 Shell Operation

> The following is a brief description of the shell’s operation when it reads and executes a command. Basically, the shell does the following:
>
> 1.Reads its input from a file (see `Shell Scripts`), from a string supplied as an argument to the **`-c`** invocation option (see `Invoking Bash`), or from the user’s terminal.
>
> 2.Breaks the input into words and operators, obeying the quoting rules described in `Quoting`. These tokens are separated by *metacharacters*. Alias expansion is performed by this step (see `Aliases`).
>
> 3.Parses the tokens into simple and compound commands (see `Shell Commands`).
>
> 4.Performs the various shell expansions (see `Shell Expansions`), breaking the expanded tokens into lists of filenames (see `Filename Expansion`) and commands and arguments.
>
> 5.Performs any necessary redirections (see `Redirections`) and removes the redirection operators and their operands from the argument list.
>
> 6.Executes the command (see `Executing Commands`).
>
> 7.Optionally waits for the command to complete and collects its exit status (see `Exit Status`).

### 3.1.2 Quoting

```
• Escape Character:	  	How to remove the special meaning from a single character.
• Single Quotes:	  	How to inhibit all interpretation of a sequence of characters.
• Double Quotes:	  	How to suppress most of the interpretation of a sequence of characters.
• ANSI-C Quoting:	  	How to expand ANSI-C sequences in quoted strings.
• Locale Translation:	  	How to translate strings into different languages.
```

#### 3.1.2.1 Escape Character

> A non-quoted backslash ‘\’ is the Bash escape character. It preserves the literal value of the next character that follows, with the exception of newline. If a \newline pair appears, and the backslash itself is not quoted, the \newline is treated as a line continuation (that is, it is removed from the input stream and effectively ignored).
>> notes：这段解释了常用的斜杠换行是怎么回事。标准的说法叫“line continuation”。

#### 3.1.2.2 Single Quotes

#### 3.1.2.3 Double Quotes

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
