
# 1

Why do we need virtual functions in C++? https://stackoverflow.com/questions/2391679/why-do-we-need-virtual-functions-in-c
- 【[:star:][`*`]】 https://stackoverflow.com/questions/2391679/why-do-we-need-virtual-functions-in-c/2392656#2392656
  * > Let's say you have these two classes:
    ```cpp
    class Animal
    {
        public:
            void eat() { std::cout << "I'm eating generic food."; }
    };
    
    class Cat : public Animal
    {
        public:
            void eat() { std::cout << "I'm eating a rat."; }
    };
    ```
    > In your main function:
    ```cpp
    Animal *animal = new Animal;
    Cat *cat = new Cat;
    
    animal->eat(); // Outputs: "I'm eating generic food."
    cat->eat();    // Outputs: "I'm eating a rat."
    ```
    > So far so good, right? Animals eat generic food, cats eat rats, all without `virtual`.

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 2

C++ Virtual详解 https://blog.csdn.net/ring0hx/article/details/1605254
- > Virtual是C++ OO机制中很重要的一个关键字。只要是学过C++的人都知道在类Base中加了Virtual关键字的函数就是虚拟函数（例如下面例子中的函数print），于是在Base的派生类Derived中就可以通过重写虚拟函数来实现对基类虚拟函数的覆盖。当基类Base的指针point指向派生类Derived的对象时，对point的print函数的调用实际上是调用了Derived的print函数而不是Base的print函数。这是面向对象中的多态性的体现。（关于虚拟机制是如何实现的，参见Inside the C++ Object Model ，Addison Wesley 1996）
  ```cpp
  class Base
  {
  public:Base(){}
  public:
        virtual void print(){cout<<"Base";}
  };
  
  class Derived:public Base
  {
  public:Derived(){}
  public:
        void print(){cout<<"Derived";}
  };
  
  int main()
  {
        Base *point=new Derived();
        point->print();
  }
  //////////////////////////////////////////////////
  Output：
  Derived
  ```
