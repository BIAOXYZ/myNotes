
Awesome Rust https://github.com/rust-unofficial/awesome-rust

如何为TiKV做贡献 - 张汉东的文章 - 知乎 https://zhuanlan.zhihu.com/p/62370907
> 来This Week in Rust网站，然后会看到一个「Call for Participation」的分类，这下面的内容就是有人已经帮你选好的Rust生态中各种开源项目需要人帮忙的各种issues。上面也可以不定期地看到TiKV的各种issues
>> https://this-week-in-rust.org/

用Rust开发Linux驱动？内核维护者表示愿意接受 https://www.ithome.com/0/442/848.htm
> 不过底下有开发者指出了目前使用Rust实现驱动程序（ https://github.com/fishinabarrel/linux-kernel-module-rust ）的不便之处：
  - Linux内核不保证API/ABI的稳定性，因此很难设计通用的Rust接口。至少几乎不可能使它适用于所有版本的Linux。
  - 许多C语言特性没有相应的Rust支持。例如，构造具有位域（bitfield）的结构体似乎是无法实现的。
  
在不安装任何软件的情况下，学习 Rust https://www.v2ex.com/t/658299
- 如何在不安装任何软件的情况下，学习Rust https://juejin.im/post/5e81b40a6fb9a03c7e200308
  * > 通过 GitHub Actions，我们可以直接在你的浏览器中学习和探索 Rust 代码。

Rust语言圣经 (The Course) https://github.com/sunface/rust-course
- > “连续六年成为全世界最受喜爱的语言，无GC也无需手动内存管理、极高的性能和安全性、过程/OO/函数式编程、优秀的包管理、JS未来基石" — 工作之余的第二语言来试试Rust吧。`<<Rust语言圣经>>`拥有全面且深入的讲解、生动贴切的示例、德芙般丝滑的内容，甚至还有JS程序员关注的WASM和Deno等专题。这可能是目前最用心的Rust中文学习教程/书籍
- > 在线阅读
  * 官方：https://course.rs/
  * 国内镜像：https://book.rust.team/
  * 知乎：支持章节内目录跳转，很好用!  https://www.zhihu.com/column/c_1452781034895446017

Rust 程序设计语言 简体中文版 https://kaisery.github.io/trpl-zh-cn/ || https://github.com/KaiserY/trpl-zh-cn
- > 本书的 HTML 版本可以在 https://doc.rust-lang.org/stable/book/ （[简体中文译本](https://kaisery.github.io/trpl-zh-cn/title-page.html)）在线阅读，离线版则包含在通过 `rustup` 安装的 Rust 中；运行 `rustup docs --book` 可以打开。
- 4.认识所有权 https://kaisery.github.io/trpl-zh-cn/ch04-00-understanding-ownership.html

# Rust项目

RisingLight https://github.com/risinglightdb/risinglight

Type Exercise in Rust https://github.com/skyzh/type-exercise-in-rust
- > See Also...
  * > RisingLight is an OLAP database system for educational purpose. Most of the techniques described in this lecture have already been implemented in our educational database system “RisingLight”.

Nebari https://github.com/khonsulabs/nebari

🕳 bore is a simple CLI tool for making tunnels to localhost https://github.com/ekzhang/bore

The Algorithms - Rust https://github.com/TheAlgorithms/Rust

# Rust相关新闻

[评论]Go语言的成功也预示着Rust的成功 - 软件和应用 - cnBeta.COM https://www.cnbeta.com/articles/tech/789181.htm

# Rust语法点

## 内存安全

Rust 是如何保障内存安全的 https://xie.infoq.cn/article/3cfc5d243a16fd14d85628033

Rust是如何做到内存安全的 - chunquedong的文章 - 知乎 https://zhuanlan.zhihu.com/p/92277421

Rust是如何实现内存安全的--理解RAII/所有权机制/智能指针/引用 https://blog.csdn.net/gengzhikui1992/article/details/111413056
- > **1. rust的内存管理**
  * > **`RAII`(构造和析构)**
    + > `RAII`的机制来源于C++，`RAII`的设计目标就是替代`GC`，防止内存泄漏。`RAII`使用构造函数来初始化资源，使用析构函数来回收资源。
    + > `RAII`和`GC`最大的不同在于，`RAII`将资源托管给创建堆内存的指针对象本身来管理，并保证资源在其生命周期内始终有效，一旦生命周期终止，资源马上会被回收。
    + > `GC`是由第三方只针对内存来统一回收垃圾的，这样就很被动。
  * > **Rc引用计数智能指针**
    + > 注意，***在多个指针指向同一块内存的情况下，`RAII`机制是无法避免内存泄露的***。这个时候Rust提供了智能指针 `Rc＜T＞`，它的名字叫引用计数（reference counting）智能指针。`Rc＜T＞` 内部维护着一个引用计数器，每clone一次，计数器加1，当它们离开 `main` 函数作用域时，计数器会被清零，对应的堆内存也会被自动释放。
- > **3. 所有权系统**
  * > 现代C++的`RAII`机制解决了 ***无GC自动管理内存的基本问题***，但并没有解决全部问题，还存在着很多安全隐患。
  * > **空指针解引用**
    ```cpp
    #include <iostream>
    #include <memory>
    using namespace std;
    int main(){
        unique_ptr<int> orig(new int(5));
        cout << *orig << endl;
        auto stolen = move(orig);
        cout << *orig << endl;
    }
    ```
    > 上面这段C++代码，使用了 `move` 函数，将原来的 `unique_ptr` 指针赋予了stolen，并转让了所有权。原来的 orig 则变为了空指针，而对空指针解引用是很不安全的，所以该C++代码运行时就会抛出段错误（segmentation fault）。
    ```rust
    fn main(){
        let orig = Box::new(5);
        println!("{}", *orig);
        let stolen = orig;
        println!("{}", *orig);
    }
    ```
    > 这段Rust代码和上面的C++代码作用一样，***但是在Rust中，错误会在编译期间爆出来***。
  * > **Rust中的所有权是系统性概念**
    + > 可以看到Rust并没有显式地使用任何类似现代C++中的 `move` 函数来转移所有权，却拥有和现代C++一样的效果。
    + > 现代C++中的`RAII`机制虽然也有所有权的概念，但其作用范围非常有限，***仅智能指针有所有权，并且现代C++编译器也并没有依据所有权进行严格检查***，所以才会出现代码那样的解引用空指针的运行时错误。
    + > 而在Rust中，***所有权是系统性的概念，是Rust语言中的基础设施。Rust中的每个值都必定有一个唯一控制者，即，所有者***。所有权的转移都是按系统性的规则隐式地自动完成的，这也是代码清单5-2如此简洁的原因。
    + > 所有权系统是Rust的核心，可以说掌握了所有权系统，就等于掌握了Rust。
