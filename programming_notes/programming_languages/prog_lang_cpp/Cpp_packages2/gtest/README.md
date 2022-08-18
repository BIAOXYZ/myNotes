
# 官方

GoogleTest - Google Testing and Mocking Framework https://github.com/google/googletest

GoogleTest User’s Guide https://google.github.io/googletest/
- Googletest Primer https://google.github.io/googletest/primer.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# wiki

Google Test https://en.wikipedia.org/wiki/Google_Test

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 问题

### `undefined reference to testing::internal::EqFailure(char const*, char const*, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, bool)'`
>> //notes：我倒不是按下面的回答里的方法解决的，而是收到启发，注释掉了官方用例里的 `EXPECT_EQ(7 * 6, 42);` 就好了（但是实际上编译虽然过了，程序还是有问题- -）

undefined reference to testing::internal::EqFailure in gtest https://stackoverflow.com/questions/24820664/undefined-reference-to-testinginternaleqfailure-in-gtest

## `munmap_chunk(): invalid pointer  Aborted (core dumped)`

Tests crash with munmap_chunk(): invalid pointer https://groups.google.com/g/googletestframework/c/50lPrCOqt7E
- https://groups.google.com/g/googletestframework/c/50lPrCOqt7E/m/MuQWsxymC1YJ
  * > Most likely, your header with tests is included twice into two different source files, resulting it two sets of tests visible to Google Tests. Because you use anonymous namespaces, the linker symbols generated for those tests get unique names and the linker doesn't complain. Google Test has an internal check to detect such situations but it is apparently not triggered in this case. The safest solution is to put your tests into source files rather than into headers.

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他

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

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
