
Lists and Tuples in Python https://realpython.com/python-lists-tuples/
- > The syntax for reversing a list works the same way it does for strings:
  ```py
  >>> a[::-1]
  ['corge', 'quux', 'qux', 'baz', 'bar', 'foo']
  ```
- > The `[:]` syntax works for lists. However, there is ***an important difference between*** how this operation works with a list and how it works with a string.
  * > If `s` is a string, `s[:]` returns ***a reference to the same object***:
    ```py
    >>> s = 'foobar'
    >>> s[:]
    'foobar'
    >>> s[:] is s
    True
    ```
  * > Conversely, if `a` is a list, `a[:]` returns ***a new object that is a copy of `a`***:
    ```py
    >>> a = ['foo', 'bar', 'baz', 'qux', 'quux', 'corge']
    >>> a[:]
    ['foo', 'bar', 'baz', 'qux', 'quux', 'corge']
    >>> a[:] is a
    False
    ```
- > It’s not an accident that strings and lists behave so similarly. ***They are both special cases of a more general object type called an `iterable`***, which you will encounter in more detail in the upcoming tutorial on definite iteration.
- > **Lists Are Mutable**
  * > Most of the data types you have encountered so far have been atomic types. Integer or float objects, for example, are primitive units that can’t be further broken down. These types are immutable, meaning that they can’t be changed once they have been assigned. ***It doesn’t make much sense to think of changing the value of an integer. If you want a different integer, you just assign a different one***.
  * > By contrast, the string type is a composite type. Strings are reducible to smaller parts—the component characters. It might make sense to think of changing the characters in a string. ***But you can’t. In Python, strings are also immutable***.
  * > The list is the first ***mutable data type*** you have encountered. Once a list has been created, elements can be added, deleted, shifted, and moved around at will. Python provides a wide range of ways to modify lists.
- > Modifying Multiple List Values
  * > What if you want to change several contiguous elements in a list at one time? Python allows this with slice assignment, which has the following syntax:
    ```py
    a[m:n] = <iterable>
    ```
  * > You can insert multiple elements in place of a single element—just use a slice that denotes only one element:
    ```py
    >>> a = [1, 2, 3]
    >>> a[1:2] = [2.1, 2.2, 2.3]
    >>> a
    [1, 2.1, 2.2, 2.3, 3]
    ```
  * > Note that this is not the same as replacing the single element with a list:
    ```py
    >>> a = [1, 2, 3]
    >>> a[1] = [2.1, 2.2, 2.3]
    >>> a
    [1, [2.1, 2.2, 2.3], 3]
    ```
  * > You can also insert elements into a list without removing anything. Simply specify a slice of the form `[n:n]` (a zero-length slice) at the desired index:
    ```py
    >>> a = [1, 2, 7, 8]
    >>> a[2:2] = [3, 4, 5, 6]
    >>> a
    [1, 2, 3, 4, 5, 6, 7, 8]
    ```
  * > You can delete multiple elements out of the middle of a list by assigning the appropriate slice to an empty list. You can also use the `del` statement with the same slice:
    ```py
    >>> a = ['foo', 'bar', 'baz', 'qux', 'quux', 'corge']
    >>> a[1:5] = []
    >>> a
    ['foo', 'corge']
    ```
    ```py
    >>> a = ['foo', 'bar', 'baz', 'qux', 'quux', 'corge']
    >>> del a[1:5]
    >>> a
    ['foo', 'corge']
    ```
- > Prepending or Appending Items to a List
  * > Additional items can be added to the start or end of a list using the `+` concatenation operator or the `+=` augmented assignment operator:
    ```py
    >>> a = ['foo', 'bar', 'baz', 'qux', 'quux', 'corge']
    >>> a += ['grault', 'garply']
    >>> a
    ['foo', 'bar', 'baz', 'qux', 'quux', 'corge', 'grault', 'garply']
    ```
    ```py
    >>> a = ['foo', 'bar', 'baz', 'qux', 'quux', 'corge']
    >>> a = [10, 20] + a
    >>> a
    [10, 20, 'foo', 'bar', 'baz', 'qux', 'quux', 'corge']
    ```
  * > Note that a list must be concatenated with another list, so if you want to add only one element, you need to specify it as a singleton list:
    ```py
    >>> a = ['foo', 'bar', 'baz', 'qux', 'quux', 'corge']
    >>> a += 20
    Traceback (most recent call last):
      File "<pyshell#58>", line 1, in <module>
        a += 20
    TypeError: 'int' object is not iterable
    
    >>> a += [20]
    >>> a
    ['foo', 'bar', 'baz', 'qux', 'quux', 'corge', 20]
    ```
  * > **Note**: Technically, it isn’t quite correct to say a list must be concatenated with another list. More precisely, a list must be concatenated with an object that is iterable. Of course, lists are iterable, so it works to concatenate a list with another list.
  * > Strings are iterable also. But watch what happens when you concatenate a string onto a list:
    ```py
    >>> a = ['foo', 'bar', 'baz', 'qux', 'quux']
    >>> a += 'corge'
    >>> a
    ['foo', 'bar', 'baz', 'qux', 'quux', 'c', 'o', 'r', 'g', 'e']
    ```
  * > If you really want to add just the single string 'corge' to the end of the list, you need to specify it as a singleton list:
    ```py
    >>> a = ['foo', 'bar', 'baz', 'qux', 'quux']
    >>> a += ['corge']
    >>> a
    ['foo', 'bar', 'baz', 'qux', 'quux', 'corge']
    ```
- > a.append(<obj>)
  * > Remember that when the `+` operator is used to concatenate to a list, ***if the target operand is an `iterable`, then its elements are broken out and appended to the list individually***:
    ```py
    >>> a = ['a', 'b']
    >>> a + [1, 2, 3]
    ['a', 'b', 1, 2, 3]
    ```
  * > The `.append()` method does not work that way! If an iterable is appended to a list with `.append()`, it is added as a single object:
    ```py
    >>> a = ['a', 'b']
    >>> a.append([1, 2, 3])
    >>> a
    ['a', 'b', [1, 2, 3]]
    ```
  * > Thus, with `.append()`, you can append a string as a single entity:
    ```py
    >>> a = ['a', 'b']
    >>> a.append('foo')
    >>> a
    ['a', 'b', 'foo']
    ```
