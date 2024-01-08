
Spark By Examples | Learn Spark Tutorial with Examples https://sparkbyexamples.com/

# 对比类

SparkSession vs SparkContext https://sparkbyexamples.com/spark/sparksession-vs-sparkcontext/

Spark RDD vs DataFrame vs Dataset https://sparkbyexamples.com/spark/spark-rdd-vs-dataframe-vs-dataset/
- > 4.RDD vs DataFrame vs Dataset in Apache Spark

  | **CONTEXT**	| **RDD** | **DATAFRAME** | **DATASET** |
  |--|--|--|--|
  |Performance | Low-level API with more control over the data, but lower-level optimizations compared to DataFrames and Datasets. | Optimized for performance, with high-level API, Catalyst optimizer, and code generation. | Datasets are faster than DataFrames because they use JVM bytecode generation to perform operations on data. This means that Datasets can take advantage of the JVM’s optimization capabilities, such as just-in-time (JIT) compilation, to speed up processing.|
  | Programming Language Support | RDD APIs are available in Java, Scala, Python, and R languages. Hence, this feature provides flexibility to the developers. | Available In 4 languages like Java, Python, Scala, and R. | Only available in Scala and Java. |

# 数据结构/数据类型

## RDD

Why Spark RDDs are immutable? https://sparkbyexamples.com/spark/why-spark-rdds-are-immutable/
- > **1. Create RDD**
  * > Note that when creating an RDD, ***it’s important to consider the data size and distribution to ensure optimal performance*** in distributed processing. Additionally, in newer versions of Spark, it’s recommended to ***use DataFrames and Datasets instead of RDDs for improved performance and ease of use***.
- > **2. Reason for Spark RDD immutability**

Spark Repartition() vs Coalesce() https://sparkbyexamples.com/spark/spark-repartition-vs-coalesce/
