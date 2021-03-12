
# 官方

`header <set>` http://www.cplusplus.com/reference/set/

std::set http://www.cplusplus.com/reference/set/set/
- std::set::find http://www.cplusplus.com/reference/set/set/find/
  * `std::set<int>::iterator it;`

# 其他

[:star:][`*`]】C++中set用法详解 https://www.cnblogs.com/wkfvawl/p/11041079.html
- > （2）为何每次insert之后，以前保存的iterator不会失效？
  * > iterator这里就相当于指向节点的指针，内存没有变，指向内存的指针怎么会失效呢(当然被删除的那个元素本身已经失效了)。相对于vector来说，每一次删除和插入，指针都有可能失效，调用push_back在尾部插入也是如此。因为为了保证内部数据的连续存放，iterator指向的那块内存在删除和插入过程中可能已经被其他内存覆盖或者内存已经被释放了。即使时push_back的时候，容器内部空间可能不够，需要一块新的更大的内存，只有把以前的内存释放，申请新的更大的内存，复制已有的数据元素到新的内存，最后把需要插入的元素放到最后，那么以前的内存指针自然就不可用了。特别时在和find等算法在一起使用的时候，牢记这个原则：不要使用过期的iterator。
- > find
  * > find()，返回给定值的定位器，如果没找到则返回end()。
