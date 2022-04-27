
Python Set Methods https://www.programiz.com/python-programming/methods/set
- Python Set copy() https://www.programiz.com/python-programming/methods/set/copy
- Python Set issubset() https://www.programiz.com/python-programming/methods/set/issubset

# `.copy()`

Python Set copy() https://www.programiz.com/python-programming/methods/set/copy
- > A `set` can be copied using `=` operator in Python.
- > The problem with copying the `set` in this way is that if you modify the `numbers set`, the `new_numbers set` is also modified.
  ```py
  numbers = {1, 2, 3, 4}
  new_numbers = numbers

  new_numbers.add(5)

  print('numbers: ', numbers)
  print('new_numbers: ', new_numbers)
  ```
  ```console
  numbers:  {1, 2, 3, 4, 5}
  new_numbers:  {1, 2, 3, 4, 5}
  ```
- > **Return Value from `copy()`**
  * > The `copy()` method returns a ***shallow copy*** of the set.
- > Example 1: How the `copy()` method works for sets?
  ```py
  numbers = {1, 2, 3, 4}
  new_numbers = numbers.copy()

  new_numbers.add(5)

  print('numbers: ', numbers)
  print('new_numbers: ', new_numbers)
  ```
  ```console
  numbers:  {1, 2, 3, 4}
  new_numbers:  {1, 2, 3, 4, 5}
  ```
