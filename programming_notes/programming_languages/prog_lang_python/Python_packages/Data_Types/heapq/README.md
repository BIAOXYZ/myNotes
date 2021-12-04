
# 官方

`def heapify(x):` https://github.com/python/cpython/blob/2.7/Lib/heapq.py#L179

`8.4. heapq — 堆队列算法` https://docs.python.org/zh-cn/2.7/library/heapq.html#module-heapq

`heapq --- 堆队列算法` https://docs.python.org/zh-cn/3.7/library/heapq.html || `heapq — Heap queue algorithm` https://docs.python.org/3.7/library/heapq.html
- > 这个模块提供了堆队列算法的实现，也称为优先队列算法。
- > 堆是一个二叉树，它的每个父节点的值都只会小于或等于所有孩子节点（的值）。 它使用了数组来实现：从零开始计数，对于所有的 `k` ，都有 `heap[k] <= heap[2*k+1]` 和 `heap[k] <= heap[2*k+2]`。 为了便于比较，不存在的元素被认为是无限大。 堆最有趣的特性在于最小的元素总是在根结点：`heap[0]`。
- > 这个API与教材中堆算法的实现不太一样，在于两方面：
  * > （a）我们使用了基于零开始的索引。这使得节点和其孩子节点之间的索引关系不太直观，但是由于Python使用了从零开始的索引，所以这样做更加合适。
  * > 【[:star:][`*`]】 （b）我们的 pop 方法返回了最小的元素，而不是最大的（这在教材中叫做 “最小堆”；而“最大堆”在课本中更加常见，因为它更加适用于原地排序）。

# 其他

Heap queue (or heapq) in Python https://www.geeksforgeeks.org/heap-queue-or-heapq-in-python/

Heap queue (or heapq) in Python https://www.tutorialspoint.com/heap-queue-or-heapq-in-python

heapq – In-place heap sort algorithm https://pymotw.com/2/heapq/
