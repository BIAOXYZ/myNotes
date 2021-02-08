
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
    1. Allocate enough memory for an integer
    2. Assign the value 2337 to that memory location
    3. Indicate that x points to that value 
  * > Shown in a simplified view of memory, it might look like this: ![](https://files.realpython.com/media/c_memory1.334fe7c13e82.png)
  * > If, later in the program, you want to change the value of x, you can do the following:
    ```c
    x = 2338;
    ```
  * > The above code assigns a new value (2338) to the variable x, thereby *overwriting* the previous value. This means that the variable x is **mutable**. The updated memory layout shows the new value: ![](https://files.realpython.com/media/c_memory2.14d638daf718.png)
  * > Notice that the ***location of x*** didn’t change, just the value itself. This is a significant point. It means ***that x is the memory location, not just a name for it***.
