
C++ Morsels: `std::for_each` functors member variables https://web.archive.org/web/20171127171924/http://xenon.arcticus.com/c-morsels-std-for-each-functors-member-variables
- > So, picture the situation. You need to iterate the contents of an STL container, performing a given operation on each one. ![](https://web.archive.org/web/20171127171924im_/http://xenon.arcticus.com/files/imagecache/preview/files/for_each.png)
- > Perfect. `std::for_each` is your friend. It can take either a plain `unary function` (taking a single argument of the type of the item in the container) or a [`functor`](https://en.wikipedia.org/wiki/Functor) -- a special-purpose object that must have a specified method, typically the `operator ()` method (known as function-call), taking a single argument of the container's type. A functor could have other methods, but `for_each` won't call them, all it cares about is `operator ()`. More interestingly, a functor can also have data members. Again, `for_each` will disregard them, but your `operator ()` implementation can use them to store temporary data, and you can pre-load context data into them prior to calling `for_each`, to pass additional arguments.
- > But what if ***you want to collect data during the iteration of the container, and pass that data back to the caller***? See, `for_each` doesn't really allow you to return any state out of the unary function/functor (`"Its return value, if any, is ignored"`). However, the `for_each` documentation states that `"For_each returns the function object after it has been applied to each element."` Ahh, now this sounds promising. Let's have the functor collect the info in the functor's data members, and then we can fetch them out after `for_each` is done. Here's some example code of how that might look. I've written this from scratch without trying to compile it, there could be typos. I'm emphasizing property-type access to private member storage here, as that's something that the `for_each/functor` technique is especially effective on.

Functors in C++ https://www.geeksforgeeks.org/functors-in-cpp/
- > Please note that the title is **Functors** (Not Functions)!!
- > Consider a function that takes only one argument. However, while calling this function we have a lot more information that we would like to pass to this function, but we cannot as it accepts only one parameter. What can be done?
- > One obvious answer might be global variables. However, good coding practices do not advocate the use of global variables and say they must be used only when there is no other alternative.
- > Functors are objects that can be treated as though they are a function or function pointer. Functors are most commonly used along with STLs in a scenario like following:

What are C++ functors and their uses? https://stackoverflow.com/questions/356950/what-are-c-functors-and-their-uses

Functors: Function Objects in C++ https://www.cprogramming.com/tutorial/functors-function-objects-in-c++.html
