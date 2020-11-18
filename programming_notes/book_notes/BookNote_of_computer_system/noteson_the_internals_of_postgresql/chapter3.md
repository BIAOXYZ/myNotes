
# [Chapter 3. Query Processing](http://www.interdb.jp/pg/pgsql03.html)

## 3.1. Overview
### 3.1.1. Parser
### 3.1.2. Analyzer/Analyser
### 3.1.3. Rewriter
### 3.1.4. Planner and Executor

## 3.2. Cost Estimation in Single-Table Query

> In PostgreSQL, there are three kinds of costs: start-up, run and total. The total cost is the sum of start-up and run costs; thus, only the start-up and run costs are independently estimated. || "在PostgreSQL中有三种代价，分别是启动代价、运行代价和总代价。总代价是启动代价和运行代价的和，因此只有启动代价和运行代价是单独估计的。"
- > 1.启动代价：在读取到第一条元组前花费的代价，比如索引扫描节点的启动代价就是读取目标表的索引页，获取到第一个元组的代价。
- > 2.运行代价：获取全部元组的代价。

### 3.2.1. Sequential Scan

> 中译版：“注意，这种类型的过滤器只会在读取所有元组的时候使用，它并不会减少需要扫描的表页面数量。” || 英文版："Note that this type of filter is used when reading all the tuples in the table, and it does not narrow the scanned range of table pages."
>> notes：这段中文版翻译的不是很好，意思稍有偏颇——人家英文原文的意思准确说是指`WHERE id < 8000`这个filter在使用的时候是对全表的所有tuple进行过滤（那么执行器肯定所有的tuple都要读）；而不是说“只会在读取所有元组的时候才会使用（这个filter）”。
