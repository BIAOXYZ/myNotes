
【[:star:][`*`]】 GCC常用参数详解 https://www.cnblogs.com/zhangsir6/articles/2956798.html
- > gcc and g++现在是gnu中最主要和最流行的c & c++编译器 .gcc/g++在执行编译工作的时候，总共需要以下几步:
  ```console
  1.预处理,生成.i的文件[预处理器cpp]
  2.将预处理后的文件转换成汇编语言,生成文件.s[编译器egcs]
  3.由汇编变为目标代码(机器代码)生成.o的文件[汇编器as]
  4.连接目标代码,生成可执行程序[链接器ld]
  ```
- > GCC能够处理的后缀有:
  ```console
  a. *.c *.C (C语言)
  b. *.cxx *.cc (C++语言)
  c. *.m (面向对象的C)
  d. *.i (预处理后的C语言源文件)
  e. *.ii (预处理后的C++语言源文件)
  f. *.s *.S (汇编语言)
  h. *.h (头文件)
  ```
- > 目标文件可以是：
  ```console
  a. *.o 编译连接后的目标文件
  b. *.a 库文件
  ```
- > gcc与g++有什么区别？
  * > gcc和g++都是GNU(组织)的一个编译器。
- > 误区一:gcc只能编译c代码,g++只能编译c++代码
  * > 两者都可以，但是请注意：
  * > 1.***后缀为 `.c` 的，gcc把它当作是C程序，而g++当作是c++程序；后缀为 `.cpp` 的，两者都会认为是c++程序***，注意，***虽然c++是c的超集，但是两者对语法的要求是有区别的***。C++的语法规则更加严谨一些。
  * > 2.***编译阶段，g++会调用gcc，对于c++代码，两者是等价的***，但是***因为gcc命令不能自动和C＋＋程序使用的库联接，所以通常用g++来完成链接***，为了统一起见，干脆编译/链接统统用g++了，这就给人一种错觉，好像cpp程序只能用g++似的。
- > 误区二:gcc不会定义 `__cplusplus` 宏，而g++会
  * > 实际上，***这个宏只是标志着编译器将会把代码按C还是C++语法来解释***，如上所述，***如果后缀为 `.c`，并且采用gcc编译器，则该宏就是未定义的***，否则，就是已定义。
- > 误区三:编译只能用gcc，链接只能用g++
  * > 严格来说，这句话不算错误，但是它混淆了概念，应该这样说：***编译可以用gcc/g++，而链接可以用g++或者 `gcc -lstdc++`***。因为gcc命令不能自动和C＋＋程序使用的库联接，所以通常使用g++来完成联接。但在编译阶段，g++会自动调用gcc，二者等价
- > 参数详解
  * > 无选项编译链接
    ```console
    将test.c预处理、汇编、编译并链接形成可执行文件。这里未指定输出文件，默认输出为a.out。
    例子用法：
    gcc test.c
    ```
    >> 【[:star:][`*`]】 //notes：文章这里四个步骤里的二和三的顺序不好（`编译`和`汇编`反了，应该`先编译再汇编`），更好的写法是：
    >>> **`源文件`** --> 经过 ***`预处理`*** 生成 **`.i`文件** --> 经过 ***`编译`*** 生成 **`.s`汇编文件** --> 经过 ***`汇编`*** 生成 ***`.o`目标文件*** --> 经过 ***`链接`*** 生成 **`可执行文件`** 或 **`库文件`**
  * > 无选项链接
    ```console
    gcc test.o -o test
    将编译输出文件test.o链接成最终可执行文件test。
    ```
  * > `-x language filename`
    + > 设定文件所使用的语言,使后缀名无效,对以后的多个有效。也就是根据约定C语言的后缀名称是 `.c` 的，而C++的后缀名是 `.C` 或者 `.cpp`, 如果你很个性，决定你的C代码文件的后缀名是 `.pig` 哈哈，那你就要用这个参数，这个参数对他后面的文件名都起作用，除非到了下一个参数的使用。
    ```concole  
    可以使用的参数有下面的这些  
    `c', `objective-c', `c-header', `c++', `cpp-output', `assembler', and `assembler-with-cpp'.  
    看到英文，应该可以理解的。  
    例子用法:  
    gcc -x c hello.pig
    ```
  * > `-x none filename`
    ```console
    关掉上一个选项，也就是让gcc根据文件名后缀，自动识别文件类型  
    例子用法:  
    gcc -x c hello.pig -x none hello2.c
    ```
  * > `-c`
    ```console
    只激活预处理,编译,和汇编,也就是他只把程序做成obj文件
    例子用法:
    gcc -c hello.c
    他将生成.o的obj文件
    gcc -c test.s
    将汇编输出文件test.s编译输出test.o文件。
    ```
  * > `-S`
    ```console
    只激活预处理和编译，就是指把文件编译成为汇编代码。
    例子用法:
    gcc -S hello.c
    他将生成.s的汇编代码，你可以用文本编辑器察看
    gcc -S test.i
    将预处理输出文件test.i汇编成test.s文件
    ```
  * > `-E`
    ```console
    只激活预处理,这个不生成文件,你需要把它重定向到一个输出文件里面.
    例子用法:
    gcc -E hello.c >; pianoapan.txt
    gcc -E hello.c | more 
    慢慢看吧,一个hello word 也要与处理成800行的代码
    gcc -E test.c -o test.i
    ```
  * > `-o`
    ```console
    制定目标名称,缺省的时候,gcc 编译出来的文件是a.out,很难听,如果你和我有同感，改掉它,哈哈
    例子用法:
    gcc -o hello.exe hello.c (哦,windows用习惯了)
    gcc -o hello.asm -S hello.c
    ```
- > **FAQ**
  * > 2、`-l` 参数和 `-L` 参数
    + > `-l` 参数就是用来指定程序要链接的库，***`-l` 参数紧接着就是`库名`***，那么`库名`跟真正的`库文件名`有什么关系呢？就拿数学库来说，他的库名是`m`，他的库文件名是`libm.so`，很容易看出，***把库文件名的头`lib`和尾`.so`去掉就是库名了***。
    + > 好了现在我们知道怎么得到库名了，比如我们自已要用到一个第三方提供的库名字叫 `libtest.so`，那么我们只要把 `libtest.so` 拷贝到 `/usr/lib` 里，***编译时加上 `-ltest` 参数***，我们就能用上`libtest.so` 库了（***当然要用 `libtest.so` 库里的函数，我们还需要与 `libtest.so` 配套的头文件***）。
    + > 放在 `/lib` 和 `/usr/lib` 和 `/usr/local/lib` 里的库直接用 `-l` 参数就能链接了，但如果库文件没放在这三个目录里，而是放在其他目录里，这时我们只用 `-l` 参数的话，链接还是会出错，出错信息大概是：`“/usr/bin/ld: cannot find -lxxx”`，也就是链接程序 `ld` 在那3个目录里找不到 libxxx.so，这时另外一个参数 `-L` 就派上用场了，比如常用的 `X11` 的库，它放在 `/usr/X11R6/lib` 目录下，我们编译时就要用 `-L/usr/X11R6/lib -lX11` 参数，***`-L` 参数跟着的是库文件所在的目录名***。
    + > 再比如我们把 `libtest.so` 放在 `/aaa/bbb/ccc` 目录下，那链接参数就是 `-L/aaa/bbb/ccc -ltest`。
    + > 另外，大部分 libxxxx.so 只是一个链接，以RH9为例，比如 libm.so 它链接到 /lib/libm.so.x，/lib/libm.so.6 又链到 /lib/libm-2.3.2.so，如果没有这样的链接，还是会出错，因为`ld`只会找libxxxx.so，所以如果你要用到xxxx库，而只有 libxxxx.so.x 或者 libxxxx-x.x.x.so，做一个链接就可以了`ln -s libxxxx-x.x.x.so libxxxx.so` <br> 手工来写链接参数总是很麻烦的，还好很多库开发包提供了生成链接参数的程序，名字一般叫 `xxxx-config`，一般放在 `/usr/bin` 目录下，比如 `gtk1.2` 的链接参数生成程序是 `gtk-config`，执行 `gtk-config --libs` 就能得到以下输出 `"-L/usr/lib -L/usr/X11R6/lib -lgtk -lgdk -rdynamic -lgmodule -lglib -ldl -lXi -lXext -lX11 -lm"`，这就是编译一个gtk1.2程序所需的gtk链接参数，`xxx-config` 除了 `--libs` 参数外还有一个参数是 `--cflags` 用来生成头文件包含目录的，也就是 `-I` 参数，在下面我们将会讲到。
    + > 你可以试试执行 `gtk-config --libs --cflags`，看看输出结果。现在的问题就是怎样用这些输出结果了，最笨的方法就是复制粘贴或者照抄，聪明的办法是在编译命令行里加入这个 ***\`xxxx-config --libs --cflags\`***，比如编译一个gtk程序：***gcc gtktest.c \`gtk-config --libs --cflags\`*** 这样就差不多了。注意 “\`” 不是单引号，而是1键左边那个键。除了 `xxx-config` 以外，现在新的开发包一般都用 `pkg-config` 来生成链接参数，使用方法跟 `xxx-config` 类似，但 `xxx-config` 是针对特定的开发包，但 `pkg-config` 包含很多开发包的链接参数的生成，用 `pkg-config --list-all` 命令可以列出所支持的所有开发包，`pkg-config` 的用法就是 `pkg-config pagName --libs --cflags`，其中pagName是包名，是 `pkg-config--list-all` 里列出名单中的一个，比如gtk1.2的名字就是gtk+，`pkg-config gtk+ --libs --cflags` 的作用跟 `gtk-config --libs --cflags` 是一样的。比如：***gcc gtktest.c \`pkg-config gtk+ --libs --cflags\`***。
  * > 3、`-include` 和 `-I` 参数
    + > `-include` 用来包含头文件，但一般情况下包含头文件都在源码里用 `#include xxxxxx` 实现，`-include` 参数很少用。`-I` 参数是用来指定头文件目录，`/usr/include` 目录一般是不用指定的，`gcc` 知道去那里找，但是如果头文件不在 `/usr/include` 里我们就要用 `-I` 参数指定了，比如头文件放在 `/myinclude` 目录里，那编译命令行就要加上 `-I/myinclude` 参数了，如果不加你会得到一个`"xxxx.h: No such file or directory"` 的错误。`-I` 参数可以用相对路径，比如头文件在当前目录，可以用 `-I.` 来指定。上面我们提到的 `--cflags` 参数就是用来生成 `-I` 参数的。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他

gcc 编译 选项 汇总 - 沃德锅的文章 - 知乎 https://zhuanlan.zhihu.com/p/347611674
- > **警告信息控制选项**
  * > `-W` 不建议使用此开关；请改用 `-Wextra`
    >> //notes：一般用 `-Wall` 全部开启，然后再用 `-Wno-xxxxxx` 禁用掉一些，比如：`-Wall -Wno-sign-compare -Wno-parentheses`。
- > **杂项**
  * > `-WX` 将警告视为错误 treat warnings as errors
  * > `-w` 禁用所有警告 disable all warnings

gcc/g++常用编译选项和gdb常用调试命令 https://andrewpqc.github.io/2018/11/25/gcc-and-gdb/

|**选项**|**作用**|
|--|--|
| `-L` | 指定库文件的搜索目录 |
| `-l` | (小写的L)链接某一库 |
| `-I` | (大写的i)指定头文件路径 |

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `-fPIC`

GCC -fPIC option https://stackoverflow.com/questions/5311515/gcc-fpic-option

gcc 编译参数 -fPIC 的详解和一些问题 https://blog.csdn.net/a_ran/article/details/41943749

linux编译动态库 fPIC作用 https://www.cnblogs.com/fengliu-/p/10216878.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `-Wl,-rpath`

GCC/G++选项 -Wl,-rpath= - 做点交易赚点钱的文章 - 知乎 https://zhuanlan.zhihu.com/p/415904958

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `-D_GLIBCXX_USE_CXX11_ABI`

`-D_GLIBCXX_USE_CXX11_ABI` 宏实验 https://blog.csdn.net/haolipengzhanshen/article/details/108540986
- Why we need `D_GLIBCXX_USE_CXX11_ABI=0` http://litaotju.github.io/c++/2019/02/24/Why-we-need-D_GLIBCXX_USE_CXX11_ABI=0/

CMake编译遇到这种ABI不兼容问题不要慌 https://segmentfault.com/a/1190000039773898

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# `LIBRARY_PATH` v.s. `LD_LIBRARY_PATH`

LIBRARY_PATH和LD_LIBRARY_PATH环境变量的区别 https://www.cnblogs.com/panfeng412/archive/2011/10/20/library_path-and-ld_library_path.html
- > `LIBRARY_PATH` 和 `LD_LIBRARY_PATH` 是Linux下的两个环境变量，二者的含义和作用分别如下：
  * > `LIBRARY_PATH` 环境变量用于在程序编译期间查找动态链接库时指定查找共享库的路径，例如，指定 `gcc` 编译需要用到的动态链接库的目录。
  * > `LD_LIBRARY_PATH` 环境变量用于在程序加载运行期间查找动态链接库时指定除了系统默认路径之外的其他路径，注意，`LD_LIBRARY_PATH` 中指定的路径会在系统默认路径之前进行查找。
- > 区别与使用：
  * > 开发时，设置 `LIBRARY_PATH`，以便 `gcc` 能够找到编译时需要的动态链接库。
  * > 发布时，设置 `LD_LIBRARY_PATH`，以便程序加载运行时能够自动找到需要的动态链接库。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
