
【[:star:][`*`]】 Python Decorators https://www.programiz.com/python-programming/decorator
- > A decorator ***takes in a function, adds some functionality and returns it***. In this tutorial, you will learn how you can create a decorator and why you should use it.
- > **Decorators in Python**
  * > Python has an interesting feature called **`decorators`** to add functionality to an existing code.
  * > This is also called **`metaprogramming`** because ***a part of the program tries to modify another part of the program <ins>at compile time</ins>***.
- > **Prerequisites for learning decorators**
  * > We must be comfortable with the fact that ***everything in Python (Yes! Even classes), are [objects](https://www.programiz.com/python-programming/class)***. Names that we define are simply identifiers bound to these objects. ***Functions are no exceptions, they are objects too (with attributes)***. Various ***different names can be bound to the same function object***.
    ```py
    def first(msg):
        print(msg)
    
    first("Hello")
    
    second = first
    second("Hello")
    ##################################################
    Hello
    Hello
    ```
    > When you run the code, both functions `first` and `second` give the same output. Here, the names `first` and `second` refer to ***the same function object***.
  * > Functions can be passed as arguments to another function.
  * > If you have used functions like ***`map`***, ***`filter`*** and ***`reduce`*** in Python, then you already know about this.
  * > Such functions that take other functions as arguments are also called **`higher order functions`**. Here is an example of such a function.
    ```py
    def inc(x):
        return x + 1
    
    def dec(x):
        return x - 1
    
    def operate(func, x):
        result = func(x)
        return result
    ##################################################
    >>> operate(inc,3)
    4
    >>> operate(dec,3)
    2
    ```
  * > Furthermore, a function can return another function.
    ```py
    def is_called():
        def is_returned():
            print("Hello")
        return is_returned
    
    new = is_called()
    
    # Outputs "Hello"
    new()
    ##################################################
    Hello
    ```
  * > Finally, we must know about [Closures in Python](https://www.programiz.com/python-programming/closure).
- > **Getting back to Decorators**
  * > Functions and methods are called **`callable`** as they can be called.
  * > In fact, any object which implements the special `__call__()` method is termed `callable`. So, in the most basic sense, ***<ins>a `decorator` is a `callable` that returns a `callable`</ins>***.
  * > Basically, a decorator ***takes in a function, adds some functionality and returns it***.
    ```py
    def make_pretty(func):
        def inner():
            print("I got decorated")
            func()
        return inner
        
    def ordinary():
        print("I am ordinary")
    ##################################################
    >>> ordinary()
    I am ordinary
    
    >>> # let's decorate this ordinary function
    >>> pretty = make_pretty(ordinary)
    >>> pretty()
    I got decorated
    I am ordinary
    ```
    > In the example shown above, `make_pretty()` is a decorator. In the assignment step:
    ```py
    pretty = make_pretty(ordinary)
    ```
    > The function `ordinary()` got decorated and the returned function was given the name `pretty`.
  * > We can see that ***the decorator function added some new functionality to the original function***. This is ***<ins>similar to packing a gift. The decorator acts as a wrapper</ins>***. The nature of ***<ins>the object that got decorated (actual gift inside) does not alter. But now, it looks pretty (since it got decorated)</ins>***.
  * > Generally, we decorate a function and reassign it as,
    ```py
    ordinary = make_pretty(ordinary)
    ```
    > This is a common construct and for this reason, Python has a syntax to simplify this.
  * > We can use the `@` symbol along with the name of the decorator function and place it above the definition of the function to be decorated. For example,
    ```py
    @make_pretty
    def ordinary():
        print("I am ordinary")
    ```
    > is equivalent to
    ```py
    def ordinary():
        print("I am ordinary")
    ordinary = make_pretty(ordinary)
    ```
    > This is just a syntactic sugar to implement decorators.
- > **Decorating Functions with Parameters**
  * > The above decorator was simple and it only worked with functions that did not have any parameters. What if we had functions that took in parameters like:
    ```py
    def divide(a, b):
        return a/b
    ```
    > This function has two parameters, `a` and `b`. We know it will give an error if we pass in `b` as `0`.
    ```py
    >>> divide(2,5)
    0.4
    >>> divide(2,0)
    Traceback (most recent call last):
    ...
    ZeroDivisionError: division by zero
    ```
  * > Now let's make a decorator to check for this case that will cause the error.
    ```py
    def smart_divide(func):
        def inner(a, b):
            print("I am going to divide", a, "and", b)
            if b == 0:
                print("Whoops! cannot divide")
                return
    
            return func(a, b)
        return inner

    @smart_divide
    def divide(a, b):
        print(a/b)
    ```
    > This new implementation will return None if the error condition arises.
    ```py
    >>> divide(2,5)
    I am going to divide 2 and 5
    0.4
    
    >>> divide(2,0)
    I am going to divide 2 and 0
    Whoops! cannot divide
    ```
- > **Chaining Decorators in Python**
