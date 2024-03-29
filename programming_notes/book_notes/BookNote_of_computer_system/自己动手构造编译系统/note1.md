
# 前言

> 通过本书读者将会学习如何使用有限自动机构造词法分析器，如何将文法分析算法应用到语法分析过程，如何使用数据流分析进行中间代码的优化，如何生成合法的汇编代码，如何产生二进制指令信息，如何在链接器内进行符号解析和重定位，如何生成目标文件和可执行文件等。

> 第3章 编译器构造
> 
> 描述如何使用有限自动机识别自定义高级语言的词法记号，如何使用文法分析算法识别程序的语法模块，如何对高级语言上下文相关信息进行语义合法性检查，如何使用语法制导翻译进行代码生成，以及编译器工作时符号信息的管理等。

> 本书实现的编译系统代码已经托管到github，源码可以使用GCC 5.2.0编译通过。代码的github地址是 https://github.com/fanzhidongyzby/cit 。代码分支x86实现了基于Intel x86体系结构的编译器、汇编器和链接器，编译系统生成的目标文件和可执行文件都是Linux下标准的ELF文件格式。代码分支arm实现了基于ARM体系结构的编译器，目前支持生成ARM 7的汇编代码。

# 第一章 代码背后

## 1.1 从编程聊起

> 直到学习了编译原理，才发现编译器原来就是语言翻译程序，它把高级语言程序翻译成低级汇编语言程序。而汇编语言程序是不能被计算机直接识别的，必须靠汇编器把它翻译为计算机硬件可识别的机器语言程序。而根据之前对目标文件和链接器的了解，我们可能猜测到机器语言应该是按照二进制的形式存储在目标文件内部的。可是目标文件到底包含什么，链接后的可执行文件里又有什么？问题貌似越来越多。

> `图1-1`展示了编译的大致工作流程，相信拥有一定编程经验的人，对该图所表达的含义并不陌生。为了让源代码能正常地运行在计算机上，计算机对代码进行了“繁复”的处理。可是，***编译器既然是语言翻译程序，为什么不把源代码直接翻译成机器语言，却还要经过汇编和链接的过程呢？***

## 1.2 历史渊源

> 人们很快就发现了使用二进制代码控制计算机的不足，因为人工输入二进制指令的错误率实在太高了。***为了解决这个问题，人们用一系列简单明了的助记符代替计算机的二进制指令，即我们熟知的`汇编语言`***。可是计算机只能识别二进制指令，***因此需要一个已有的程序自动完成汇编语言到二进制指令的翻译工作，于是`汇编器`就产生了***。

> 随着计算问题复杂度的提高，编程中出现了大量的重复代码。人们不愿意进行重复的劳动，***于是就想办法将公共的代码提取出来，汇编成独立的模块存储在`目标文件`中***，甚至将同一类的目标文件打包成库。***由于原本写在同一个文件内的代码被分割到多个文件中，那么最终还需要将这些分离的文件拼装起来形成完整的可执行代码***。但是事情并没有那么简单，***由于文件的模块化分割，文件间的符号可能会相互引用。人们需要处理这些引用关系，重新计算符号的引用地址，这就是`链接器`的基本功能***。链接器使得计算机能自动把不同的文件模块准确无误地拼接起来，使得代码的复用成为可能。

> `图1-2`描述的链接方式称为 ***`静态链接`***，但这种方式也有不足之处。静态链接器把公用库内的目标文件合并到可执行文件内部，使得可执行文件的体积变得庞大。这样做会导致可执行文件版本难以更新，也导致了多个程序加载后相同的公用库代码占用了多份内存空间。为了解决上述的问题，现代编译系统都引入了 ***`动态链接`*** 方式（见`图1-3`）。动态链接器不会把公用库内的目标文件合并到可执行文件内，而仅仅记录动态链接库的路径信息。它允许程序运行前才加载所需的动态链接库，如果该动态链接库已加载到内存，则不需要重复加载。另外，动态链接器也允许将动态链接库的加载延迟到程序执行库函数调用的那一刻。这样做，不仅节约了磁盘和内存空间，还方便了可执行文件版本的更新。如果应用程序模块设计合理的话，程序更新时只需要更新模块对应的动态链接库即可。当然，动态链接的方式也有缺点。运行时链接的方式会增加程序执行的时间开销。另外，动态链接库的版本错误可能会导致程序无法执行。由于静态链接和动态链接的基本原理类似，且动态链接器的实现相对复杂，因此本书编译系统所实现的链接器采用静态链接的方式。

> `汇编器`和`链接器`的出现大大提高了编程效率，降低了编程和维护的难度。但是人们对汇编语言的能力并不满足，有人设想要是能像写数学公式那样对计算机编程就太方便了，于是就出现了如今形形色色的高级编程语言。这样就面临与当初汇编器产生时同样的问题——***如何将高级语言翻译为汇编语言，这正是`编译器`所做的工作***。编译器比汇编器复杂得多。汇编语言的语法比较单一，它与机器语言有基本的对应关系。而高级语言形式比较自由，计算机识别高级语言的含义比较困难，而且它的语句翻译为汇编语言序列时有多种选择，如何选择更好的序列作为翻译结果也是比较困难的，不过最终这些问题都得以解决。

>> //notes：不知道<ins>真实的历史</ins>是不是确实如前面叙述的那样：***先有汇编器，再有链接器，最后才有的编译器***。

## 1.3 GCC的工作流程
> 我们写一个最简单的“HelloWorld”程序，代码存储在源文件`hello.c`中，源文件内容如下：
```c
#include<stdio.h>
int main()
{
    printf("Hello World!");
    return 0;
}
```
> 如果将`hello.c`编译并静态链接为可执行文件，使用如下gcc命令直接编译即可：***`$gcc hello.c –o hello -static`*** —— `hello`即编译后的可执行文件。
>
> 如果查看GCC背后的工作流程，可以使用`--verbose`选项。 ***`$gcc hello.c -o hello -static --verbose`*** 输出的信息如下：
```sh
$cc1 -quiet hello.c -o hello.s
$as -o hello.o hello.s
$collect2 -static -o hello \
    crt1.o crti.o crtbeginT.o hello.o \
    --start-group libgcc.a libgcc_eh.a libc.a --end—group \
    crtend.o crtn.o
```
> 为了保持输出信息的简洁，这里对输出信息进行了整理。可以看出，GCC编译背后使用了 **`cc1`、`as`、`collect2`** 三个命令。其中 **`cc1`** 是`GCC的编译器`，它将`源文件hello.c`编译为`hello.s`。**`as`** 是`汇编器命令`，它将`hello.s`汇编为`hello.o目标文件`。**`collect2`** 是`链接器命令`，它是对命令`ld`的封装。静态链接时，GCC将`C语言运行时库（CRT）`内的 ***5个重要的`目标文件`*** `crt1.o`、`crti.o`、`crtbeginT.o`、`crtend.o`、`crtn.o`以及 ***3个`静态库`*** `libgcc.a`、`libgcc_eh.a`、`libc.a`链接到`可执行文件hello`。此外，`cc1`在对源文件编译之前，还有预编译的过程。
> 
> 因此，我们从 ***`预编译`***、***`编译`***、***`汇编`*** 和 ***`链接`*** 四个阶段查看GCC的工作细节。

### 1.3.1 预编译
> GCC对源文件的第一阶段的处理是预编译，***主要是处理宏定义和文件包含等信息***。命令格式如下： ***`$gcc -E hello.c -o hello.i`***
>
> 预编译器将`hello.c`处理后输出到文件`hello.i`, `hello.i`文件内容如下：
```console
# 1 "hello.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "hello.c"
……
extern int printf (const  char  *__restrict  __format, ...); 
……
int main()
{
    printf("Hello World!");
    return 0;
}
```
> 比如文件包含语句`#include<stdio.h>`，***预编译器会将`stdio.h`的文件内容拷贝到`#include`语句声明的位置***。如果源文件内使用`#define`语句定义了宏，预编译器则将该宏的内容替换到其被引用的位置。如果宏定义本身使用了其他宏，则预编译器需要将宏递归地展开。
>
> 我们可以将预编译的工作简单地理解为源码的文本替换，即将宏定义的内容替换到宏的引用位置。当然，这样理解有一定的片面性，因为要考虑宏定义中使用其他宏的情况。事实上预编译器的实现机制和编译器有着很大的相似性，因此本书描述的编译系统将重点放在源代码的编译上，不再独立实现预编译器。然而，我们需要清楚的事实是：一个完善的编译器是需要预编译器的。

### 1.3.2 编译
> 接下来GCC对`hello.i`进行编译，命令如下： ***`$gcc -S hello.i -o hello.s`***
>
> 编译后产生的汇编文件`hello.s`内容如下：
```asm
.file               "hello.c"
.section           .rodata
.LC0:
    .string      "Hello  World! "
    .text
.globl  main
    .type         main,  @function
main:
    pushl                %ebp
    movl                 %esp,  %ebp
    andl                 $-16,  %esp
    subl                 $16,  %esp
    movl                 $.LC0,  %eax
    movl                 %eax,  (%esp)
    call                 printf
    movl                 $0,  %eax
    leave
    ret
    .size         main,  .-main
    .ident       "GCC:  (Ubuntu/Linaro  4.4.4-14ubuntu5)  4.4.5"
    .section    .note.GNU-stack,"", @progbits
```

> GCC生成的汇编代码的语法是`AT&T格式`，与`Intel格式`的汇编有所不同（若要生成Intel格式的汇编代码，使用编译选项“`-masm=intel`”即可）。比如立即数用“`$`”前缀，寄存器用“`%`”前缀，内存寻址使用小括号等。区别最大的是，`AT&T汇编`指令的 ***源操作数在前，目标操作数在后***，这与`Intel汇编`语法正好相反。本书会在后续章节中详细描述这两种汇编语法格式的区别。
> 
> 不过我们仍能从中发现高级语言代码中传递过来的信息，比如字符串“Hello World!”、主函数名称main、***函数调用call printf***等。

### 1.3.3 汇编
> 接着，GCC使用汇编器对`hello.s`进行汇编，命令如下： ***`$gcc -c hello.s -o hello.o`***
> 
> 生成的目标文件`hello.o`, Linux下称之为 ***`可重定位目标文件`***。目标文件无法使用文本编辑器直接查看，但是我们可以使用GCC自带的工具`objdump`命令分析它的内容，命令格式如下： ***`$objdump -sd hello.o`***
> 
> 输出目标文件的主要段的内容与`反汇编代码`如下：
```console
hello.o:      file  format  elf32-i386

Contents  of  section  .text:
 0000   5589e583   e4f083ec   10b80000   00008904   U...............
 0010   24e8fcff   ffffb800   000000c9   c3            $............
Contents  of  section  .rodata:
 0000   48656c6c   6f20576f   726c6421   00            Hello  World! .
Contents  of  section  .comment:
 0000   00474343   3a202855   62756e74   752f4c69   .GCC:  (Ubuntu/Li
 0010   6e61726f   20342e34   2e342d31   34756275   naro  4.4.4-14ubu
 0020   6e747535   2920342e   342e3500                 ntu5)  4.4.5.

Disassembly  of  section  .text:

00000000  <main>:
    0:        55                                push        %ebp
    1:        89  e5                            mov         %esp, %ebp
    3:        83  e4  f0                        and         $0xfffffff0, %esp
    6:        83  ec  10                        sub         $0x10, %esp
    9:        b8  00  00  00  00                mov         $0x0, %eax
    e:        89  04  24                        mov         %eax, (%esp)
   11:        e8  fc  ff  ff  ff                call        12  <main+0x12>
   16:        b8  00  00  00  00                mov         $0x0, %eax
   1b:        c9                                leave
   1c:        c3                                ret
```
> 从 ***`数据段`二进制信息的ASCII形式*** 的显示中，我们看到了汇编语言内定义的字符串数据“Hello World!”。***`代码段`*** 的信息和汇编文件代码信息基本吻合，但是我们发现了很多不同之处。比如汇编文件内的指令`“movl $.LC0, %eax”`中的符号`.LC0`的地址（字符串“Hello World!”的地址）被换成了0。指令“call printf”内符号printf的相对地址被换成了`0xfffffffc`，即call指令操作数部分的起始地址。
> 
> 这些区别本质来源于汇编语言符号的引用问题。***由于汇编器在处理当前文件的过程中无法获悉符号的虚拟地址，因此临时将这些符号地址设置为默认值0，真正的符号地址只有在链接的时候才能确定***。

### 1.3.4 链接
> 使用GCC命令进行目标文件链接很简单： ***`$gcc hello.o -o hello`***
>
> GCC ***默认使用动态链接***，如果要进行静态链接，需加上`-static`选项： ***`$gcc hello.o -o hello -static`***

> 我们使用`objdump`命令查看一下 ***静态链接后的`可执行文件`*** 内的信息。由于可执行文件中包含了大量的C语言库文件，因此这里不便将文件的所有信息展示出来，***仅显示最终main函数的可执行代码***。
```console
080482c0  <main>:
    80482c0:          55                           push        %ebp
    80482c1:          89  e5                       mov         %esp, %ebp
    80482c3:          83  e4  f0                   and         $0xfffffff0, %esp
    80482c6:          83  ec  10                   sub         $0x10, %esp
    80482c9:          b8  28  e8  0a  08           mov         $0x80ae828, %eax
    80482ce:          89  04  24                   mov         %eax, (%esp)
    80482d1:          e8  fa  0a  00  00           call        8048dd0  <_IO_printf>
    80482d6:          b8  00  00  00  00           mov         $0x0, %eax
    80482db:          c9                           leave
    80482dc:          c3                           ret
```
> 从main函数的可执行代码中，***我们发现汇编过程中描述的无法确定的符号地址信息在这里都被修正为实际的符号地址***。如 ***`“Hello World!”字符串`的地址为`0x080ae828`***, ***`printf函数`的地址为`0x08048dd0`***。这里`符号_IO_printf`与`printf`完全等价，`call指令` ***内部相对地址*** 为`0x000afa`，正好是 ***`printf地址`相对于`call指令下条指令起始地址0x080482d6`的偏移***。
>> //notes：上述最后的相对地址是这么算出来的： `0x000afa = 0x08048dd0 - 0x080482d6`

## 1.4 设计自己的编译系统
> 我们意欲构造一个能将高级语言转化为可执行文件的编译系统。高级语言语法由我们自己定义，它可以是C语言语法，也可以是它的一个子集，但是无论如何，该高级语言由我们根据编程需要自行设计。另外，我们要求生成的可执行文件能正常执行，无论它是 ***Linux系统的ELF可执行文件***，还是 ***Windows系统的PE文件***，而本书选择生成Linux系统的ELF可执行文件。

> 然而在真正开工之前，我们需要承认一个事实——我们是无法实现一个像GCC那样完善的工业化编译器的。因此必须降低编译系统实现的复杂度，确保实际的工作在可控的范围内。本书对编译系统的实现做了如下修改和限制：
- 1）预编译的处理。***如前所述，预编译作为编译前期的工作，其主要的内容在于宏命令的展开和文本替换。本质上，预编译器也需要识别源代码语义，它与编译器实现的内容十分相似***。通过后面章节对编译器实现原理的介绍，我们也能学会如何构造一个简单的预编译器。因此，在高级语言的文法设计中，本书未提供与预编译处理相关的语法，而是直接对源代码进行编译，这样使得我们的精力更关注于编译器的实现细节上。
- 2）一遍编译的方式。编译器的设计中可以对编译器的每个模块独立设计，比如词法分析器、语法分析器、中间代码优化器等。这样做可能需要对源代码进行多遍的扫描，虽然编译效率相对较低，但是获得的源码语义信息更完善。我们设计的编译系统目标非常直接——保证编译系统输出正确的可执行文件即可，因此采用一遍编译的方式会更高效。
- 3）高级语言语法。为了方便大多数读者对文法分析的理解，我们参考C语言的语法格式设计自己的高级语言。不完全实现C语言的所有语法，不仅可以减少重复的工作量，还能将精力重点放在编译算法的实现上，而不是复杂的语言语法上。***因此在C语言的基础上，我们删除了浮点类型和struct类型，并将数组和指针的维数简化到一维***。
- 4）编译优化算法。编译器内引入了编译优化相关的内容，考虑到编译优化算法的多样性，我们挑选了若干经典的编译优化算法作为优化器的实现。通过对数据流问题优化算法的实现，可以帮助理解优化器的工作原理，对以后深入学习编译优化算法具有引导意义。
- 5）汇编语言的处理。本书的编译器产生的汇编指令属于`Intel x86处理器指令集`的子集，虽然这间接降低了汇编器实现的复杂度，但是不会影响汇编器关键流程的实现。另外，***编译器在产生汇编代码之前已经分析了源程序的正确性，生成的汇编代码都是合法的汇编指令，因此在汇编器的实现过程中不需要考虑汇编语言的词法、语法和语义错误的情况***。
- 6）静态链接方式。***本书的编译系统实现的链接器采用静态链接的方式。这是因为动态链接器的实现相对复杂，而且其与静态链接器处理的核心问题基本相同***。读者在理解了静态链接器的构造的基础上，通过进一步的学习也可以实现一个动态链接器。
- 7）ELF文件信息。***除了ELF文件必需的段和数据，我们把代码全部存放在“`.text`”段，数据存储在“`.data`”段***。按照这样的文件结构组织方式，***不仅能保证二进制代码正常执行，也有助于我们更好地理解ELF文件的结构和组织***。

> 综上所述，我们所做的限制并没有删除编译系统关键的流程。按照这样的设计，是可以允许一个人独立完成一个较为完善的编译系统的。
