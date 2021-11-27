
Variables in Python https://realpython.com/python-variables/
- > **Object References**
- > **Object Identity**
  * > Deep Dive: Caching Small Integer Values
    + > From what you now know about variable assignment and object references in Python, the following probably won’t surprise you:
      ```py
      >>> m = 300
      >>> n = 300
      >>> id(m)
      60062304
      >>> id(n)
      60062896
      ```
    + > But consider this:
      ```py
      >>> m = 30
      >>> n = 30
      >>> id(m)
      1405569120
      >>> id(n)
      1405569120
      ```
    + > Here, m and n are separately assigned to integer objects having value 30. But in this case, id(m) and id(n) are identical!
    + > For purposes of optimization, the interpreter creates objects for the integers in the range [-5, 256] at startup, and then reuses them during program execution. Thus, when you assign separate variables to an integer value in this range, they will actually reference the same object.
