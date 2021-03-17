
# CPP Test general

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# GTest & GMock

## GTest & GMock 官方

GoogleTest https://github.com/google/googletest

GoogleTest User’s Guide https://google.github.io/googletest/
- Googletest Primer https://google.github.io/googletest/primer.html

Google Test https://en.wikipedia.org/wiki/Google_Test

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## GTest & GMock 其他

C++ 单元测试框架-gtest https://mikeblog.top/2019/01/02/googletest/

各位都是怎么进行单元测试的？ - 华威的回答 - 知乎 https://www.zhihu.com/question/27313846/answer/929580387

C++ 单元测试之 gtest & gmock https://juejin.cn/post/6844903976765243400
- > 3、C++单元测试框架
  * > C++的单元测试框架，我见过最常多的就是`gtest`了。除此之外，`boost`也提供了一个用于单元测试的框架，`boost`仅在学校时使用过，印象中与`gtest`使用方式大同小异。
  * > `Mockcpp`与`gtest`和`boost`不同，`Mockcpp`是C++的**Mock框架**，而后两者是**单元测试框架**（单元测试与Mock是相关但没有必然关联的两个东西）。`Mockcpp`的优点是可以Mock`C函数`和`静态成员函数`，下文有涉及到。

A quick introduction to the Google C++ Testing Framework https://developer.ibm.com/technologies/systems/articles/au-googletestingframework/

gtest-demo https://github.com/bast/gtest-demo

玩转Google开源C++单元测试框架Google Test系列(gtest)(总) https://www.cnblogs.com/coderzh/archive/2009/04/06/1426755.html

使用 Google Test 测试框架 http://senlinzhan.github.io/2017/10/08/gtest/

轻松编写 C++ 单元测试 https://www.cnblogs.com/fnlingnzb-learner/p/6927834.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Boost Test

C++ （boost） 单元测试 https://www.jianshu.com/p/9a87918023fb
- > 下面是一个小栗子：
```cpp
#include "boost/test/minimal.hpp"
#include "boost/format.hpp"
#include "iostream"

int test_main(int argc, char *argv[])           // 测试主函数，不需要在定义main()
{
    using namespace boost;
    format fmt("%d-%d");

    BOOST_CHECK(fmt.size() == 0);               // 验证fmt对象初始化，不通过继续执行
    
    fmt % 12 % 34;
    
    BOOST_REQUIRE(fmt.str() == "12-34");        // 验证结果，不通过则不予执行
    
    BOOST_ERROR("演示一条错误信息");                // 打印一条错误信息，继续执行

    fmt.clear();
    fmt % 12;
    try {
        std::cout << fmt;
    }
    catch (...) {
        BOOST_FAIL("致命错误，测试终止");            // 给出一个错误信息，终止执行
    }
    
    return 0;
}
```

4.4 使用Boost Test进行单元测试 https://www.bookstack.cn/read/CMake-Cookbook/content-chapter4-4.4-chinese.md
