
https://github.com/tensorflow/tensorflow/blob/master/tensorflow/core/framework/op_kernel.h
- `class OpKernelConstruction {` https://github.com/tensorflow/tensorflow/blob/edc16b85123e36295d72d55a1e75b9dca74914f9/tensorflow/core/framework/op_kernel.h#L240
- `const NodeDef& def() const { return props_->node_def; }` https://github.com/tensorflow/tensorflow/blob/edc16b85123e36295d72d55a1e75b9dca74914f9/tensorflow/core/framework/op_kernel.h#L270

https://github.com/tensorflow/tensorflow/blob/master/tensorflow/core/framework/op_kernel_test.cc
- https://github.com/tensorflow/tensorflow/blob/edc16b85123e36295d72d55a1e75b9dca74914f9/tensorflow/core/framework/op_kernel.cc

# 代码分析文章

https://blog.csdn.net/HaoBBNuanMM
- 【代码分析】Tensorflow OpShapeInferenceFn 详解 https://blog.csdn.net/HaoBBNuanMM/article/details/115352223
- 【架构分析】TensorFlow 自定义算子实现原理分析 https://blog.csdn.net/HaoBBNuanMM/article/details/112312235
