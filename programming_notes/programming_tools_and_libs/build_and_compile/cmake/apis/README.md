
set https://cmake.org/cmake/help/v3.0/command/set.html
- > Set a CMake, cache or environment variable to a given value.
  ```cmake
  set(<variable> <value>
      [[CACHE <type> <docstring> [FORCE]] | PARENT_SCOPE])
  ```
- > Within CMake sets `<variable>` to the value `<value>`. `<value>` is expanded before `<variable>` is set to it. ***Normally, `set` will set a `regular CMake variable`. If `CACHE` is present, then the `<variable>` is put in the `cache` instead, unless it is already in the cache***. See section [‘Variable types in CMake’]() below for details of `regular and cache variables` and their interactions. If `CACHE` is used, `<type>` and `<docstring>` are required. `<type>` is used by the CMake GUI to choose a widget with which the user sets a value. The value for `<type>` may be one of
  ```console
  FILEPATH = File chooser dialog.
  PATH     = Directory chooser dialog.
  STRING   = Arbitrary string.
  BOOL     = Boolean ON/OFF checkbox.
  INTERNAL = No GUI entry (used for persistent variables).
  ```
  > If `<type>` is `INTERNAL`, the `cache variable` is marked as internal, and will not be shown to the user in tools like `cmake-gui`. This is intended for values that should be persisted in the cache, but which users should not normally change. ***`INTERNAL` implies `FORCE`***.
  > 
  > Normally, `set(…CACHE…)` creates `cache variables`, but does not modify them. If `FORCE` is specified, the value of the `cache variable` is set, even if the variable is already in the cache. This should normally be avoided, as it will remove any changes to the cache variable’s value by the user.
- > **Variable types in CMake**
  * > In CMake there are <ins>***two***</ins> types of variables: `normal variables` and `cache variables`. `Normal variables` are meant for the internal use of the script (***just like variables in most programming languages***); they are not persisted across CMake runs. `Cache variables` (unless set with `INTERNAL`) are mostly intended for configuration settings where the first CMake run determines a suitable default value, which the user can then override, by editing the cache with tools such as `ccmake` or `cmake-gui`. `Cache variables` are stored in the `CMake cache file`, and are persisted across CMake runs.
  * > ***Both types can exist at the same time with the same name but different values***. When `${FOO}` is evaluated, CMake first looks for a normal variable ‘FOO’ in scope and uses it if set. If and only if no normal variable exists then it falls back to the cache variable ‘FOO’.
  * > Some examples:
    + > The code ‘set(FOO “x”)’ sets the normal variable ‘FOO’. It does not touch the cache, but it will hide any existing cache value ‘FOO’.
    + > The code ‘set(FOO “x” CACHE …)’ checks for ‘FOO’ in the cache, ignoring any normal variable of the same name. If ‘FOO’ is in the cache then nothing happens to either the normal variable or the cache variable. If ‘FOO’ is not in the cache, then it is added to the cache.
  * > Finally, whenever a cache variable is added or modified by a command, CMake also removes the normal variable of the same name from the current scope so that an immediately following evaluation of it will expose the newly cached value.
