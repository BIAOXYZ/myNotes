
# 重载

operator overloading https://en.cppreference.com/w/cpp/language/operators
- > Customizes the C++ operators for operands of user-defined types.

Overloading the `<<` Operator for Your Own Classes https://docs.microsoft.com/en-us/cpp/standard-library/overloading-the-output-operator-for-your-own-classes?view=msvc-160

13.4 — Overloading the I/O operators https://www.learncpp.com/cpp-tutorial/overloading-the-io-operators/
- > Of course, it makes more sense to do this as a reusable function. And in previous examples, you’ve seen us create `print()` functions that work like this:
  ```cpp
  #include <iostream>
  
  class Point
  {
  private:
      double m_x{};
      double m_y{};
      double m_z{};
  public:
      Point(double x=0.0, double y=0.0, double z=0.0)
        : m_x{x}, m_y{y}, m_z{z}
      {
      }
      double getX() const { return m_x; }
      double getY() const { return m_y; }
      double getZ() const { return m_z; }
      void print() const
      {
          std::cout << "Point(" << m_x << ", " << m_y << ", " << m_z << ')';
      }
  };
  
  int main()
  {
      const Point point{5.0, 6.0, 7.0};
      std::cout << "My point is: ";
      point.print();
      std::cout << " in Cartesian space.\n";
  }
  //////////////////////////////////////////////////
  My point is: Point(5, 6, 7) in Cartesian space.
  ```
  * > While this is much better, it still has some downsides. Because `print()` returns `void`, it can’t be called in the middle of an output statement.
- > **Overloading operator<<**
  ```cpp
  #include <iostream>
  
  class Point
  {
  private:
      double m_x{};
      double m_y{};
      double m_z{};
  public:
      Point(double x=0.0, double y=0.0, double z=0.0)
        : m_x{x}, m_y{y}, m_z{z}
      {
      }
      friend std::ostream& operator<< (std::ostream &out, const Point &point);
  };
  std::ostream& operator<< (std::ostream &out, const Point &point)
  {
      // Since operator<< is a friend of the Point class, we can access Point's members directly.
      out << "Point(" << point.m_x << ", " << point.m_y << ", " << point.m_z << ')'; // actual output done here
      return out; // return std::ostream so we can chain calls to operator<<
  }

  int main()
  {
      const Point point1{2.0, 3.0, 4.0};
      std::cout << point1 << '\n';
      return 0;
  }
  //////////////////////////////////////////////////
  Point(2, 3, 4)
  ```

Overloading stream insertion (<>) operators in C++ https://www.geeksforgeeks.org/overloading-stream-insertion-operators-c/

How to properly overload the << operator for an ostream? https://stackoverflow.com/questions/476272/how-to-properly-overload-the-operator-for-an-ostream
