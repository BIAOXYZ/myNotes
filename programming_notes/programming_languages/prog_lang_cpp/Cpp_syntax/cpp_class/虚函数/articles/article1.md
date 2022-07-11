
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
  * > Let's change it a little now so that `eat()` is called via an intermediate function (a trivial function just for this example):
    ```cpp
    // This can go at the top of the main.cpp file
    void func(Animal *xyz) { xyz->eat(); }
    ```
    > Now our main function is:
    ```cpp
    Animal *animal = new Animal;
    Cat *cat = new Cat;
    
    func(animal); // Outputs: "I'm eating generic food."
    func(cat);    // Outputs: "I'm eating generic food."
    ```
    > Uh oh... we passed a Cat into `func()`, but it won't eat rats. Should you overload `func()` so it takes a `Cat*`? If you have to derive more animals from Animal they would all need their own `func()`.
  * > The solution is to make `eat()` from the `Animal` class ***a `virtual` function***:
    ```cpp
    class Animal
    {
        public:
            virtual void eat() { std::cout << "I'm eating generic food."; }
    };
    
    class Cat : public Animal
    {
        public:
            void eat() { std::cout << "I'm eating a rat."; }
    };
    ```
    > Main:
    ```cpp
    func(animal); // Outputs: "I'm eating generic food."
    func(cat);    // Outputs: "I'm eating a rat."
    ```
    > Done.
  * 回复里的：
    + > So if I'm understanding this correctly, `virtual` allows the subclass method to be called, even if the object is being treated as its superclass? 
    + > Instead of explaining late binding through the example of an intermediary function "func", here is a more straightforward demonstration -- 
      ```cpp
      Animal *animal = new Animal; 
      //Cat *cat = new Cat; 
      Animal *cat = new Cat; 
      animal->eat(); // outputs: "I'm eating generic food." 
      cat->eat(); // outputs: "I'm eating generic food." 
      ```
      > Even though you're assigning the subclassed object (Cat), the method being invoked is based on the pointer type (Animal) not the type of object it is point to. This is why you need "virtual".

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

# 3

Virtual base class in C++ https://www.geeksforgeeks.org/virtual-base-class-in-c/
