
最近发现的 C++ 笑话： switch(a){ case 1: return 1;} https://www.v2ex.com/t/1034939
- > 本质的核心问题是 C++ 没有真正的 exhaustive 的 enum ，导致编译器无法限定 `E` 的值在一个可优化的 immedate value 范围内，无法将其在 comptime 求出来，所以将其放到参数里无法做编译期生成。为什么 `to_runtime` 又能 work 了？因为在当前场景下，编译器推导出来对于 `consteval` 函数 `flattern`，可行的值是有限的，所以能够正常编译。把最后一个分支改为 `f(_e)`，编译器会报错 `f` 为一个 `consteval function`，但是参数是 comptime unknown 的。对于有 exhaustive enum 的语言（ rust 、zig 等），要实现这种需求应该是 trivial 的。
  >> 补一句，通过 template + if constexpr + static_assert 可能可以将这个 `to_runtime` 自动化生成出来，不过我也好久没写过 C++ 了，如果不行当我没说。

【[:star:][`*`]】 关于 C++读取大小为 2.51 GB (2,701,131,776 字节)到 `char* yuanshuju` 数组中去 https://www.v2ex.com/t/1025635
```console
发现问题了。 问题代码：
qint64 dataSize = 2701131776;
char* yuanshuju = new char[dataSize];

可行代码：
char* yuanshuju = new char[2701131776];

c++,牛 我反正是没搞懂
```
- > 用 memory mapping ，不要手动去读它。
- > 不知道一次性读 2.51GB 数据的应用场景是什么
  >> 光谱数据处理，体谅挺大的
- > `new char[2,701,131,776]` 会分配长度是 776 个元素的 `char` 数组，不是你期待的 2.51 GB。`int main() { new char[2701131776] { }; }` 这个程序在我的电脑上编译为 64 位的话可以正常运行，并且确实占用了 2.51 GB 内存，如果用 32 位编译器则编译失败，因为分配的数组规模超过了 `size_t`。抛出 `std::bad_alloc` 的意思就是分配失败，或许你的页面文件和实体内存不够大。 <br> ***如果数据来自于文件，可以用内存映射文件***，Windows 的文档是 https://learn.microsoft.com/en-us/windows/win32/memory/file-mapping POSIX 的文档是 https://pubs.opengroup.org/onlinepubs/9699919799/functions/mmap.html
- > 我用 malloc ，别说是 malloc(2701131776) 可以, 就算 malloc(4701131776) 也行。应该只是你内存不够的原因。”不够“不是说总剩余内存不够，而是无法分配一块巨大内存。
- > 建议发一下编译器的版本 或者试试看这样写
  ```cpp
  auto alloc = vector<int64_t>(2701131776 / 8 + 1);
  char* yuanshuju = reinterpret_cast<char*>(alloc.data());
  ```
- > https://github.com/vimpunk/mio
- > C++ 标准不支持“柔性数组/变长数组”，数组大小是变量的情况，应该用 `vector` 一定要使用变量作数组长度的话，换 C 语言 (`C99`) 吧
  >> 他这个不是变长数组呀，用了 new 分配在堆上的，变长数组指的是分配在栈上的
- > 根据你给的附言，推测可能是你 `qtglobal` 头文件引入的有问题，导致 `qint64` 被认为是 `int32_t` 。因为 `2701131776 > INT_MAX(1 << 32 - 1)`，这个值在 assign 给 int32_t dataSize 之后被认为是一个负数，导致 bad_alloc 。
- > 这么大文件为什么不 mmap?
- > 试试用 `constexpr qint64 dataSize = 2701131776;` 行不行？
- > 动态长度用 `vector`，或者定义一个 `char*` ,然后 `malloc` 分配内存空间。
- > 等等，为什么要用 new 直接创建呢？最后还得手动 delete。不如用 `std::vector` 或者 `std::make_unique<char[]>(数据长度)` 这两个好多了 <br> `std::vector` 已经有人发了，那么 `make_unique` 的用法是：
  ```cpp
  size_t data_size{2701131776};
  std::unique_ptr<char[]> raw_data_ptr = std::make_unique<char[]>(data_size);
  char* raw_data = raw_data_ptr.get();
  ```
  * > 在我的 Windows 11 + VS2022 测了下，很成功，没任何报错。
  * > ***另外呢，直接用 `malloc` 、`new` 创建的空间，按照 C 语言留下来的“惯例”，是需要手动初始化的。通常会用 `memset` 初始化为零，用 `std::fill` 也可以。<ins>如果改用 `std::vector` 或者 `std::make_unique`，就可以跳过这一步，它们都会自动初始化</ins>***。

为什么大佬都建议写 c++不要写 `using namespace std` https://www.v2ex.com/t/979593
- > ....因为你整个命名空间就会是 std 了
- > ***因为有些系统 API 的名字恰好跟 `std` 内的相同，比如最常见的之一，`bind()`*** <br> using namespace 之后，就会出问题： https://stackoverflow.com/questions/8980384/libc-naming-conflict-for-bind
- > 可以把命名空间理解成一个村，using namespace A;就是用 A 村的人，using namespace B;就是用 B 村的人，std 也是个村，这三个不同的村里面有同名的人，比如张三，A 村的张三是厨师，B 村的张三是木匠，std 村的张三是电工；你现在准备做一大桌菜，所以想叫 A 村的张三这个厨师，但是你却写了 using namespace std; 那就是本来是 A::张三，现在变成了 std::张三，也就是叫来了 std 的张三这个电工，你让电工来给你做饭，那肯定就错了啊，using namespace 可以理解成是不同村的势力范围
- > 举个例子，`socket` 里面有一个 `bind` 函数用来绑定某个端口，C++ 有个 `std::bind`，你用了 using namespace std 的话，你输 bind ，IDE 不一定知道是到底是哪个 bind 。
- > 调内置库函数时加一个 `std::前缀`非常有仪式感，不加就显得很土😇

求教如何在 C++中优雅地实现在 C 中的 `void *` 所能实现的部分功能 https://www.v2ex.com/t/958698
- > 如果是这些结构体数据成员不同，但要实现相似（但不相同）的行为，可以用继承搭配虚函数。 <br> 如果是单纯想把不一样的数据存在一起，可以用 `std::variant` (C++17). <br> 如果这些数据逻辑上不需要统一管理，放在一起只是为了复用代码，那可以考虑引入模板，然后不同类型各管各的，利用模板复用同一套代码。
- > https://en.cppreference.com/w/cpp/utility/variant 把所有可能的类型都写上去 然后处理函数可以做成重载，或者用 https://en.cppreference.com/w/cpp/utility/variant/visit 里提示的 overloaded 方法
- > 有共性就继承，没有就 `std::any`，直接用 `void*` 也没啥不行的。

C++ 项目，出现了匪夷所思的 bug，在 vector 中添加对象，会导致 vector 崩溃，进而整个程序崩溃。 https://www.v2ex.com/t/941007
- > compiler explorer 没有问题，所以是其他部分 bug
- > gdb 运行。然后崩溃的地方看下 info threads ，看下是不是多线程操作 vector 了
- > 如果怀疑是多线程的问题的话，链接上 asan 再跑一下试试。
- > c++调试最麻烦的地方就在于，一些错误可以悄悄的传播到一个无关的代码上（几乎很难发现原始错误的地方）并且有些错误一旦挂了调试器 /santizer 就会消失
- > 检查下代码里有没有 `#pragma pack(n)` 对齐指令但没有 `#pragma pack()` 恢复默认，多年前遇到过这样一个案例，同事在他的头文件里 pack 对齐但没取消，我的结构体定义在我的头文件里，在不同 cpp 文件，先包含他的头文件再包含我的，和先包含我的或者不包含他的，我那个结构体的大小会不一样，于是也出现了匪夷所思的 crash ，害我 gdb 怼了小半天。
- > vector 实际用到的内存一律在堆上，跟对象本身分配在栈上还是堆上无关。这种崩溃 bug 基本上都是 heap corruption ，建议还是开一下 santinizer 或者 valgrind 看看有没有帮助。heap corruption 是最难调的…… 因为导致污染的地方和触发 crash 的地方可能相差十万八千里…… 祝好运
- > 遇到过因为前面代码的 memcpy 一个不同大小的结构体把栈写坏了，导致在其他地方 crash ，一般这种奇怪问题都不是在挂的那行的问题，而是其他地方把内存写坏导致，lz 查清了可以回来更新下后续

memcpy 绝对是 C++里的史前巨坑！ https://www.v2ex.com/t/926553
- > 我觉得 memcpy 不检查边界这件事情对 C 程序员来说应该是常识来着的
- > 确实要注意下, memmove 如果碰到 src 地址小于 dest, 会从尾巴地方往后处理, 这样就避免了 overlapping 数据
- > asan msan tsan lsan ubsan 五管齐下 可以用工具检测
- > 有重叠用 memmove ，没有重叠用 memcpy ，memcpy 都让传长度了，有没有溢出肯定程序员负责的。刚学 C 的时候，一看这俩函数功能差不多，就仔细查一下它们的区别。

C++ 中引用指针指向的变量会有问题吗？ https://www.v2ex.com/t/912900

c/c++多线程读写问题，怎么反驳? https://www.v2ex.com/t/887229
- > 扯具体实现就不要拎过来当什么 C/C++问题。C/C++？不务正业无中生有叠 UB 甲还嘴硬浪费别人时间拖进度，直接扣绩效。 <br> www.eel.is/c++draft/intro.multithread#intro.races <br> 连 int 有没什么脸特殊都不知道怎么混过来写 C/C++的。
- > a++会编译成：1.从内存读到寄存器，2.寄存器+1 ，3.寄存器写回内存，如果在步骤 1 或 2 之后线程切换了呢，会少+1 <br> 单寄存器的变量可以不加锁，但是要用 atomic 系列函数，利用 cpu 指令的原子性，可以查一下汇编 LOCK
- > 这种问题就和 python 的 dict 读写要不要加锁是一样的。x86 的内存读写指令，python dict 的读写，这些确实 atomic ，不加锁通常也能得到正确的结果。但是这么做会有一些问题，最简单的情况，一次读或者一次写当然没问题，但很难保证写出来的代码真的是这种单纯的情况。写汇编这么做没任何问题，就是标准的做法。如果写 C ，请写正确的 C 代码，别玩这些花样。 <br> 另外，“理由是 int 读写都是一个指令完成”，这个理由是错的。这和是不是一个指令没关系，CPU 不保证一条指令的 atomic ，比如在 x86 上跨 cacheline 的读写也是一条指令但不 atomic。CPU 的什么操作是 atomic 是个很复杂的事情，得去一个一个查。

C++一个指针，我怎么知道传进来的地址是在堆上还是在栈上？ https://www.v2ex.com/t/884939
- > 真的写出这种代码的话给调用者带来的迷惑不是一点半点... <br> 堆栈生长方向不一样，你随便把这个指针和局部变量比大小就行，毕竟是 caller 传给你的 <br> 但是不要这么做，最好要么始终不转移所有权，要么始终转移所有权，要么用智能指针
- > https://stackoverflow.com/questions/15376175/accessing-the-vm-areas-of-a-process
- > 判断一个内存段是否属于 heap ，需要借用 `mm_struct` 里面的 `start_brk`(heap 内存段的开始位置) 和 `brk`(heap 内存段的结束位置)。vma 的开始和结束地址在 `mm_struct` 的 `start_brk` 和 `brk` 之间，则说明地址在 heap 内存中。
  >> 写内核模块才能这样搞，用户态进程肯定不行。 <br> 解析 `/proc/[pid]/maps` 文件，从这个文件中可以知道进程的虚拟地址空间布局，包括 stack 和 heap 的地址范围。

【[:star:][`*`]】 C++中的数组寻址，是线性时间还是固定时间 https://www.v2ex.com/t/868384
- > 不学计算机组成，编程处处是魔法

请教一个 shared_ptr 内存泄漏的问题 https://www.v2ex.com/t/851924

C++ for 循环终止条件里面如果写一个数组的 size，会不会优化呢？ https://www.v2ex.com/t/848686

c++ 结构体初始化的问题 https://www.v2ex.com/t/846596

cpp 浮点的 ceil 计算和其它语言不一致的问题 https://www.v2ex.com/t/846153
- > C++中，result 是 uint64_t ，整型。所以(result * 10000000) / 23680 是整型计算，结果直接砍到了 831925 ，而不是 831925.6757 。而 js 中数字都是浮点数，(result * 10000000) / 23680 能得到精确结果 831925.6757 ，ceil 后就是 831926 了。所以 C++中 result 要定义成浮点类型，double 什么的。
- > 如上所说，C 里的整数运算算完除法之后结果还是整数，本来就不带小数部分的。其实用 ceil 函数截一下是多余的。
  * > 你在 Python 2 里运行 (1 * 33 + 49297) % 23680 * 10000000 / 23680
  * > 或者在 Python 3 里运行 (1 * 33 + 49297) % 23680 * 10000000 // 23680
  * > （因为 Python 2 的 /是整数除法，3 里 /是保留浮点结果，//是相当于 2 和 C 里 /的整数除法） 结果也是跟 C 一样的 831925 。
  * > 目测区分整数和浮点数的语言里全程用整数运算结果都应该是 831925 。

c++ lambda 表达式里 为什么值捕获的局部变量无法修改？ https://www.v2ex.com/t/838315
```cpp
[&i] ( ) { std::cout << i; }

// is equivalent to

struct anonymous
{
    int &m_i;
    anonymous(int &i) : m_i(i) {}
    inline auto operator()() const
    {
        std::cout << m_i;
    }
};
```
> 首先我知道，一个如上的 lambda 表达式，其实相当于生成了一个如上匿名 struct 的实例 a ，运行 lambda 表达式时，其实就相当于执行 a().
```cpp
int main()
{
    int v1 = 42;
    auto f = [v1]() {return ++v1; };//值捕获
    v1 = 0;
    auto j = f(); //j 为 43

}
```
> 但是如上的代码却无法通过编译，除非你加上 mutable 。所以我是不是可以认为，如上的 lambda 表达式，是不是实际生成了如下的 struct ？
```cpp
struct anonymous
{
    int m_i;
    anonymous(int i) : m_i(i) {}
    inline auto operator()() const//如果你加上 mutable ，这里的 const 才会去掉
    {
        m_i++;
    }
};
```
```console
另外，c++ lambda 表达式是不是都可以认为 它的等价情况，就是生成了一个 重载了 operator()的匿名结构体的实例？如果不是的话，请帮忙举一个反例。
```
- > `[v1]` 这是按值捕获，要用引用捕获 `[&v1]`
- > Lambda 确实就是匿名类型的实例化而已（没捕获的时候还带一个转换成函数指针的运算符重载） https://en.cppreference.com/w/cpp/language/lambda
- > 这么理解没错，可以上 Compiler Explorer 验证一下，比如带 mutable 就是没 const: https://godbolt.org/z/87EaPznM8 <br> 不带 mutable 就是有 const: https://godbolt.org/z/Y51KdT74j <br> 不过虽然现在的 gcc 和 msvc 确实都把 lambda 用仿函数实现，但这只是实现的方式，标准应该没说一定要这么做
- > 你想的没错，mutable 就是去掉 const ，而默认加 const 是为了让仿函数每次执行结果一致
  * > https://cppinsights.io/s/fc8369d5
  * > https://stackoverflow.com/a/5503690/8263383
- > Lambda 生成的类 operator()() 默认是 const 的，Google 搜索一下就有，实在是搜不到再发帖。看这里是怎么生成的 https://cppinsights.io/s/8efa4ddf
- > 文档里写： https://en.cppreference.com/w/cpp/language/lambda `Unless the keyword mutable was used in the lambda-expression, the function-call operator or operator template is const-qualified and the objects that were captured by copy are non-modifiable from inside this operator()`

inline 不能修饰一个全局函数呗？ https://www.v2ex.com/t/828136

问个关于内存对齐的问题 https://www.v2ex.com/t/809945
```console
为啥
struct FixedLengthHeader {
        uint32_t HeaderSize = 0;
        uint64_t CryptogramSize = 0;
        uint64_t ReservedField = 0;
}FixedPackageHeaders;
占用 20 字节（ 4+8+8 ），但是如果用下面这个写法，

struct FixedLengthHeader {
    uint32_t HeaderSize = 0;
    uint64_t CryptogramSize = 0;
    uint8_t DevFlag = 0;
    uint8_t HeaderVer = 0;
    uint32_t PackagerVer = 0;
    uint16_t Reserved = 0
}FixedPackageHeaders;
会因为内存对齐占用 24 字节(4+8+2+2+4+4)的内存呢……
```
- > 你可以试着看看每个成员的 offset 。不过我测试 MSVC, Gcc, Clang 下的 sizeof 都是 24 <br> https://godbolt.org/z/c1TM4778j

求教一个 cpp 语法问题 https://www.v2ex.com/t/800403
```console
https://github.com/envoyproxy/envoy-filter-example/blob/main/echo2_config.cc#L20 
这一行中的  “Network::ReadFilterSharedPtr{new Filter::Echo2()}”  为什么大括号是合法的呢？
```
- > `ReadFilterSharedPtr` 是一个智能指针 `using ReadFilterSharedPtr = std::shared_ptr<ReadFilter>;`
- > c++11 才有的特性，列表初始化
- > 这是 C++11 引入的统一初始化语法： https://www.geeksforgeeks.org/uniform-initialization-in-c/
- > https://en.cppreference.com/w/cpp/language/list_initialization

作为库作者，如何优雅地劫持 malloc https://www.v2ex.com/t/800023

c++中，`char*` 如何转换成 `std::shared_ptr<std::iostream>`？ https://www.v2ex.com/t/790826
- > 智能指针 `std::make_shared<std::iostream>(xxxxxxxxx)` <br> `char*` 到 `iostream`， 你可以找一下网上常见的那个从 `char* => streambuf => istream` 的转换方法，或许能用。然后拼起来，试试。
- > `std::shared_ptr<std::iostream> iosp = std::make_shared<std::stringstream>("you chars");`

虽然说没有银弹，但是我感觉 c++完全可以设计成更友好，开发速度更快的语言 https://www.v2ex.com/t/789560
- > CLion + CMake + C++17 + https://conan.io/  相信我，爽到飞起。
- > 在任何你想用 `new T` 并且只有一个人拥有它的地方都能用 `unique_ptr` 。 <br> 至于 `shared_ptr`，主要是不特定多个持有者要共享同一个对象才会用，这些持有者到底谁先死都不知道的时候还是有必要的。在多线程并发程序里面有时候还是躲不过的，比如 `boost::asio`
- > 另外我觉得 shared_ptr 最合适的场景其实是只读对象或者数据对象。一个对象被创建出来，记录了一些信息，发给多个持有者，这些持有者的生命周期都不一样，并且在错综复杂的多线程环境中。这种时候用 shared_ptr 就很合适。比如进程里面通过消息队列来传递消息的这种场景。

STL 源码分析--内存分配 https://www.v2ex.com/t/755950

std::async 的使用总结 https://www.v2ex.com/t/748174

请教一个 C++问题，为什么加了 inline 反而效率降低了 https://www.v2ex.com/t/737087

求教一个 c++语法问题, 这段代码为何只析构一次呢 https://www.v2ex.com/t/728092

求问， C++ 中如何提供接口让用户变量私有成员变量 vector https://www.v2ex.com/t/727461

被 C++的语法问题折磨了，有没有大佬帮我解答一下疑惑 https://www.v2ex.com/t/718467

请教一个简单的 C++并发文件写入冲突的问题。 https://www.v2ex.com/t/713956

c++ 可以通过 dump 或 core 调试分析出哪个线程修改了变量吗？ https://www.v2ex.com/t/697865

C++ queue 中不可以存放 vector<int>吗？ https://www.v2ex.com/t/688772
```cpp
queue<vector<int>> q; 当调用 q.front()时为什么返回值是 void 呢
```
- > http://cpp.sh/6cs3h <br> 没有发现这个问题。
- > 先改成 std::queue<std::vector<int>>再聊
- > http://www.cplusplus.com/reference/queue/queue/front/ <br> front 不会返回 void(至少不是 void 类型). 而返回 "空" 仅在 queue 为空的情况下. 但是即使这样, 也只会在使用返回值时报错. 而并非在 front 返回的时候. 除非编译器或者标准库做了检查. 但一般不会这样. 方便提供一下原始代码, 库和编译器的版本么?
- > 啊 是 CLion 的问题，CLion 提示错误，但是运行没错，是我傻了。感谢大家：）

求 C++书籍推荐 https://www.v2ex.com/t/679462

C++ 类构造时隐式转换的小疑惑 https://www.v2ex.com/t/674867

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
