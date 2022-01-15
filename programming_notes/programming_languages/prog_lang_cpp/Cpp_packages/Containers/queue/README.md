
# 官方

`header <queue>` https://www.cplusplus.com/reference/queue/
- **Classes**
  * std::queue https://www.cplusplus.com/reference/queue/queue/
  * std::priority_queue https://www.cplusplus.com/reference/queue/priority_queue/

std::priority_queue https://www.cplusplus.com/reference/queue/priority_queue/
- > **Priority queue**
  * > Priority queues are a type of ***container adaptors***, specifically designed such that ***its first element is always the greatest of the elements*** it contains, according to some strict weak ordering criterion.
    >> 【[:star:][`*`]】 //notes：也就是 C++ 的 `priority_queue` 是`大根堆`。这点C++和Python不一样，Python标准库 `heapq` 里的堆是`小根堆`。
  * > This context is similar to a heap, where elements can be inserted at any moment, and only the max heap element can be retrieved (the one at the top in the priority queue).
  * > Priority queues are implemented as ***container adaptors***, which are classes that use an ***encapsulated object of a specific container class*** as its underlying container, providing a specific set of member functions to access its elements. Elements are popped from the "back" of the specific container, which is known as the ***top*** of the `priority queue`.
  * > The underlying container may be any of the standard container class templates or some other specifically designed container class. The container shall be accessible through [random access iterators](https://www.cplusplus.com/RandomAccessIterator) and support the following operations:
    ```cpp
    empty()
    size()
    front()
    push_back()
    pop_back()
    ```
  * > The standard container classes [vector](https://www.cplusplus.com/vector) and [deque](https://www.cplusplus.com/deque) fulfill these requirements. By default, ***if no container class is specified for a particular `priority_queue` class instantiation, the standard container `vector` is used***.
  * > Support of [random access iterators](https://www.cplusplus.com/RandomAccessIterator) is required to keep a heap structure internally at all times. This is done automatically by the container adaptor by automatically calling the algorithm functions `make_heap`, `push_heap` and `pop_heap` when needed.
- > **Member functions**
  * std::priority_queue::top https://www.cplusplus.com/reference/queue/priority_queue/top/
  * std::priority_queue::pop https://www.cplusplus.com/reference/queue/priority_queue/pop/

std::priority_queue https://en.cppreference.com/w/cpp/container/priority_queue

priority_queue Class https://docs.microsoft.com/en-us/cpp/standard-library/priority-queue-class

# 其他

c++优先队列(priority_queue)用法详解 https://blog.csdn.net/weixin_36888577/article/details/79937886

# LeetCode
- `1609. 奇偶树` https://leetcode-cn.com/problems/even-odd-tree/
- `373. 查找和最小的 K 对数字` https://leetcode-cn.com/problems/find-k-pairs-with-smallest-sums/
