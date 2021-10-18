
tf.data.experimental.make_csv_dataset https://www.tensorflow.org/api_docs/python/tf/data/experimental/make_csv_dataset

tf.nn，tf.layers， tf.contrib模块介绍 https://blog.csdn.net/Yuancccc/article/details/89472133

# [tf.device](https://www.tensorflow.org/api_docs/python/tf/device)

tf.device()指定tensorflow运行的GPU或CPU设备 https://blog.csdn.net/dcrmg/article/details/79747882
- > 在tensorflow中，我们可以使用 `tf.device()` 指定模型运行的具体设备，可以指定运行在GPU还是CUP上，以及哪块GPU上。
- > tensorflow中不同的GPU使用 `/gpu:0` 和 `/gpu:1` 区分，而CPU不区分设备号，统一使用 `/cpu:0`

# [tf.name_scope](https://www.tensorflow.org/api_docs/python/tf/name_scope)

TensorFlow入门（四） name / variable_scope 的使用 https://blog.csdn.net/jerr__y/article/details/60877873

TensorFlow入门（七） 充分理解 name / variable_scope https://blog.csdn.net/Jerr__y/article/details/70809528
- > **2.2 实验1结论**
  * > 从上面的实验结果来看，这三种方式所定义的变量具有相同的类型。而且只有 `tf.get_variable()` 创建的变量之间会发生命名冲突。在实际使用中，三种创建变量方式的用途也是分工非常明确的。其中
    ```console
    tf.placeholder() 占位符。* trainable==False *
    tf.Variable() 一般变量用这种方式定义。 * 可以选择 trainable 类型 *
    tf.get_variable() 一般都是和 tf.variable_scope() 配合使用，从而实现变量共享的功能。 * 可以选择 trainable 类型 *
    ```
- > `tf.name_scope()` 并不会对 `tf.get_variable()` 创建的变量有任何影响。`tf.name_scope()` 主要是用来管理命名空间的，这样子让我们的整个模型更加有条理。而 `tf.variable_scope()` 的作用是为了实现变量共享，它和 `tf.get_variable()` 来完成变量共享的功能。
- > **3.2 实验 2 结论**
  * > 首先我们要确立一种 Graph 的思想。在 TensorFlow 中，我们定义一个变量，相当于往 Graph 中添加了一个节点。和普通的 python 函数不一样，在一般的函数中，我们对输入进行处理，然后返回一个结果，而函数里边定义的一些局部变量我们就不管了。但是在 TensorFlow 中，我们在函数里边创建了一个变量，就是往 Graph 中添加了一个节点。***出了这个函数后，这个节点还是存在于 Graph 中的***。

理解tf.name_scope()和tf.variable_scope() https://www.jianshu.com/p/e88367df34b5

通俗理解tf.name_scope()、tf.variable_scope() - 质数的文章 - 知乎 https://zhuanlan.zhihu.com/p/52055580

# [tf.Tensor](https://www.tensorflow.org/api_docs/python/tf/Tensor) 相关

tf.Tensor https://www.tensorflow.org/api_docs/python/tf/Tensor

【[:star:][`*`]】 tf.SparseTensor - skye的文章 - 知乎 https://zhuanlan.zhihu.com/p/94035220

## [tf.convert_to_tensor](https://www.tensorflow.org/api_docs/python/tf/convert_to_tensor)

执行tf.convert_to_tensor()时，究竟发生了什么？ - 休语的文章 - 知乎 https://zhuanlan.zhihu.com/p/31308247

tf.convert_to_tensor的用法 https://blog.csdn.net/UESTC_C2_403/article/details/72190291

## `tensorflow.compat.v1`

tensorflow兼容处理 tensorflow.compat.v1 https://www.cnblogs.com/jfdwd/p/11446358.html
- > TensorFlow 2.0中提供了tensorflow.compat.v1代码包来兼容原有1.x的代码，可以做到几乎不加修改的运行。社区的contrib库因为涉及大量直接的TensorFlow引用代码或者自己写的Python扩展包，所以无法使用这种模式。TensorFlow 2.0中也已经移除了contrib库，这让人很有点小遗憾的。
- > 使用这种方式升级原有代码，只需要把原有程序开始的TensorFlow引用:
  ```py
  import tensorflow as tf
  ```
  > 替换为以下两行就可以正常的继续使用：
  ```py
  import tensorflow.compat.v1 as tf
  tf.disable_v2_behavior()
  ```
