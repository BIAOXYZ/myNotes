
# From 权威网站

回调函数 https://zh.wikipedia.org/wiki/%E5%9B%9E%E8%B0%83%E5%87%BD%E6%95%B0 || Callback (computer programming) https://en.wikipedia.org/wiki/Callback_(computer_programming)

Callback function https://developer.mozilla.org/en-US/docs/Glossary/Callback_function || 回调函数 https://developer.mozilla.org/zh-CN/docs/Glossary/Callback_function
- > 被作为实参传入另一函数，并在该外部函数内被调用，用以来完成某些任务的函数，称为回调函数。
- > 例如：
  ```javascript
  function greeting(name) {
    alert('Hello ' + name);
  }
  
  function processUserInput(callback) {
    var name = prompt('请输入你的名字。');
    callback(name);
  }
  
  processUserInput(greeting);
  ```
  > 以上范例为 [同步](https://developer.mozilla.org/zh-CN/docs/Glossary/Synchronous) 回调，它是立即执行的。
- > 然而需要注意的是，回调函数经常被用于继续执行一个异步 完成后的操作，它们被称为异步回调。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他

回调函数（callback）是什么？ - 知乎 https://www.zhihu.com/question/19801131
- 回调函数（callback）是什么？ - 常溪玲的回答 - 知乎 https://www.zhihu.com/question/19801131/answer/13005983
  * > 你到一个商店买东西，刚好你要的东西没有货，于是你在店员那里留下了你的电话，过了几天店里有货了，店员就打了你的电话，然后你接到电话后就到店里去取了货。在这个例子里，***你的电话号码就叫`回调函数`***，你把电话留给店员就叫***登记回调函数***，店里后来有货了叫做***触发了回调关联的事件***，店员给你打电话叫做***调用回调函数***，你到店里去取货叫做***响应回调事件***。回答完毕。
- 回调函数（callback）是什么？ - no.body的回答 - 知乎 https://www.zhihu.com/question/19801131/answer/27459821
  * > 编程分为两类：系统编程（system programming）和应用编程（application programming）。所谓系统编程，简单来说，就是编写库；而应用编程就是利用写好的各种库来编写具某种功用的程序，也就是应用。系统程序员会给自己写的库留下一些接口，即API（application programming interface，应用编程接口），以供应用程序员使用。所以在抽象层的图示里，库位于应用的底下。
  * > 当程序跑起来时，一般情况下，应用程序（application program）会时常通过API调用库里所预先备好的函数。但是有些库函数（library function）却要求应用先传给它一个函数，好在合适的时候调用，以完成目标任务。这个被传入的、后又被调用的函数就称为回调函数（callback function）。
  * > 打个比方，有一家旅馆提供叫醒服务，但是要求旅客自己决定叫醒的方法。可以是打客房电话，也可以是派服务员去敲门，睡得死怕耽误事的，还可以要求往自己头上浇盆水。这里，“叫醒”这个行为是旅馆提供的，相当于库函数，但是叫醒的方式是由旅客决定并告诉旅馆的，也就是回调函数。而旅客告诉旅馆怎么叫醒自己的动作，也就是把回调函数传入库函数的动作，称为登记回调函数（to register a callback function）。如下图所示（图片来源：维基百科）：![](https://pic1.zhimg.com/80/0ef3106510e2e1630eb49744362999f8_1440w.jpg)
- 回调函数（callback）是什么？ - 码农的荒岛求生的回答 - 知乎 https://www.zhihu.com/question/19801131/answer/1641403537

怎么理解回调函数? https://www.v2ex.com/t/647806

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
