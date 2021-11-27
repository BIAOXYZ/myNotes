
List changes unexpectedly after assignment. Why is this and how can I prevent it? https://stackoverflow.com/questions/2612802/list-changes-unexpectedly-after-assignment-why-is-this-and-how-can-i-prevent-it
- https://stackoverflow.com/questions/2612802/list-changes-unexpectedly-after-assignment-why-is-this-and-how-can-i-prevent-it/2612815#2612815
  * > With `new_list = my_list`, you don't actually have two lists. ***The assignment just copies the reference to the list***, not the actual list, so both `new_list` and `my_list` refer to the same list after the assignment.
  * > To actually copy the list, you have various possibilities:
    + > You can use the builtin `list.copy()` method (available since `Python 3.3`):
      ```py
      new_list = old_list.copy()
      ```
    + > You can slice it:
      ```py
      new_list = old_list[:]
      ```
      > [Alex Martelli's](https://en.wikipedia.org/wiki/Alex_Martelli) opinion (at least [back in 2007](https://www.youtube.com/watch?v=g7V89K8QfgQ)) about this is, that it is a weird syntax and it does not make sense to use it ever. ;) (In his opinion, the next one is more readable).
    + > You can use the built in `list()` function:
      ```py
      new_list = list(old_list)
      ```
    + > You can use generic `copy.copy()`:
      ```py
      import copy
      new_list = copy.copy(old_list)
      ```
      > This is a little slower than `list()` because it has to find out the datatype of `old_list` first.
    + > If the list contains objects and you want to copy them as well, use generic `copy.deepcopy()`:
      ```py
      import copy
      new_list = copy.deepcopy(old_list)
      ```
      > Obviously the slowest and most memory-needing method, but sometimes unavoidable.
  * > **Example**:
    ```py
    import copy

    class Foo(object):
        def __init__(self, val):
             self.val = val

        def __repr__(self):
            return 'Foo({!r})'.format(self.val)

    foo = Foo(1)

    a = ['foo', foo]
    b = a.copy()
    c = a[:]
    d = list(a)
    e = copy.copy(a)
    f = copy.deepcopy(a)

    # edit orignal list and instance 
    a.append('baz')
    foo.val = 5

    print('original: %r\nlist.copy(): %r\nslice: %r\nlist(): %r\ncopy: %r\ndeepcopy: %r'
          % (a, b, c, d, e, f))
    ```
  * > Result:
    ```console
    original: ['foo', Foo(5), 'baz']
    list.copy(): ['foo', Foo(5)]
    slice: ['foo', Foo(5)]
    list(): ['foo', Foo(5)]
    copy: ['foo', Foo(5)]
    deepcopy: ['foo', Foo(1)]
    ```
