
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
