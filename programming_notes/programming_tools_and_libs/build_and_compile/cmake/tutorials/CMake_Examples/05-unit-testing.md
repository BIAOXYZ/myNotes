
Unit Testing https://github.com/ttroy50/cmake-examples/blob/master/05-unit-testing/README.adoc
- > **Introduction**
  * > Unit testing is a software development process in which the smallest testable parts of an application, called units, are individually and independently scrutinized for proper operation. This can involve taking a class, function, or algorithm and writing test cases that can be run to verify that the unit is working correctly.
  * > CMake includes a tool called [`CTest`](https://cmake.org/Wiki/CMake/Testing_With_CTest) which allows you to enable the `make test` target to run automated tests such as unit tests.
  * > There are many ***unit-testing frameworks*** available which can be used to help automate and ease the development of unit tests. In these examples I show how to use some of these frameworks and call them using the CMake testing utility `CTest`.
  * > The examples here include using the following frameworks:
    + > [Boost Unit Test Framework](http://www.boost.org/doc/libs/1_56_0/libs/test/doc/html/utf/user-guide.html)
    + > [Google Test - Download](https://github.com/google/googletest)
    + > [Catch2](https://github.com/catchorg/Catch2)

Google Test Unit Testing Framework https://github.com/ttroy50/cmake-examples/blob/master/05-unit-testing/google-test-download/README.adoc
- > **Introduction**
  * > Using [`CTest`](https://cmake.org/Wiki/CMake/Testing_With_CTest) you can generate a ***`make test` target*** to run automated unit-tests. This example shows how to download and build the [google test](https://github.com/google/googletest) library, create tests and run them.
- > **Download and Build Google Test**
  * > 
    ```cmake
    add_subdirectory(3rd_party/google-test)
    ```
    > This will add the CMake files which download and build Google Test. This is ***the recommended way to add google test*** and there are more details from [google test readme](https://github.com/google/googletest/blob/master/googletest/README.md) and [here](http://crascit.com/2015/07/25/cmake-gtest/)
  * > Alternatives to this method include:
    + > Use something like `git submodule` to download the source to a folder in your tree and then do ***`add_subdirectory`***
    + > Vendor the google test source code within your repository
    + > Build google test externally and link it using ***`find_package(GTest)`*** - Not recommended by the google test authors anymore
- > **Enabling testing**
  * > To enable testing you must include the following line in your top level `CMakeLists.txt`
    ```cmake
    enable_testing()
    ```
    > This will enable testing for the current folder and all folders below it.
- > **Adding a testing executable**
  * > The requirement for this step will depend on your unit-test framework. In the example of google test, you can create binary(s) which includes all the unit tests that you want to run.
    ```cmake
    add_executable(unit_tests unit_tests.cpp)
    
    target_link_libraries(unit_tests
        example_google_test
        GTest::GTest
        GTest::main
    )
    ```
    > In the above code, a unit test binary is added, which links against the google test unit-test-framework using the `ALIAS` target setup during the [download and build](download and build) of GTest.
- > **Add A test**
  * > To add a test you call the ***`add_test()`*** function. This will create a named test which will run the supplied command.
    ```cmake
    add_test(test_all unit_tests)
    ```
    > In this example, we create a test called `test_all` which will run the executable created by the `unit_tests` executable created from the call to ***`add_executable`***
- > **Building the Example**
  ```sh
  # 前面内容省略
  
  $ make test
  Running tests...
  Test project /data/code/cmake-examples/05-unit-testing/google-test-download/build
      Start 1: test_all
  1/1 Test #1: test_all .........................   Passed    0.00 sec
  
  100% tests passed, 0 tests failed out of 1
  
  Total Test time (real) =   0.00 sec
  ```
  > If the code is changed and it causes the unit tests to produce an error. Then when running the tests you will see the following output.
    ```sh
    $ make test
    Running tests...
    Test project /data/code/cmake-examples/05-unit-testing/google-test-download/build
        Start 1: test_all
    1/1 Test #1: test_all .........................***Failed    0.00 sec
    
    0% tests passed, 1 tests failed out of 1
    
    Total Test time (real) =   0.00 sec
    
    The following tests FAILED:
        1 - test_all (Failed)
    Errors while running CTest
    Makefile:72: recipe for target 'test' failed
    make: *** [test] Error 8
    ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
