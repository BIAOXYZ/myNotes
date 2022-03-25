
# 起因

C++ Morsels: `std::for_each` functors member variables https://web.archive.org/web/20171127171924/http://xenon.arcticus.com/c-morsels-std-for-each-functors-member-variables
- > So, picture the situation. You need to iterate the contents of an STL container, performing a given operation on each one. ![](https://web.archive.org/web/20171127171924im_/http://xenon.arcticus.com/files/imagecache/preview/files/for_each.png)
- > Perfect. `std::for_each` is your friend. It can take either a plain `unary function` (taking a single argument of the type of the item in the container) or a [`functor`](https://en.wikipedia.org/wiki/Functor) -- a special-purpose object that must have a specified method, typically the `operator ()` method (known as function-call), taking a single argument of the container's type. A functor could have other methods, but `for_each` won't call them, all it cares about is `operator ()`. More interestingly, a functor can also have data members. Again, `for_each` will disregard them, but your `operator ()` implementation can use them to store temporary data, and you can pre-load context data into them prior to calling `for_each`, to pass additional arguments.
- > But what if ***you want to collect data during the iteration of the container, and pass that data back to the caller***? See, `for_each` doesn't really allow you to return any state out of the unary function/functor (`"Its return value, if any, is ignored"`). However, the `for_each` documentation states that `"For_each returns the function object after it has been applied to each element."` Ahh, now this sounds promising. Let's have the functor collect the info in the functor's data members, and then we can fetch them out after `for_each` is done. Here's some example code of how that might look. I've written this from scratch without trying to compile it, there could be typos. I'm emphasizing property-type access to private member storage here, as that's something that the `for_each/functor` technique is especially effective on.

# 较清晰文章

Function Objects in the C++ Standard Library https://docs.microsoft.com/en-us/cpp/standard-library/function-objects-in-the-stl
- > A `function object`, or `functor`, ***is any type that implements `operator()`***. This operator is referred to as the call operator or sometimes the application operator. The C++ Standard Library uses function objects primarily as sorting criteria for containers and in algorithms.
  >> //notes：从 `for_each` 的一个帖子查下去，发现了 `functor` 这个概念。然后一直往下查，真是服了，下面一大堆文章，半天讲不清楚到底什么是 `functor`！微软这个文档，第一句话就搞定了！
- > Function objects provide ***two main advantages*** over a straight function call. The first is that ***a function object can contain state***. The second is that a function object is a type and therefore can be used as a template parameter.
- > **Creating a Function Object**
  * > To create a function object, ***create a type*** and ***implement `operator()`***, such as:
    ```cpp
    class Functor
    {
    public:
        int operator()(int a, int b)
        {
            return a < b;
        }
    };
    int main()
    {
        Functor f;
        int a = 5;
        int b = 7;
        int ans = f(a, b);
    }
    ```
  * > The last line of the `main` function shows how you call the function object. ***This call looks like a call to a function, but it's actually calling `operator()` of the Functor type***. This similarity between calling a function object and a function is how the term function object came about.
- > **Function Objects and Containers**
  * > The C++ Standard Library contains several function objects in the `<functional>` header file. One use of these function objects is as a sorting criterion for containers. For example, the `set` container is declared as follows:
    ```cpp
    template <class Key,
        class Traits=less<Key>,
        class Allocator=allocator<Key>>
    class set
    ```
  * > The second template argument is the function object `less`. This function object returns **`true`** if the first parameter is less than the second parameter. Since some containers sort their elements, the container needs a way of comparing two elements. The comparison is done by using the function object. You can define your own sorting criteria for containers by creating a function object and specifying it in the template list for the container.
- > **Function Objects and Algorithms**
  * > Another use of functional objects is in algorithms. For example, the `remove_if` algorithm is declared as follows:
    ```cpp
    template <class ForwardIterator, class Predicate>
    ForwardIterator remove_if(
        ForwardIterator first,
        ForwardIterator last,
        Predicate pred);
    ```
  * > The last argument to `remove_if` is a function object that returns a boolean value (a predicate). If the result of the function object is **`true`**, then the element is removed from the container being accessed by the iterators `first` and `last`. You can use any of the function objects declared in the `<functional>` header for the argument `pred` or you can create your own.

Function Object {aka Functors} in C++ https://dev.to/pratikparvati/function-object-aka-functors-in-c-456j
- > **Functors** in C++ are short for **function objects**. Function objects are instances of C++ classes that have the `operator()` defined, which gives the class object function semantics. In the class-like functions constructed in C++, the function is composed of the return type, function name, parameters, and function body. The basic accepted form of functors looks like this...
  >> //notes：这个也直接了当的讲清了 `functor` 的概念了。
  ```cpp
  class Functor
  {
  public:
      R operator()(P1, ..., Pn)
      {
          return R();
      }
  };
  ```
  > Where R is the return type, P is a parameter type and just like any function the number of parameters is arbitrary. The above code works because of the flexibility `operator()` provides in C++ which can take any number of arguments of any types and return anything it wants to (all the other operators have a fixed number of arguments).

# 其他文章

Functors in C++ https://www.geeksforgeeks.org/functors-in-cpp/
- > Please note that the title is **Functors** (Not Functions)!!
- > Consider a function that takes only one argument. However, while calling this function we have a lot more information that we would like to pass to this function, but we cannot as it accepts only one parameter. What can be done?
- > One obvious answer might be global variables. However, good coding practices do not advocate the use of global variables and say they must be used only when there is no other alternative.
- > Functors are objects that can be treated as though they are a function or function pointer. Functors are most commonly used along with STLs in a scenario like following:

What are C++ functors and their uses? https://stackoverflow.com/questions/356950/what-are-c-functors-and-their-uses

Functors: Function Objects in C++ https://www.cprogramming.com/tutorial/functors-function-objects-in-c++.html
