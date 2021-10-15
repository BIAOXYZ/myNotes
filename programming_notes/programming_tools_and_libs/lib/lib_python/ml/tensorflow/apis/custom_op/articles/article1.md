
https://github.com/tensorflow/tensorflow/blob/edc16b85123e36295d72d55a1e75b9dca74914f9/tensorflow/core/framework/op_kernel.h#L240

https://github.com/tensorflow/tensorflow/blob/edc16b85123e36295d72d55a1e75b9dca74914f9/tensorflow/core/framework/op_kernel.cc
- https://github.com/tensorflow/tensorflow/blob/edc16b85123e36295d72d55a1e75b9dca74914f9/tensorflow/core/framework/op_kernel.h#L270

Tensorflow OpKernel机制详解 https://sketch2sky.com/2019/08/03/tensorflow-opkernel%e6%9c%ba%e5%88%b6%e8%af%a6%e8%a7%a3/
- > OpKernel是Op的具体实现, tf中已经实现的tfop的OpKernel在源码中的tensorflow/core/framework/kernel/中, OpKernel通过注册时使用相同的名字将自己和相应的Op联系到一起.
- > 在tf中, OpKernel进一步可以分为两类, OpKernel和AsyncOpKernel:
  * > OpKernel是同步执行的, 即"Compute()"返回即认为数据已经被正确处理, 注册OpKernel, 子类需要重写其Compute()方法.
  * > AsyncOpKernel是对OpKernel的封装, 顾名思义, AsyncOpKernel执行返回并不意味着数据已经被处理完毕, 数据的真正被处理完毕时通过回调的方式通知Op执行引擎, 注册一个AsyncOpKernel, 子类需要实现"AsyncCompute()"而不是Compute().

Tensorflow Op机制详解 https://sketch2sky.com/2019/08/03/tensorflow-op%e6%9c%ba%e5%88%b6%e8%af%a6%e8%a7%a3/

tensorflow源码剖析之framework-kernel https://www.cnblogs.com/jicanghai/p/9545674.html || https://www.codetd.com/article/2911299

tensorflow源码笔记(Eigen3部分) - smallsunsun的文章 - 知乎 https://zhuanlan.zhihu.com/p/106611937

Extending TensorFlow with Custom C++ Operations https://www.gresearch.co.uk/article/extending-tensorflow-with-custom-c-operations/
