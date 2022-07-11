
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

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 3

【[:star:][`*`]】 C++ virtual关键字 https://blog.csdn.net/shuzfan/article/details/77165474
- > 之前始终没有搞清楚C++中 “virtual” 关键字的用法。 这里刚好看到国外网站上的一系列博客，感觉讲的比较透彻，所以自己总结记录于此。国外链接： http://www.geeksforgeeks.org/c-plus-plus/
- > **1.虚函数与运行多态**
  * > 结论： 虚函数的调用取决于指向或者引用的对象的类型，而不是指针或者引用自身的类型。 
  * > **虚函数表与虚函数指针**
    + > 程序是如何知道在运行时该调用基类还是子类的函数？ 这涉及到虚函数表和虚函数指针的概念。更多可以参考[《C++ 虚函数表解析》](http://blog.csdn.net/haoel/article/details/1948051/)。
      - > **vtable(虚函数表)**： 每一个含有虚函数的类都会维护一个虚函数表，里面按照声明顺序记录了虚函数的地址。
      - > **vptr(虚函数指针)**： 一个指向虚函数表的指针，每个对象都会拥有这样的一个指针。
- > **2.虚函数中默认参数**
  * > 解释与总结：
    + > **默认参数不包含在函数签名里**。 (函数签名定义了函数的输入与输出，包括参数及参数的类型、返回值及其类型、可能会抛出或传回的exceptions、该方法在面向对象程序中的可用性方面的信息诸如public、static或prototype等关键字等)
    + > **默认参数是静态绑定的，虚函数是动态绑定的。默认参数的使用需要看指针或者引用本身的类型，而不是对象的类型**。
    + > **绝不重新定义继承而来的缺省参数（Never redefine function’s inherited default parameters value.）**
- > **3.静态函数可以声明为虚函数吗？**
  * > 静态函数不可以声明为虚函数，同时也不能被 `const` 和 `volatile` 关键字修饰。
  * > 原因主要有两方面：
    + > `static` 成员函数不属于任何类对象或类实例，所以即使给此函数加上 `virutal` 也是没有任何意义
    + > 虚函数依靠 `vptr` 和 `vtable` 来处理。`vptr` 是一个指针，在类的构造函数中创建生成，并且只能用 `this` 指针来访问它，静态成员函数没有 `this` 指针，所以无法访问 `vptr`。
- > **4.构造函数可以为虚函数吗？**
  * > 构造函数不可以声明为虚函数。同时除了 `inline` 之外，构造函数不允许使用其它任何关键字。
  * > 为什么构造函数不可以为虚函数？
    + > 尽管虚函数表vtable是在编译阶段就已经建立的，但指向虚函数表的指针vptr是在运行阶段实例化对象时才产生的。 如果类含有虚函数，编译器会在构造函数中添加代码来创建vptr。 问题来了，如果构造函数是虚的，那么它需要vptr来访问vtable，可这个时候vptr还没产生。 因此，构造函数不可以为虚函数。
    + > 我们之所以使用虚函数，是因为需要在信息不全的情况下进行多态运行。而构造函数是用来初始化实例的，实例的类型必须是明确的。 因此，构造函数没有必要被声明为虚函数。
  * > 尽管构造函数不可以为虚函数，但是有些场景下我们确实需要 “Virtual Copy Constructor”。 “虚复制构造函数”的说法并不严谨，其只是一个实现了对象复制的功能的类内函数。 举一个应用场景，比如剪切板功能。 复制内容作为基类，但派生类可能包含文字、图片、视频等等。 我们只有在程序运行的时候才知道我们需要复制的具体是什么类型的数据。 实现方法如下：
- > **5.析构函数可以为虚函数吗？**
  * > 析构函数可以声明为虚函数。如果我们需要删除一个指向派生类的基类指针时，应该把析构函数声明为虚函数。 事实上，只要一个类有可能会被其它类所继承， 就应该声明虚析构函数(哪怕该析构函数不执行任何操作)。
- > **6.虚函数可以为私有函数吗？** 【-->  从这里开始，原文的序号错了：原文这里还是用的 `5.`，但是实际上已经是 `6.` 了。】
  * > 虚函数可以被私有化，但有一些细节需要注意。
- > **7.虚函数可以被内联吗？**
  * > 通常类成员函数都会被编译器考虑是否进行内联。 但通过基类指针或者引用调用的虚函数必定不能被内联。 当然，实体对象调用虚函数或者静态调用时可以被内联，虚析构函数的静态调用也一定会被内联展开。 (参考[《虚函数什么情况下会内联》](http://blog.csdn.net/zy1691/article/details/3606128))
- > **8.纯虚函数与抽象类**
  * > **纯虚函数**： 在基类中声明但不定义的虚函数，但要求任何派生类都要定义自己的实现方法。在基类中实现纯虚函数的方法是在函数原型后加“`=0`”，如 `virtual void funtion1()=0;`
  * > **抽象类**：含有纯虚函数的类为抽象类。

Virtual base class in C++ https://www.geeksforgeeks.org/virtual-base-class-in-c/
