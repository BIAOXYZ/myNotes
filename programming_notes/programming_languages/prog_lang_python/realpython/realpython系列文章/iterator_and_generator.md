
How to Use Generators and yield in Python https://realpython.com/introduction-to-python-generators/
- > **Example 1: Reading Large Files**
- > You can also define a **generator expression** (also called a **generator comprehension**), which has a very similar syntax to [list comprehensions](). In this way, you can use the generator without calling a function:
  ```py
  csv_gen = (row for row in open(file_name))
  ```
- > This is a more succinct way to create the list csv_gen. You’ll learn more about the Python yield statement soon. For now, just remember this key difference:
  * > Using `yield` will result in a generator object.
  * > Using `return` will result in the first line of the file only.
- > **Example 2: Generating an Infinite Sequence**
- > **Understanding Generators**
  * > Generator functions look and act just like regular functions, but with one defining characteristic. Generator functions use the Python `yield` keyword instead of `return`. Recall the generator function you wrote earlier:
    ```py
    def infinite_sequence():
        num = 0
        while True:
            yield num
            num += 1
    ```
    > This looks like a typical function definition, except for the Python `yield` statement and the code that follows it. `yield` indicates where a value is sent back to the caller, ***but unlike `return`, you don’t exit the function afterward***.

Generator Expressions in Python: An Introduction https://dbader.org/blog/python-generator-expressions

Itertools in Python 3, By Example https://realpython.com/python-itertools/
