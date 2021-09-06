
Tensorflow源码解析1 -- 内核架构和源码结构 https://segmentfault.com/a/1190000018215986

Tensorflow源码解析2 -- 前后端连接的桥梁 - Session https://developer.aliyun.com/article/690687

Tensorflow源码解析3 -- TensorFlow核心对象 - Graph https://segmentfault.com/a/1190000018244576 || https://developer.aliyun.com/article/690686
- > 2 默认Graph
  * > **默认图替换**
    + > 之前讲解Session的时候就说过，***一个Session只能run一个Graph，但一个Graph可以运行在多个Session中***。常见情况是，session会运行全局唯一的隐式的默认的Graph，operation也是注册到这个Graph中。
    + > 也可以显示创建Graph，并调用 `as_default()` 使他替换默认Graph。在该上下文管理器中创建的op都会注册到这个graph中。退出上下文管理器后，则恢复原来的默认graph。一般情况下，我们不用显式创建Graph，使用系统创建的那个默认Graph即可。

Tensorflow源码解析7 -- TensorFlow分布式运行时 https://developer.aliyun.com/article/690682
