
### Electron
- https://segmentfault.com/a/1190000006207600
- https://segmentfault.com/a/1190000005744529

为什么大家这么讨厌 Electron? https://www.v2ex.com/t/899773
```console
小弟最近搞了个新项目：https://he3.app 然后来 V2 发了一个贴：https://www.v2ex.com/t/899531#reply79 然后发现下面好多人非常讨厌 Electron，说要换 Tauri。
我在开发前也是了解 Tauri 的，而且自己也用 Tauri 写过项目。觉得 Tauri 挺好的，对 Tauri 也没有特别爱。觉得 Electron 也挺好的，技术成熟，跨平台兼容性好。但是发现好多人特别反感 Electron。
```
- > 体积大、重、启动慢、占用多。看看你电脑上装了多少个 chromium 了，除了少数开源且适配 electron 新版本快的应用可以复用一下，其他的每个应用都带一份 chromium ，用户当然讨厌了。
- > html 不是问题，问题是明明系统 webview 已经挺好用了还要自带一个 chrome ，浪费硬盘和内存
- > 缺点除了大之外还对客户端市场造成了不良影响 <br> 举个例子，某笔记团队本来是用的原生开发的，使用体验尚可，后来为了节约成本换 electron ，公司倒是省了用户就无语了，占用资源多偶尔还卡死，而这样干的当然不止这一家公司 <br> 所以大家也是苦 electron 久矣，如果能有替代品出现自然免不了一番吐槽 不过对于 tauri 能否担负起这个重担还是持怀疑态度
- > 不是码农，对 Electron 没有恶意，反而对用 mac 的我来说，Electron 使得跨平台更容易，这使得 mac 上的可用的软件得以扩充，现在好几个常用的都是如此。我想对于 mac 和其他小众操作系统来说，先解决有没有的问题才是最重要的吧。
- > 因为 electron 又大又慢还对系统支持不好
  ```console
  - electron 的窗口是自绘的，因此无法自适应系统主题、控制按钮扩展以及透明效果
  - electron 自己带一个 chromium ，然而明明系统里本身就有 WebView 控件，属于脱裤子放屁浪费磁盘，说兼容性的难道打包发布不都是直接 target 到 ES6 吗
  - electron 的主进程也是 js 写的，然而主进程涉及到消息事件循环等 CPU 较为密集的场景，性能非常烂，更别提浏览器进程和主进程相互 RPC 的性能就更拉了
  ```
  > 而 tauri 虽然也是 web 方案，却没有 electron 的问题
  ```console
  - tauri 的窗口仍然是系统的原生窗口
  - tauri 直接调用系统自带的 WebView
  - tauri 主进程是 rust 写的，对于 CPU 密集的场景也没有性能问题
  ```

# Vue.js

如何快速上手 vue？ https://www.v2ex.com/t/837468

# 其他

Python web UI 也来了 https://www.v2ex.com/t/897007
```console
抛开速度不谈 hah ，还是挺喜欢 py 的 https://nicegui.io/
之前分享的 diagrams https://diagrams.mingrammer.com/
```
- > 这种只能当玩具吧，Python 库做的封装，自定义 UI 很多得直接改库了
- > 怎么用着还有点卡顿....
  >> 用着卡是因为, 每个 UI 交互, 都走 ws 协议传给后端程序去处理逻辑了, 这奇怪的交互方式
- > 这响应速度让我怀疑穿越到了十多二十年前的 ie 时期......
- > 要是有人基于 PyScript 写一个类似 react 的框架，绝对火。
- > 简单看了一下源码, 跟踪了一下依赖包. https://github.com/justpy-org/justpy/blob/master/justpy/htmlcomponents.py#L76 <br> 干了很多脏活累活, 这种包, 后续维护下去, 苦不堪言. 可能最终都会是不堪重负, 不了了之. GUI 的方案已经很多了, 没必要用 python 写. web 系的方案, 成熟可靠. <br> ***实在讨厌 web, 还有 flutter + dart 可以选择. dart 语法非常简单, python 开发者基本不用学. 上手写就行了***. 这些小众方案, 往往浪费很多时间研究, 最终发现都是不满足需求.
- > 如果这个方案, 都能接受的. 相信 flutter web 的加载速度, 也能接受. 起码 flutter web 会持续优化加载速度. 而这种方案, 可能就别想了. <br> PS: rust 生态, tauri + vue, 写桌面版, 也是一个很好的方案. python 不适合这种场景, 就别瞎浪费时间了. 有这功夫, 又学会一门语言了(dart+flutter).
- > 后端写 ui 不方便，写多了发现还是 html+js+css 好用。python 有 https://github.com/python-eel/Eel 可以配合其他现代前端，和 go 的 wails 一样通过 websocket 调用
  >> UI 层确实是 html/js/css 的主战场. 既然已经接受了 html 方案. 就不应该继续使用 python + eel 这种优点全无的方案. flutter(上手更简单), rust + tauri 和 go + wails 都是更好的选择. <br> PS: flutter 和 tauri, 我都有写产品实践. flutter 写 mobile app 体验一流. tauri 可以快速把一个 前端(vue/react) 项目, 直接转换成 desktop app, 基本一行代码都不改. 各有优势. tauri 的优势是可以无痛复用整个前端生态, web 有的, 都可以复用. 这比 flutter 有天然优势. flutter 另起炉灶, 基本在复刻 web 生态的路上. 任重道远. 总之, 当下时间节点, UI/GUI 方案, 都有很成熟可靠的方案. 不要浪费时间在没有任何优势的方案上. 可能你的产品还没写完, 项目就先死了.

本人后端老研发，想请教一下前端的快速上手学习路线！感谢！ https://www.v2ex.com/t/866065
- > vue 很容易上手（所谓有手就行）基本三到五天就能开始干了，千万别再想 jquery 了，让岁月的长河冲走他吧
- > vue+nuxt.js. react 上手成本还是比 vue 高一点的, 至少 es6 和 typeScript 得玩得转. jq 就别惦记了, 对自己好点.
- > 建议 next.js, 很简单，而且 SEO 友好
- > 个人认为前端真正有趣的部分是动画交互 试试从 three.js 入手，会大大激起你对前端的兴趣
- > 需要 SEO 的话，学了 Vue 后直接用 Nuxt 就行了。
- > 后端出身的话算是有一定编程基础的啦，angular 最友好，angular/react/vue 都看了一遍，最后还是 angular 最香！
- > 同样推荐 angular ，别相信什么学习曲线，有 java/.net 经验的学起来简直不要太简单
- > 看 nuxt.js 看 2 就行了 千万不要看 3 。坑太多了 还不完善
- > 后端肯定 angular 啊，如果 angular 能上手了，看 vue 也简单了，再学学 vue3 的新语法连 react 也基本学会了

后端程序员想要学习一下前端，有无比较好的学习路线推荐 https://www.v2ex.com/t/840973
- > React 直接开撸，配合蚂蚁的 antd 都不用写 css 真感兴趣后面再细学
- > vue 一把唆，学什么 react ，有学 react 的时间 vue 都做完了
- > 必须是 vue, 语法类似后端的 template, 对于非专业前端而言是不二之选, 直接从官方文档和官方构建工具 vite 文档学习就好了, 很简单.
- > 我也是做后端的，现在也是 vue 一把梭。react 没学过。
- > https://chinese.freecodecamp.org/learn ，把前端相关的撸完就差不多了。我也是后端目前已经在写前端部分的了。
- > 前端入门基础百度 “表严肃” ，实战时 vue 和 react 都行，vue 的话推荐直接学 vue3 吧
- > 别理楼上生态的，以你的需求，vue 和 react 都足够了。vue 反倒是全家桶比较简单，可以直接撸代码。react 还要学其他的概念，后端的话推荐 vue ，简单粗暴，容易理解
