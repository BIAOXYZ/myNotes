
# sed

https://www.thegeekstuff.com/category/sed/
- Unix Sed Tutorial: Printing File Lines using Address and Patterns https://www.thegeekstuff.com/2009/09/unix-sed-tutorial-printing-file-lines-using-address-and-patterns/
```sh
----------------------------------------------------------------------------------------------------
Syntax:

# sed -n 'ADDRESS'p filename
# sed -n '/PATTERN/p' filename
----------------------------------------------------------------------------------------------------

```
- Unix Sed Tutorial: Find and Replace Text Inside a File Using RegEx https://www.thegeekstuff.com/2009/09/unix-sed-tutorial-replace-text-inside-a-file-using-substitute-command/
```console
// 注意，这部分的例子全都没有改变原文件thegeekstuff.txt！
----------------------------------------------------------------------------------------------------
Syntax:

#sed 'ADDRESSs/REGEXP/REPLACEMENT/FLAGS' filename
#sed 'PATTERNs/REGEXP/REPLACEMENT/FLAGS' filename

s is substitute command
/ is a delimiter
REGEXP is regular expression to match
REPLACEMENT is a value to replace

FLAGS can be any of the following：

g Replace all the instance of REGEXP with REPLACEMENT
n Could be any number,replace nth instance of the REGEXP with REPLACEMENT.
p If substitution was made, then prints the new pattern space.
i match REGEXP in a case-insensitive manner.
w file If substitution was made, write out the result to the given file.
We can use different delimiters ( one of @ % ; : ) instead of /
----------------------------------------------------------------------------------------------------
$ cat thegeekstuff.txt
# Instruction Guides
1. Linux Sysadmin, Linux Scripting etc.
2. Databases - Oracle, mySQL etc.
3. Security (Firewall, Network, Online Security etc)
4. Storage in Linux
5. Productivity (Too many technologies to explore, not much time available)
#  Additional FAQS
6. Windows- Sysadmin, reboot etc.
----------------------------------------------------------------------------------------------------
1. Substitute Word “Linux” to “Linux-Unix” Using sed s//
In the example below, in the output line “1. Linux-Unix Sysadmin, Linux Scripting etc” only first Linux is replaced 
by Linux-Unix. If no flags are specified the first match of line is replaced.
//所以sed里的第一处、第二处等等是以行为单位计算的。

[root@druidcluster1 test]# sed 's/Linux/Linux-Unix/' thegeekstuff.txt
# Instruction Guides
1. Linux-Unix Sysadmin, Linux Scripting etc.
2. Databases - Oracle, mySQL etc.
3. Security (Firewall, Network, Online Security etc)
4. Storage in Linux-Unix
5. Productivity (Too many technologies to explore, not much time available)
#  Additional FAQS
6. Windows- Sysadmin, reboot etc.
----------------------------------------------------------------------------------------------------
2. Substitute all Appearances of a Word Using sed s//g

[root@druidcluster1 test]# sed 's/Linux/Linux-Unix/g' thegeekstuff.txt
# Instruction Guides
1. Linux-Unix Sysadmin, Linux-Unix Scripting etc.
2. Databases - Oracle, mySQL etc.
3. Security (Firewall, Network, Online Security etc)
4. Storage in Linux-Unix
5. Productivity (Too many technologies to explore, not much time available)
#  Additional FAQS
6. Windows- Sysadmin, reboot etc.
----------------------------------------------------------------------------------------------------
3. Substitute Only 2nd Occurrence of a Word Using sed s//2
In the example below, in the output line “1. Linux Sysadmin, Linux-Unix Scripting etc.” only 2nd 
occurance of Linux is replaced by Linux-Unix.

[root@druidcluster1 test]# sed 's/Linux/Linux-Unix/2' thegeekstuff.txt
# Instruction Guides
1. Linux Sysadmin, Linux-Unix Scripting etc.
2. Databases - Oracle, mySQL etc.
3. Security (Firewall, Network, Online Security etc)
4. Storage in Linux
5. Productivity (Too many technologies to explore, not much time available)
#  Additional FAQS
6. Windows- Sysadmin, reboot etc.
----------------------------------------------------------------------------------------------------
4. Write Changes to a File and Print the Changes Using sed s//gpw

[root@druidcluster1 test]# sed -n 's/Linux/Linux-Unix/gpw output' thegeekstuff.txt
1. Linux-Unix Sysadmin, Linux-Unix Scripting etc.
4. Storage in Linux-Unix
[root@druidcluster1 test]# cat output
1. Linux-Unix Sysadmin, Linux-Unix Scripting etc.
4. Storage in Linux-Unix
----------------------------------------------------------------------------------------------------
5. Substitute Only When the Line Matches with the Pattern Using sed
In this example, if the line matches with the pattern “-“, then it replaces all the characters
from “-” with the empty.

[root@druidcluster1 test]# sed '/\-/s/\-.*//g' thegeekstuff.txt
# Instruction Guides
1. Linux Sysadmin, Linux Scripting etc.
2. Databases
3. Security (Firewall, Network, Online Security etc)
4. Storage in Linux
5. Productivity (Too many technologies to explore, not much time available)
#  Additional FAQS
6. Windows
----------------------------------------------------------------------------------------------------
6. Delete Last X Number of Characters From Each Line Using sed
This sed example deletes last 3 characters from each line.

[root@druidcluster1 test]# sed 's/...$//' thegeekstuff.txt
# Instruction Gui
1. Linux Sysadmin, Linux Scripting e
2. Databases - Oracle, mySQL e
3. Security (Firewall, Network, Online Security e
4. Storage in Li
5. Productivity (Too many technologies to explore, not much time availab
#  Additional F
6. Windows- Sysadmin, reboot e
----------------------------------------------------------------------------------------------------
7. Eliminate Comments Using sed
Delete all the comment lines from a file as shown below using sed command.

[root@druidcluster1 test]# sed -e 's/#.*//' thegeekstuff.txt

1. Linux Sysadmin, Linux Scripting etc.
2. Databases - Oracle, mySQL etc.
3. Security (Firewall, Network, Online Security etc)
4. Storage in Linux
5. Productivity (Too many technologies to explore, not much time available)

6. Windows- Sysadmin, reboot etc.
----------------------------------------------------------------------------------------------------
8. Eliminate Comments and Empty Lines Using sed
In this example, there are two commands seperated by ‘;’
  - First command replaces the lines starting with the # to the blank lines
  - Second command deletes the empty lines.

[root@druidcluster1 test]# sed -e 's/#.*//;/^$/d'  thegeekstuff.txt
1. Linux Sysadmin, Linux Scripting etc.
2. Databases - Oracle, mySQL etc.
3. Security (Firewall, Network, Online Security etc)
4. Storage in Linux
5. Productivity (Too many technologies to explore, not much time available)
6. Windows- Sysadmin, reboot etc.
----------------------------------------------------------------------------------------------------
```
- Unix Sed Tutorial: Advanced Sed Substitution Examples https://www.thegeekstuff.com/2009/10/unix-sed-tutorial-advanced-sed-substitution-examples/
