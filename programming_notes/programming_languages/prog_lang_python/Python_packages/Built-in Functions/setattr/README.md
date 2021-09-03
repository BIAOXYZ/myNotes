
# 官方

setattr(object, name, value) https://docs.python.org/3/library/functions.html#setattr

# 其他

Python setattr() https://www.programiz.com/python-programming/methods/built-in/setattr
- > **Example 2: When the attribute is not found in setattr()**
  * > If the attribute is not found, `setattr()` creates a new attribute an assigns value to it. However, ***this is only possible if the object implements the `__dict__()` method***.
  * > You can check all the attributes of an object by using the [`dir()`](https://www.programiz.com/python-programming/methods/built-in/dir) function.
    ```py
    class Person:
        name = 'Adam'
            
    p = Person()
    
    # setting attribute name to John
    setattr(p, 'name', 'John')
    print('Name is:', p.name)
    
    # setting an attribute not present in Person
    setattr(p, 'age', 23)
    print('Age is:', p.age)
    ```
    > **Output**
    ```console
    Name is: John
    Age is: 23
    ```
