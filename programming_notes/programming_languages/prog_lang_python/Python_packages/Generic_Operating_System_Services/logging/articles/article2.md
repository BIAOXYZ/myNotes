
# 1

【[:star:][`*`]】 Stop Using “Print” and Start Using “Logging” https://towardsdatascience.com/stop-using-print-and-start-using-logging-a3f50bc8ab0
- > The logging library provides you ***`five`*** tools to accomplish the logging tasks.
  * > 1.Debug (`logging.debug()`): Providing information to diagnosing problems.
  * > 2.Info (`logging.info()`): Tracking the normal operation of a program.
  * > 3.Warning (`logging.warning()`): Although the code is still working as expected, something unexpected happened.
  * > 4.Error (`logging.error()`): The code was unable to run some parts.
  * > 5.Critical (`logging.critical()`): The code cannot run.
- > Before using these tools, let’s understand different levels of logging in Python.
- > **Logging Levels in Python**
  * > There are ***`six`*** logging levels in Python. ***The highest level is `CRITICAL`. <ins>If you set your logging level to `CRITICAL`, only logging messages of the `CRITICAL` level will be shown</ins>***. To set your logging level to `CRITICAL`, you can use `logging.basicConfig()`.
    ```py
    logging.basicConfig(level=logging.CRITICAL)
    ```
    or
    ```py
    logging.basicConfig(level=50)
    ```
  * > As you see the `level` argument in `logging.basicConfig()` takes an integer number (i.e. `50` or constant `logging.CRITICAL`) and sets the logging level. The levels of logging from the lowest to the highest are ***<ins>`NOTSET=0, DEBUG=10, INFO=20, WARNING=30, ERROR=40, and CRITICAL=50`</ins>***.
  * > ***The default level is `WARNING` (i.e. `30`)*** which means, ***the logging module only displays/logs events with `warning`, `error`, or `critical` severity***. Again, remember that you can set your logging level using `logging.basicConfig()`.
    >> 【[:star:][`*`]】 //notes：也就是只会显示级别 ***大于等于*** 你设定级别的信息。
  * > Here is an example code to display different levels of logging messages. ***Note, I set the logging level to the lowest (`logging.NOTSET`) to displays all messages***.
    ```py
    import logging
    logging.basicConfig(level=logging.NOTSET)

    logging.debug('Here you have some information for debugging.')
    logging.info('Everything is normal. Relax!')
    logging.warning('Something unexpected but not important happend.')
    logging.error('Something unexpected and important happened.')
    logging.critical('OMG!!! A critical error happend and the code cannot run!')
    ```
  * > The output is something like this:
    ```console
    DEBUG:root:Here you have some information for debugging.
    INFO:root:Everything is normal. Relax!
    WARNING:root:Something unexpected but not important happend.
    ERROR:root:Something unexpected and important happened.
    CRITICAL:root:OMG!!! A critical error happend and the code cannot run!
    ```
  * > Let’s change the logging level to `WARNING`.
    ```py
    import logging
    logging.basicConfig(level=logging.WARNING)

    logging.debug('Here you have some information for debugging.')
    logging.info('Everything is normal. Relax!')
    logging.warning('Something unexpected but not important happend.')
    logging.error('Something unexpected and important happened.')
    logging.critical('OMG!!! A critical error happend and the code cannot run!')
    ```
  * > In this case, the output is:
    ```console
    WARNING:root:Something unexpected but not important happend.
    ERROR:root:Something unexpected and important happened.
    CRITICAL:root:OMG!!! A critical error happend and the code cannot run!
    ```
  * > As you see, because I set my logging level to `WARNING` (using `logging.WARNING` constant value), ***only messages with a severity of `WARNING` or higher are shown***.
  * > OK, it is good to use logging tools to display appropriate messages, but can I format my messages better that help me do betting logging of my code? The answer is YES. Let’s read the next section to format our logging messages better (and in a more meaningful way).
- > **Formatting Logging Messages**

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

【[:star:][`*`]】 Logging in Python: A Developer’s Guide https://blog.sentry.io/2022/07/19/logging-in-python-a-developers-guide/
- > **Getting Started with Logging in Python**
  * > The following code snippet shows how you can use all the five logging levels with the syntax:
    ```py
    logging.debug("A DEBUG Message")
    logging.info("An INFO")
    logging.warning("A WARNING")
    logging.error("An ERROR")
    logging.critical("A message of CRITICAL severity")
    ```
  * > You’ll see that the messages corresponding to `warning`, `error`, and `critical` are logged onto the console, whereas `debug` and `info` are not.
    ```console
    WARNING:root:A WARNING
    ERROR:root:An ERROR
    CRITICAL:root:A message of CRITICAL severity
    ```
    > This is because, ***by default, only messages corresponding to a logging level of `warning` and above are logged onto the console***. However, you can modify this ***by configuring the logger to <ins>start logging from a specific level of your choosing</ins>***.
    >> 【[:star:][`*`]】 //notes：1.不设置日志级别时，相当于默认的 logging level 是 `warning`，此时 `warning` 以下的 `info` 和 `debug` 不会打印到控制台；2.手动设置日志级别后，所有 ***大于等于*** 你设定的日志级别的会生效。
  * > **Note**: In the example explained in this tutorial, all code is in the `main.py` file and when we refactor existing code or add new modules, we explicitly state `<module-name>.py` to help you follow along.
- > **How to Log to a File in Python**
  * > To set up basic logging onto a file, you can use the `basicConfig()` constructor, as shown below.
    ```py
    logging.basicConfig(level=logging.INFO, filename="py_log.log",filemode="w")

    logging.debug("A DEBUG Message")
    logging.info("An INFO")
    logging.warning("A WARNING")
    logging.error("An ERROR")
    logging.critical("A message of CRITICAL severity")
    ```
  * > Next, let’s parse the above syntax for configuring ***the `root` logger***.
    + > `level`: This is the level you’d like to start logging at. ***If this is set to `info`, then all messages corresponding to `debug` are ignored***.
    + > `filename`: The parameter filename denotes the file handler object. You can specify the name of the file to log onto.
    + > `filemode`: This is an optional parameter specifying the mode in which you’d like to work with the log file specified by the parameter `filename`. Setting the `filemode` to write (`w`) will overwrite the logs every time the module is run. ***The default `filemode` is append (`a`)*** which means you’ll have a log record of events across all runs of the program.
  * > After running the `main` module, you’ll see that the log file `py_log.log` has been created in the current working directory. <br> ![](https://images.ctfassets.net/em6l9zw4tzag/7sfKpSWxY3M1naUcXnUISi/b25557aa7d2bc00796c6d9e48a8b03e4/logging-in-python-image3.png)
  * > Since we set the logging level to `info`, the log record now contains the message corresponding to `INFO`. <br> ![](https://images.ctfassets.net/em6l9zw4tzag/5Grtb1S0BFPgyut4T3nTd7/e7ffad26b8fa052e0b797079026347b9/logging-in-python-image1.png)
  * > The logs in the log file are of the format: `<logging-level>:<name-of-the-logger>:<message>`. The `<name-of-the-logger>` is by default ***the `root` logger***, as we haven’t yet configured custom loggers. <br> ![](https://images.ctfassets.net/em6l9zw4tzag/5Qgo39czWWL1c1yd2wkAKA/c5a6a61024a3443af3aed34cadc825dd/logging-in-python-image2.png)
  * > In addition to the above basic info, you may also want to record the timestamp at which a particular message was logged to make it easier when examining the logs. You can do this by specifying the `format` parameter in the constructor, as shown below.
    ```py
    logging.basicConfig(level=logging.INFO, filename="py_log.log",filemode="w",
                        format="%(asctime)s %(levelname)s %(message)s")
    logging.debug("A DEBUG Message")
    logging.info("An INFO")
    logging.warning("A WARNING")
    logging.error("An ERROR")
    logging.critical("A message of CRITICAL severity")
    ```
    > ![](https://images.ctfassets.net/em6l9zw4tzag/5oI11PNdFgUvltVuZP5hY0/65c21a1019c4e222616efcc1e18e28cf/logging-in-python-image6.png)
  * > There are many other [log record attributes](https://docs.python.org/3/library/logging.html#logrecord-attributes) you can use to customize the way the messages appear in the log file. While setting up the `root` logger as explained above, ***please be sure to run `logging.basicConfig()` only once*** — typically at the beginning of the program before logging. Subsequent calls do not change anything unless you set the parameter `force` to `True`.
- > **Logging Variables and Exceptions in Python**
  * > Now, let’s modify the `main.py` file. Say, there are two variables x and y, and we’d like to compute the value of x/y. We know that we’ll run into `ZeroDivisionError` when y = 0. We can handle this as an exception using the `try` and `except` blocks.
  * > Next, we’d like to ***log the exception along with the stack trace***. To do this, you can use `logging.error(message, exc_info=True)`. Run the following code to see that the values of variables and the result are logged as `INFO`, indicating that the code works as expected.
    ```py
    x = 3
    y = 4
    logging.info(f"The values of x and y are {x} and {y}.")
    try:
        x/y
        logging.info(f"x/y successful with result: {x/y}.")
    except ZeroDivisionError as err:
        logging.error("ZeroDivisionError",exc_info=True)
    ```
    > ![](https://images.ctfassets.net/em6l9zw4tzag/8uX8FPmGot9BoZvcVgpfi/91e81bfdfca01fd08f52acdf733f79de/logging-in-python-image5.png)
  * > Next, set the value of y to zero and run the module again. When you examine the log file `pylog.log`, you can see that ***an exception has been recorded along with the stack trace***.
    ```py
    x = 4
    y = 0
    logging.info(f"The values of x and y are {x} and {y}.")
    try:
        x/y
        logging.info(f"x/y successful with result: {x/y}.")
    except ZeroDivisionError as err:
        logging.error("ZeroDivisionError",exc_info=True)
    ```
    >> 【[:star:][`*`]】 //notes：也可以结合 `traceback` 库里的一些方法，比如下面两种：
      ```py
      except Exception as e:
          traceback.print_exc()
          my_top_logger.error("[var1:{}] [var2:{}] in this position we catch exception: {}".format(var1, var2, e.with_traceback))

      ```
      ```py
      except Exception:
          err_msg = str(traceback.format_exc())
          my_top_logger.error("your module: get 500 %s", err_msg)
      ```
    > ![](https://images.ctfassets.net/em6l9zw4tzag/7C47YmUsyGNC8HSLXsOaaW/c433a4a30f80767df4cb1a3e07c56b54/logging-in-python-image9.png)
  * > As a next step, let’s modify our code to have a list of x and y values for which we’d like to compute the quotient x/y. To log an exception, you can also use `logging.exception(<message>)`.
    ```py
    x_vals = [2,3,6,4,10]
    y_vals = [5,7,12,0,1]
    for x_val,y_val in zip(x_vals,y_vals):
        x,y = x_val,y_val
        logging.info(f"The values of x and y are {x} and {y}.")
        try:
            x/y
            logging.info(f"x/y successful with result: {x/y}.")
        except ZeroDivisionError as err:
            logging.exception("ZeroDivisionError")
    ```
    > Upon running the above code, you’ll see that the log file now contains information on those events when the execution was successful as well as the error when the exception occurred. <br> ![](https://images.ctfassets.net/em6l9zw4tzag/4s0fWlp7YWsr4tAP571KPC/265b2967991a65ba8a6448e7f4ecb229/logging-in-python-image11.png)
- > **Customizing Logging with Custom Loggers, Handlers, and Formatters**
  * > Next, let’s refactor the existing code. We’ll define a separate function `test_division`.
    ```py
    def test_division(x,y):
        try:
            x/y
            logger2.info(f"x/y successful with result: {x/y}.")
        except ZeroDivisionError as err:
            logger2.exception("ZeroDivisionError")
    ```
    > We’ll have the above function definition inside the `test_div` module. In the `main` module, we’ll only have the function calls. Let’s configure custom loggers in both the `main` and the `test_div` modules.
  * > ▶️ Configuring a custom logger for the `test_div` module
    ```py
    import logging

    logger2 = logging.getLogger(__name__)
    logger2.setLevel(logging.INFO)

    # configure the handler and formatter for logger2
    handler2 = logging.FileHandler(f"{__name__}.log", mode='w')
    formatter2 = logging.Formatter("%(name)s %(asctime)s %(levelname)s %(message)s")

    # add formatter to the handler
    handler2.setFormatter(formatter2)
    # add handler to the logger
    logger2.addHandler(handler2)

    logger2.info(f"Testing the custom logger for module {__name__}...")

    def test_division(x,y):
        try:
            x/y
            logger2.info(f"x/y successful with result: {x/y}.")
        except ZeroDivisionError as err:
            logger2.exception("ZeroDivisionError") 
    ```
  * > ▶️ Configuring a custom logger for the `main` module
    ```py
    import logging
    from test_div import test_division 

    # get a custom logger & set the logging level
    py_logger = logging.getLogger(__name__)
    py_logger.setLevel(logging.INFO)

    # configure the handler and formatter as needed
    py_handler = logging.FileHandler(f"{__name__}.log", mode='w')
    py_formatter = logging.Formatter("%(name)s %(asctime)s %(levelname)s %(message)s")

    # add formatter to the handler
    py_handler.setFormatter(py_formatter)
    # add handler to the logger
    py_logger.addHandler(py_handler)

    py_logger.info(f"Testing the custom logger for module {__name__}...")

    x_vals = [2,3,6,4,10]
    y_vals = [5,7,12,0,1]

    for x_val,y_val in zip(x_vals,y_vals):
        x,y = x_val, y_val
        # call test_division
        test_division(x,y)
        py_logger.info(f"Call test_division with args {x} and {y}")
    ```
  * > Let’s parse what the above code for configuring custom loggers does.
  * > As a first step, we set up the logger and the logging level. `logging.getLogger(name)` returns the logger with that name, if it exists; else, it creates ***the `name` logger***. In practice, you’ll set the name of the logger to the special variable `__name__`, which corresponds to the name of the module. We assign the logger object to a variable. We then set the desired logging level using `logging.setLevel(level)`.
  * > Next, we configure a handler. As we’d like to log events to a file, we configure a `FileHandler`. `logging.FileHandler(filename)` returns a file handler object. In addition to the name of the log file, you may optionally specify the mode. In this example, we set the mode to write. ***There are other handlers such as `StreamHandler`, `HTTPHandler`, `SMTPHandler`, and more***.
  * > We then create a formatter object using the syntax: `logging.Formatter(format)`. In this example, we place `%(names)s`, the name of the logger (a string), before the log record format we had earlier.
  * > Next, we add the formatter to the handler using `<handler>.setFormatter(<formatter>)`. Finally, we add the handler to the logger object using `<logger>.addHandler(<handler>)`.
  * > You can then run the `main` module and examine the generated log files.
  * > ![](https://images.ctfassets.net/em6l9zw4tzag/698JzSRblC9VqV8zq6MBP9/92493c5fd3da93119933a9fe89eb94c9/logging-in-python-image12.png)
  * > ![](https://images.ctfassets.net/em6l9zw4tzag/4WHxTgcvlXErTuRoQPSj0v/bcfaf38fbfd83dd074776e26502e34e3/logging-in-python-image10.png)
    >> 【[:star:][`*`]】 //notes：也可以定义一个全局的 my_top_logger，然后各个（想集中记日志的）模块都 import 这个 my_top_logger，并且把想记的内容都用它来记。***这样就能达到不同module的日志聚合到一个文件里的效果***。
- > **Python Logging: Best Practices**
  * > So far, we’ve covered how to log variables, exceptions, and set up custom loggers. Next, let’s enumerate some of the best practices for logging.
    + > **Set the optimal logging level**: Logs are helpful only when you can use them to track down important errors that need to be fixed. Depending on the specific application, be sure to set the optimal logging level. Logging too many events can be suboptimal from a debugging viewpoint as it’s difficult to filter through the logs to identify errors that require immediate attention.
    + > **Configure loggers at the module level**: When you’re working on an application with multiple modules, you should consider configuring a logger for each module. Setting the name of the logger to `__name__` helps identify the modules in your application that have issues you need to fix.
    + > **Include timestamps and ensure consistent formatting**: Always include timestamps in logs as they’re helpful in tracing back to when an error occurred. Format your logs consistently across the different modules in your application.
    + > **Rotate the log files to facilitate easier debugging**: When working on large applications with several modules, it’s likely that your log files will be very large in size. As it’s challenging to filter through such large logs to detect errors, you should consider rotating the log files. You can do this by using the `RotatingFileHandler` with the syntax: `logging.handlers.RotatingFileHandler(filename, maxBytes,backupCount)`. When the current log file reaches the size `maxBytes`, the subsequent logs roll over to the next files depending on the value of `backupCount`. If you set the `backupCount` to K, you get K back-up files.

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
