
创建运算 || Create an op https://www.tensorflow.org/guide/create_op
- > 注：为确保您的 C++ 自定义运算与 TensorFlow 的官方 pip 软件包 ABI 兼容，请遵循[自定义运算仓库](https://github.com/tensorflow/custom-op)中的指南。指南包含端到端代码示例以及用于构建和分发自定义运算的 Docker 镜像。

自定义Tensorflow OP开发经验总结 https://www.jianshu.com/p/7b82b6e6ca75

# 个人实战1（其实基本例子只要参考官方文档就OK）

1. ***`zero_out.cc`***:
```cpp
#include "tensorflow/core/framework/op.h"
#include "tensorflow/core/framework/op_kernel.h"
#include "tensorflow/core/framework/shape_inference.h"

using namespace tensorflow;

REGISTER_OP("ZeroOut")
    .Input("to_zero: int32")
    .Output("zeroed: int32")
    .SetShapeFn([](::tensorflow::shape_inference::InferenceContext* c) {
      c->set_output(0, c->input(0));
      return Status::OK();
    });

class ZeroOutOp : public OpKernel {
 public:
  explicit ZeroOutOp(OpKernelConstruction* context) : OpKernel(context) {}

  void Compute(OpKernelContext* context) override {
    // Grab the input tensor
    const Tensor& input_tensor = context->input(0);
    auto input = input_tensor.flat<int32>();

    // Create an output tensor
    Tensor* output_tensor = NULL;
    OP_REQUIRES_OK(context, context->allocate_output(0, input_tensor.shape(),
                                                     &output_tensor));
    auto output_flat = output_tensor->flat<int32>();

    // Set all but the first element of the output tensor to 0.
    const int N = input.size();
    for (int i = 1; i < N; i++) {
      output_flat(i) = 0;
    }

    // Preserve the first input value if possible.
    if (N > 0) output_flat(0) = input(0);
  }
};

REGISTER_KERNEL_BUILDER(Name("ZeroOut").Device(DEVICE_CPU), ZeroOutOp);
```

2. ***编译以及在python命令行中的使用***：
```sh
TF_CFLAGS=( $(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_compile_flags()))') )
TF_LFLAGS=( $(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_link_flags()))') )
g++ -std=c++11 -shared zero_out.cc -o zero_out.so -fPIC ${TF_CFLAGS[@]} ${TF_LFLAGS[@]} -O2


(venv) $ TF_CFLAGS=( $(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_compile_flags()))') )
(venv) $ TF_LFLAGS=( $(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_link_flags()))') )
(venv) $ 
(venv) $ echo $TF_CFLAGS
-I/home/root/anaconda3/envs/venv/lib/python3.7/site-packages/tensorflow_core/include
(venv) $ echo $TF_LFLAGS 
-L/home/root/anaconda3/envs/venv/lib/python3.7/site-packages/tensorflow_core
(venv) $ 
(venv) $ g++ -std=c++11 -shared zero_out.cc -o zero_out.so -fPIC ${TF_CFLAGS[@]} ${TF_LFLAGS[@]} -O2
(venv) $ ll
total 44
drwxr-sr-x 2 root root  4096 Sep 22 15:13 .
drwxr-sr-x 3 root root  4096 Sep 22 14:15 ..
-rw-r--r-- 1 root root  1307 Sep 22 14:47 zero_out.cc
-rwxr-xr-x 1 root root 31288 Sep 22 15:13 zero_out.so
```
```py
>>> import tensorflow as tf
>>> zero_out_module = tf.load_op_library('./zero_out.so')
>>> print(zero_out_module.zero_out([[1, 2], [3, 4]]).numpy())
2021-09-22 15:23:02.978265: I tensorflow/core/platform/cpu_feature_guard.cc:142] Your CPU supports instructions that this TensorFlow binary was not compiled to use: AVX2 AVX512F FMA
2021-09-22 15:23:03.009136: I tensorflow/core/platform/profile_utils/cpu_utils.cc:94] CPU Frequency: 2399995000 Hz
2021-09-22 15:23:03.009837: I tensorflow/compiler/xla/service/service.cc:168] XLA service 0x564ac2004b10 executing computations on platform Host. Devices:
2021-09-22 15:23:03.009888: I tensorflow/compiler/xla/service/service.cc:175]   StreamExecutor device (0): Host, Default Version
[[1 0]
 [0 0]]
>>> 
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他

添加一个新操作（Op） https://tensorflow.juejin.im/extend/adding_an_op.html

Tensorflow上手3: 实现自己的Op https://mp.weixin.qq.com/s/MV3L_pZs_OJxyE43ZN8AsA

Adding a New Op https://chromium.googlesource.com/external/github.com/tensorflow/tensorflow/+/r0.7/tensorflow/g3doc/how_tos/adding_an_op/index.md

开源框架---tensorflow c++ API 运行第一个“手写字的例子” https://www.cnblogs.com/carle-09/p/11676324.html
