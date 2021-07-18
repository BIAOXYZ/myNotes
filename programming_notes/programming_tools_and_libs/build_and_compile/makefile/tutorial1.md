
# 官方英文版和中译版

Learn Makefiles -- With the tastiest examples https://makefiletutorial.com/ || https://github.com/theicfire/makefiletutorial

学习 Makefiles -- 内附可口示例 🌰 https://makefiletutorial.vercel.app || https://github.com/gavinliu6/Makefile-Tutorial-zh-CN
- > 与官方仓库的提交 https://github.com/theicfire/makefiletutorial/commit/580e106e0de92543cd85d6ce5e14dd716039ec7e 保持了同步

# 正文笔记

## 起步

- > 比较流行的 C/C++ 替代构建系统有 SCon 、CMake 、Bazel  和 Ninja 。一些代码编辑器，像 Microsoft Visual Studio ，内置了它们自己的构建工具。Java 则有 Ant 、Maven  和 Gradle 。其他语言像 Go 和 Rust 都有它们自己的构建工具。
- > Makefile 文件由一系列的 `规则 (rules)` 组成，一个规则类似这样：
  ```makefile
  targets: prerequisites
      command
      command
      command
  ```
  * `targets` 指的是文件名称，多个以空格分隔。通常，一个规则只对应一个文件。
  * `commands` 通常是一系列用于制作（make）一个或多个目标的步骤。它们 需要以一个制表符开头，而不是空格。
  * `prerequisites` 也是文件名称，多个以空格分隔。在运行目标的 commands 之前，要确保这些文件是存在的。它们也被称为 依赖。
