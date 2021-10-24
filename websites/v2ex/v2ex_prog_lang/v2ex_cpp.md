
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
