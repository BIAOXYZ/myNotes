
OrderedDict http://pymotw.com/2/collections/ordereddict.html

OrderedDict — Remember the Order Keys are Added to a Dictionary http://pymotw.com/3/collections/ordereddict.html
- > An `OrderedDict` is a dictionary subclass that remembers the order in which its contents are added.
  ```py
  # collections_ordereddict_iter.py
  import collections
  
  print('Regular dictionary:')
  d = {}
  d['a'] = 'A'
  d['b'] = 'B'
  d['c'] = 'C'
  for k, v in d.items():
      print(k, v)
  
  print('\nOrderedDict:')
  d = collections.OrderedDict()
  d['a'] = 'A'
  d['b'] = 'B'
  d['c'] = 'C'
  for k, v in d.items():
      print(k, v)
  ```
- > ***Before Python 3.6 a regular `dict` did not track the insertion order***, and iterating over it produced the values in order ***based on how the keys are stored in the hash table***, which is in turn ***influenced by a random value to reduce collisions***. In an `OrderedDict`, by contrast, the order in which the items are inserted is remembered and used when creating an iterator.
  ```sh
  $ python3.5 collections_ordereddict_iter.py
  
  Regular dictionary:
  c C
  b B
  a A
  
  OrderedDict:
  a A
  b B
  c C
  ```
- > ***Under Python 3.6, the built-in `dict` does track insertion order***, although this behavior is a side-effect of an implementation change and ***should not be relied on***.
  ```sh
  $ python3.6 collections_ordereddict_iter.py
  
  Regular dictionary:
  a A
  b B
  c C
  
  OrderedDict:
  a A
  b B
  c C
  ```
- > **Equality**
  * > A regular `dict` looks at its contents when testing for equality. An `OrderedDict` also considers the order in which the items were added.
    ```py
    # collections_ordereddict_equality.py
    import collections
    
    print('dict       :', end=' ')
    d1 = {}
    d1['a'] = 'A'
    d1['b'] = 'B'
    d1['c'] = 'C'
    
    d2 = {}
    d2['c'] = 'C'
    d2['b'] = 'B'
    d2['a'] = 'A'
    
    print(d1 == d2)
    
    print('OrderedDict:', end=' ')
    d1 = collections.OrderedDict()
    d1['a'] = 'A'
    d1['b'] = 'B'
    d1['c'] = 'C'
    
    d2 = collections.OrderedDict()
    d2['c'] = 'C'
    d2['b'] = 'B'
    d2['a'] = 'A'
    
    print(d1 == d2)
    ```
    > In this case, since the two ordered dictionaries are created from values in a different order, they are considered to be different.
    ```sh
    $ python3 collections_ordereddict_equality.py

    dict       : True
    OrderedDict: False
    ```

OrderedDict in Python https://www.geeksforgeeks.org/ordereddict-in-python/
- > An `OrderedDict` is a dictionary subclass that ***remembers the order that keys were first inserted***. The only difference between `dict()` and `OrderedDict()` is that: `OrderedDict` ***preserves the order*** in which the keys are inserted. A regular `dict` doesn’t track the insertion order, and iterating it gives the values in an arbitrary order. By contrast, the order the items are inserted is remembered by `OrderedDict`.
- > **Important Points**: 
  * > **1.Key value Change**: If the value of a certain key is changed, the position of the key ***remains unchanged*** in `OrderedDict`.
  * > **2.Deletion and Re-Inserting**: Deleting and re-inserting the same key will ***push it to the back*** as `OrderedDict`, however, maintains the order of insertion.
  >> //notes：说白了就是更新的话不会改变有序字典里key的先后顺序，但是删除再插入的话跟新插入一样，会改变其key的先后顺序。
- > **Other Considerations**:
  * > `OrderedDict` in Python version 2.7 consumes more memory than normal `dict`. This is due to the underlying ***Doubly Linked List implementation*** for keeping the order. In Python 2.7 `OrderedDict` is not `dict` subclass, it’s a specialized container from `collections` module.
  * > Starting from Python 3.7, insertion order of Python dictionaries is guaranteed.
    >> //notes：这里说的不太对，虽然说是有保证，但是还是不要依赖这个顺序。
  * > `OrderedDict` can be used as a stack with the help of `popitem` function. Try implementing LRU cache with `OrderedDict`.
