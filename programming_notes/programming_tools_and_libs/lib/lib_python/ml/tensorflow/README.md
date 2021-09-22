
# 官方

TensorFlow: An Open Source Machine Learning Framework for Everyone https://github.com/tensorflow/tensorflow

Deep playground http://playground.tensorflow.org/

## 官方文档

使用 pip 安装 TensorFlow https://www.tensorflow.org/install/pip?hl=zh-cn

张量简介 https://www.tensorflow.org/guide/tensor || Introduction to Tensors https://www.tensorflow.org/guide/tensor
- > 张量是具有统一类型（称为 `dtype`）的多维数组。您可以在 `tf.dtypes.DType` 中查看所有支持的 `dtypes`。
- > 如果您熟悉 [NumPy](https://numpy.org/devdocs/user/quickstart.html)，就会知道张量与 `np.arrays` 有一定的相似性。
- > 就像 Python 数值和字符串一样，所有张量都是不可变的：永远无法更新张量的内容，只能创建新的张量。

创建运算 || Create an op https://www.tensorflow.org/guide/create_op
- > 注：为确保您的 C++ 自定义运算与 TensorFlow 的官方 pip 软件包 ABI 兼容，请遵循[自定义运算仓库](https://github.com/tensorflow/custom-op)中的指南。指南包含端到端代码示例以及用于构建和分发自定义运算的 Docker 镜像。

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

机器学习与tensorflow入门教程（任何人都能看懂） https://blog.csdn.net/ebzxw/article/details/86609997

## 构架设计

TensorFlow 架构 https://tensorflow.juejin.im/extend/architecture.html

## 基本概念

https://blog.csdn.net/dcrmg/category_7389638.html
- tensorflow中张量(tensor)的属性——维数(阶)、形状和数据类型 https://blog.csdn.net/dcrmg/article/details/79017146
- tensorflow中有向图（计算图、Graph）、上下文环境（Session）和执行流程 https://blog.csdn.net/dcrmg/article/details/79028003
- tensorflow中创建多个计算图(Graph) https://blog.csdn.net/dcrmg/article/details/79028032
- Tensorflow 模型文件结构、模型中Tensor查看 https://blog.csdn.net/dcrmg/article/details/79672874

## 源码

A simple TensorFlow-like graph computation framework in Python for learning purpose https://github.com/PytLab/simpleflow
- 实现属于自己的TensorFlow(一) - 计算图与前向传播 - 邵正将的文章 - 知乎 https://zhuanlan.zhihu.com/p/33290129 || https://cloud.tencent.com/developer/article/1073370
- 实现属于自己的TensorFlow(二) - 梯度计算与反向传播 - 邵正将的文章 - 知乎 https://zhuanlan.zhihu.com/p/33353929
- 实现属于自己的TensorFlow(三) - 反向传播与梯度下降实现 - 邵正将的文章 - 知乎 https://zhuanlan.zhihu.com/p/33468671

# 其他

tensorflow中的Embedding操作详解 - 申小明77的文章 - 知乎 https://zhuanlan.zhihu.com/p/85802954

## Eager Execution

Tensorflow eager execution 模式 - 书生意气的文章 - 知乎 https://zhuanlan.zhihu.com/p/47201474

终于！TensorFlow引入了动态图机制Eager Execution https://www.jiqizhixin.com/articles/2017-11-01-12

TensorFlow小白教程：Session基础教程 https://juejin.cn/post/6844903888303161351

## TensorFlow Boosted Trees (TFBT)

在 Tensorflow 中训练提升树（Boosted Trees）模型 https://tensorflow.google.cn/tutorials/estimator/boosted_trees
- https://github.com/tensorflow/docs-l10n/blob/master/site/zh-cn/tutorials/estimator/boosted_trees.ipynb

梯度提升树（Gradient Boosted Trees）：模型理解 https://tensorflow.google.cn/tutorials/estimator/boosted_trees_model_understanding

https://github.com/aymericdamien/TensorFlow-Examples/blob/master/tensorflow_v1/examples/2_BasicModels/gradient_boosted_decision_tree.py

https://github.com/aymericdamien/TensorFlow-Examples/blob/master/tensorflow_v2/notebooks/2_BasicModels/gradient_boosted_trees.ipynb

Gradient Boosting in TensorFlow vs XGBoost https://nicolovaligi.com/articles/gradient-boosting-tensorflow-xgboost/
- > Tensorflow 1.4 was released a few weeks ago with an implementation of Gradient Boosting, called **TensorFlow Boosted Trees (TFBT)**. Unfortunately, the [paper](https://arxiv.org/abs/1710.11555) does not have any benchmarks, so I ran some against XGBoost.
  >> TF Boosted Trees: A scalable TensorFlow based framework for gradient boosting https://arxiv.org/pdf/1710.11555.pdf
- > The code to reproduce the results in this article is on [GitHub](https://github.com/nicolov/gradient_boosting_tensorflow_xgboost).
  >> Gradient Boosting in TensorFlow vs XGBoost https://github.com/nicolov/gradient_boosting_tensorflow_xgboost
- > Neither of the two settings shown for TensorFlow could match the training time/accuracy of XGBoost. Besides the disadvantage in user time (total CPU time used), it also seems that TensorFlow isn't very effective at parallelizing on multiple cores either, leading to a massive gap in total (i.e. wall) time too. XGBoost has no trouble loading 16 of the 32 cores in my box (and can do better when using more trees), whereas TensorFlow uses less than 4. I guess that the whole "distributed TF" toolbox could be used to make TFBT scale better, but that seems overkill just to make full use of a single server.

## tf.Operation

初步理解 TensorFlow 的 operation - lonlon ago的文章 - 知乎 https://zhuanlan.zhihu.com/p/32399032

以线性回归为例，深入理解tensorflow的Operation、Tensor、Node的区别 https://blog.csdn.net/qq_27825451/article/details/105854164

# 自定义op

添加一个新操作（Op） https://tensorflow.juejin.im/extend/adding_an_op.html

自定义Tensorflow OP开发经验总结 https://www.jianshu.com/p/7b82b6e6ca75

Tensorflow上手3: 实现自己的Op https://mp.weixin.qq.com/s/MV3L_pZs_OJxyE43ZN8AsA
