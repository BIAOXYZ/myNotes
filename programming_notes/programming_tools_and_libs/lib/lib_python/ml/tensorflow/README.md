
# 官方

TensorFlow: An Open Source Machine Learning Framework for Everyone https://github.com/tensorflow/tensorflow

Deep playground http://playground.tensorflow.org/

## 官方文档

张量简介 https://www.tensorflow.org/guide/tensor || Introduction to Tensors https://www.tensorflow.org/guide/tensor
- > 张量是具有统一类型（称为 `dtype`）的多维数组。您可以在 `tf.dtypes.DType` 中查看所有支持的 `dtypes`。
- > 如果您熟悉 [NumPy](https://numpy.org/devdocs/user/quickstart.html)，就会知道张量与 `np.arrays` 有一定的相似性。
- > 就像 Python 数值和字符串一样，所有张量都是不可变的：永远无法更新张量的内容，只能创建新的张量。

创建运算 || Create an op https://www.tensorflow.org/guide/create_op

tf.Operation https://www.tensorflow.org/api_docs/python/tf/Operation

初学者的 TensorFlow 2.0 教程 https://tensorflow.google.cn/tutorials/quickstart/beginner

# 较系统攻略

TensorFlow 如何入门，如何快速学习？ - 知乎 https://www.zhihu.com/question/49909565
- TensorFlow 如何入门，如何快速学习？ - 量子位的回答 - 知乎 https://www.zhihu.com/question/49909565/answer/546530350
  * > 传送门
    + > 教程地址： Simple and ready-to-use tutorials for TensorFlow https://github.com/instillai/TensorFlow-Course#why-use-tensorflow
  * > 另外，作者还推荐了其他一些他认可的TensorFlow教程资料：
    + > TensorFlow Examples https://github.com/aymericdamien/TensorFlow-Examples
    + > Tensorflow-101 https://github.com/sjchoi86/Tensorflow-101
- TensorFlow 如何入门，如何快速学习？ - Sherlock的回答 - 知乎 https://www.zhihu.com/question/49909565/answer/212011508
- TensorFlow 如何入门，如何快速学习？ - Snowkylin的回答 - 知乎 https://www.zhihu.com/question/49909565/answer/487934361

最全Tensorflow2.0 入门教程持续更新 - Doit的文章 - 知乎 https://zhuanlan.zhihu.com/p/59507137

英文教程太难啃？这里有一份TensorFlow2.0中文教程（持续更新中） https://www.jiqizhixin.com/articles/2019-05-02-2
- > 此文章中，机器之心为大家推荐一个持续更新的中文教程，方便大家更系统的学习、使用 TensorFlow 2.0 ：
  * > 知乎专栏地址： https://zhuanlan.zhihu.com/c_1091021863043624960
  * > Github 项目地址： https://github.com/czy36mengfei/tensorflow2_tutorials_chinese

## 构架设计

TensorFlow 架构 https://tensorflow.juejin.im/extend/architecture.html

# 其他

tensorflow中的Embedding操作详解 - 申小明77的文章 - 知乎 https://zhuanlan.zhihu.com/p/85802954

## Eager Execution

Tensorflow eager execution 模式 - 书生意气的文章 - 知乎 https://zhuanlan.zhihu.com/p/47201474

终于！TensorFlow引入了动态图机制Eager Execution https://www.jiqizhixin.com/articles/2017-11-01-12

TensorFlow小白教程：Session基础教程 https://juejin.cn/post/6844903888303161351

## tf.Operation

初步理解 TensorFlow 的 operation - lonlon ago的文章 - 知乎 https://zhuanlan.zhihu.com/p/32399032

以线性回归为例，深入理解tensorflow的Operation、Tensor、Node的区别 https://blog.csdn.net/qq_27825451/article/details/105854164

# 自定义op

自定义Tensorflow OP开发经验总结 https://www.jianshu.com/p/7b82b6e6ca75

Tensorflow上手3: 实现自己的Op https://mp.weixin.qq.com/s/MV3L_pZs_OJxyE43ZN8AsA
