
【[:star:][`*`]】 Python Decorators https://www.programiz.com/python-programming/decorator
- > A decorator ***takes in a function, adds some functionality and returns it***. In this tutorial, you will learn how you can create a decorator and why you should use it.
- > **Decorators in Python**
  * > Python has an interesting feature called **decorators** to add functionality to an existing code.
  * > This is also called **metaprogramming** because ***a part of the program tries to modify another part of the program <ins>at compile time</ins>***.
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
  * > If you have used functions like `map`, `filter` and `reduce` in Python, then you already know about this.
  * > Such functions that take other functions as arguments are also called **higher order functions**. Here is an example of such a function.
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
  * > Functions and methods are called **callable** as they can be called.
