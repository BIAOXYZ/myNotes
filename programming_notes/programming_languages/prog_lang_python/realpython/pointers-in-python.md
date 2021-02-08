
Pointers in Python: What's the Point? https://realpython.com/pointers-in-python/
- > **Objects in Python**
  * > In Python, everything is an ***`object`***. For proof, you can open up a REPL and explore using `isinstance()`:
  * > This code shows you that everything in Python is indeed an object. Each object contains at least three pieces of data:
    + > ***Reference count***
    + > ***Type***
    + > ***Value***
  * > The reference count is for memory management. For an in-depth look at the internals of memory management in Python, you can read [Memory Management in Python](https://realpython.com/python-memory-management/).
  * > The type is used at the CPython layer to ensure type safety during runtime. Finally, there’s the value, which is the actual value associated with the object.
- > **Immutable vs Mutable Objects**
  * > As you can see, lots of commonly used primitive types are immutable. You can prove this yourself by writing some Python. You’ll need a couple of tools from the Python standard library:
    + > `id()` returns the object’s memory address.
    + > `is` returns True if and only if two objects have the same memory address.
  * > Once again, you can use these in a REPL environment:
    ```py
    >>> x = 5
    >>> id(x)
    94529957049376
    ```
  * > In the above code, you have assigned the value 5 to x. If you tried to modify this value with addition, then you’d get a new object:
    ```py
    >>> x += 1
    >>> x
    6
    >>> id(x)
    94529957049408
    ```
  * > Even though the above code appears to modify the value of x, you’re getting a **new** object as a response.
  * > Trying to directly mutate the string s results in an error:
    ```py
    >>> s[0] = "R"
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    TypeError: 'str' object does not support item assignment
    ```
  * > Contrast that with a mutable object, like list:
    ```py
    >>> my_list = [1, 2, 3]
    >>> id(my_list)
    140637819575368
    >>> my_list.append(4)
    >>> my_list
    [1, 2, 3, 4]
    >>> id(my_list)
    140637819575368
    ```
  * > This code shows a major difference in the two types of objects. *my_list* has an id originally. Even after 4 is appended to the list, *my_list* has the same id. This is because the list type is mutable.
  * > Another way to demonstrate that the list is mutable is with assignment:
    ```py
    >>> my_list[0] = 0
    >>> my_list
    [0, 2, 3, 4]
    >>> id(my_list)
    140637819575368
    ```
  * > In this code, you mutate *my_list* and set its first element to 0. However, it maintains the same id even after this assignment. 
- > **Understanding Variables**
  * > Python variables are fundamentally different than variables in C or C++. In fact, Python doesn’t even have variables. Python has `names`, not `variables`.
  * > To help drive home the difference, you can take a look at how variables work in C, what they represent, and then contrast that with how names work in Python.
- > Variables in C
  * > Let’s say you had the following code that defines the variable x:
    ```c
    int x = 2337;
    ```
  * > This one line of code has several, distinct steps when executed:
    > 1. Allocate enough memory for an integer
    > 2. Assign the value 2337 to that memory location
    > 3. Indicate that x points to that value 
  * > Shown in a simplified view of memory, it might look like this: ![](https://files.realpython.com/media/c_memory1.334fe7c13e82.png)
  * > If, later in the program, you want to change the value of x, you can do the following:
    ```c
    x = 2338;
    ```
  * > The above code assigns a new value (2338) to the variable x, thereby *overwriting* the previous value. This means that the variable x is **mutable**. The updated memory layout shows the new value: ![](https://files.realpython.com/media/c_memory2.14d638daf718.png)
  * > Notice that the ***location of x*** didn’t change, just the value itself. This is a significant point. It means ***that x is the memory location, not just a name for it***.
  * > Another way to think of this concept is in terms of ownership. In one sense, x owns the memory location. x is, at first, an empty box that can fit exactly one integer in which integer values can be stored.
  * > When you assign a value to x, you’re placing a value in the box that x owns. If you wanted to introduce a new variable (y), you could add this line of code:
    ```c
    int y = x;
    ```
  * > This code creates a new box called y and copies the value from x into the box. Now the memory layout will look like this: ![](https://files.realpython.com/media/c_memory3.5afe110faf4d.png)
  * > Notice the new location 0x7f5 of y. Even though the value of x was copied to y, the variable y owns some new address in memory. Therefore, you could overwrite the value of y without affecting x:
    ```c
    y = 2339;
    ```
  * > Now the memory layout will look like this: ![](https://files.realpython.com/media/c_memory4.45a45dbbfaab.png)
- > Names in Python
  * > Python does not have variables. It has names. Yes, this is a pedantic point, and you can certainly use the term variables as much as you like. ***It is important to know that there is a difference between variables and names***.
  * > Let’s take the equivalent code from the above C example and write it in Python:
    ```py
    >>> x = 2337
    ```
  * > Much like in C, the above code is broken down into several distinct steps during execution:
    > 1. Create a PyObject
    > 2. Set the typecode to integer for the PyObject
    > 3. Set the value to 2337 for the PyObject
    > 4. Create a name called x
    > 5. Point x to the new PyObject
    > 6. Increase the refcount of the PyObject by 1
  * > **Note**: The [PyObject](https://github.com/python/cpython/blob/v3.7.3/Include/object.h#L101) is not the same as Python’s **`object`**. It’s specific to CPython and represents the base structure for all Python objects.
    >
    > `PyObject` is defined as a C struct, so if you’re wondering why you can’t call `typecode` or `refcount` directly, its because you don’t have access to the structures directly. Method calls like [sys.getrefcount()](https://docs.python.org/3/library/sys.html#sys.getrefcount) can help get some internals.
  * > In memory, it might looks something like this: ![](https://files.realpython.com/media/py_memory1.2b6e5f8e5bc9.png)
  * > You can see that the memory layout is vastly different than the C layout from before. ***Instead of x owning the block of memory*** where the value 2337 resides, the newly created ***Python object owns the memory*** where 2337 lives. The Python name x doesn’t directly own any memory address in the way the C variable x owned a static slot in memory.
  * > If you were to try to assign a new value to x, you could try the following:
    ```py
    >>> x = 2338
    ```
  * > What’s happening here is different than the C equivalent, but not too different from the original bind in Python.
  * > This code:
    > - Creates a new PyObject
    > - Sets the typecode to integer for the PyObject
    > - Sets the value to 2338 for the PyObject
    > - Points x to the new PyObject
    > - Increases the refcount of the new PyObject by 1
    > - Decreases the refcount of the old PyObject by 1
  * > Now in memory, it would look something like this: ![](https://files.realpython.com/media/py_memory2.99bb432c3432.png)
  * > This diagram helps illustrate that ***x points to a reference to an object and doesn’t own the memory space*** as before. It also shows that ***the x = 2338 command is not an assignment, but rather binding the name x to a reference***.
    >
    > In addition, the previous object (which held the 2337 value) is now sitting in memory with a ref count of 0 and will get cleaned up by the [garbage collector](https://docs.python.org/3/faq/design.html?highlight=garbage%20collect#how-does-python-manage-memory).
