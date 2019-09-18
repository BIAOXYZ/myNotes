
Temporal database https://en.wikipedia.org/wiki/Temporal_database


```
Person(John Doe, Smallville, 3-Apr-1975, ∞).
                    |
                    |
Person(John Doe, Smallville, 3-Apr-1975, 26-Aug-1994).
Person(John Doe, Bigtown, 26-Aug-1994, ∞).
                    |
                    |
Person(John Doe, Smallville, 3-Apr-1975, 26-Aug-1994).
Person(John Doe, Bigtown, 26-Aug-1994, 1-Apr-2001).

----------------------------------------------------------------------------------------------------

Person(John Doe, Smallville, 3-Apr-1975,  ∞,           4-Apr-1975,  ∞∞  -->  27-Dec-1994).
Person(John Doe, Smallville, 3-Apr-1975,  26-Aug-1994, 27-Dec-1994, ∞          ).
Person(John Doe, Bigtown,    26-Aug-1994, ∞,           27-Dec-1994, ∞∞  -->  1-Apr-2001 ).
Person(John Doe, Bigtown,    26-Aug-1994, 1-Apr-2001,  1-Apr-2001, ∞ ).
```



```
Final State：
----------------------------------------------------------------------------------------------------
Person(John Doe, Smallville, 3-Apr-1975,  ∞,           4-Apr-1975,  27-Dec-1994).
Person(John Doe, Smallville, 3-Apr-1975,  26-Aug-1994, 27-Dec-1994, ∞          ).
Person(John Doe, Bigtown,    26-Aug-1994, ∞,           27-Dec-1994, 2-Feb-2001 ).
Person(John Doe, Bigtown,    26-Aug-1994, 1-Jun-1995,  2-Feb-2001,  ∞          ).
Person(John Doe, Beachy,     1-Jun-1995,  3-Sep-2000,  2-Feb-2001,  ∞          ).
Person(John Doe, Bigtown,    3-Sep-2000,  ∞,           2-Feb-2001,  1-Apr-2001 ).
Person(John Doe, Bigtown,    3-Sep-2000,  1-Apr-2001,  1-Apr-2001,  ∞          ).


Step 1.
----------------------------------------------------------------------------------------------------
Person(John Doe, Smallville, 3-Apr-1975,  ∞,           4-Apr-1975,  ∞∞).

Step 2.
----------------------------------------------------------------------------------------------------
Person(John Doe, Smallville, 3-Apr-1975,  ∞,           4-Apr-1975,  27-Dec-1994).
Person(John Doe, Smallville, 3-Apr-1975,  26-Aug-1994, 27-Dec-1994, ∞          ).
Person(John Doe, Bigtown,    26-Aug-1994, ∞,           27-Dec-1994, ∞∞ ).


Step 3.1.
----------------------------------------------------------------------------------------------------
Person(John Doe, Smallville, 3-Apr-1975,  ∞,           4-Apr-1975,  27-Dec-1994).
Person(John Doe, Smallville, 3-Apr-1975,  26-Aug-1994, 27-Dec-1994, ∞          ).
Person(John Doe, Bigtown,    26-Aug-1994, ∞,           27-Dec-1994, 2-Feb-2001 ).
Person(John Doe, Bigtown,    26-Aug-1994, 1-Jun-1995,  2-Feb-2001,  ∞          ).
Person(John Doe, Beachy,     1-Jun-1995,  3-Sep-2000,  2-Feb-2001,  ∞∞∞          ).
Step 3.2.
----------------------------------------------------------------------------------------------------
Person(John Doe, Smallville, 3-Apr-1975,  ∞,           4-Apr-1975,  27-Dec-1994).
Person(John Doe, Smallville, 3-Apr-1975,  26-Aug-1994, 27-Dec-1994, ∞          ).
Person(John Doe, Bigtown,    26-Aug-1994, ∞,           27-Dec-1994, 2-Feb-2001 ).
Person(John Doe, Bigtown,    26-Aug-1994, 1-Jun-1995,  2-Feb-2001,  ∞          ).
Person(John Doe, Beachy,     1-Jun-1995,  3-Sep-2000,  2-Feb-2001,  ∞∞∞          ).
Person(John Doe, Bigtown,    3-Sep-2000,  ∞,           2-Feb-2001,  ∞∞ ).

Step 4.
----------------------------------------------------------------------------------------------------
Person(John Doe, Smallville, 3-Apr-1975,  ∞,           4-Apr-1975,  27-Dec-1994).
Person(John Doe, Smallville, 3-Apr-1975,  26-Aug-1994, 27-Dec-1994, ∞          ).
Person(John Doe, Bigtown,    26-Aug-1994, ∞,           27-Dec-1994, 2-Feb-2001 ).
Person(John Doe, Bigtown,    26-Aug-1994, 1-Jun-1995,  2-Feb-2001,  ∞          ).
Person(John Doe, Beachy,     1-Jun-1995,  3-Sep-2000,  2-Feb-2001,  ∞∞∞          ).
Person(John Doe, Bigtown,    3-Sep-2000,  ∞,           2-Feb-2001,  1-Apr-2001 ).
Person(John Doe, Bigtown,    3-Sep-2000,  1-Apr-2001,  1-Apr-2001,  ∞          ).
```




Time series database https://en.wikipedia.org/wiki/Time_series_database
