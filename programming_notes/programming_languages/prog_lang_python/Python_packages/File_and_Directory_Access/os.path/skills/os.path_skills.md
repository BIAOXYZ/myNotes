
How to add pandas data to an existing csv file? https://stackoverflow.com/questions/17530542/how-to-add-pandas-data-to-an-existing-csv-file
- https://stackoverflow.com/questions/17530542/how-to-add-pandas-data-to-an-existing-csv-file/17975690#17975690
  * > You can specify a python write mode in the pandas [to_csv](http://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.to_csv.html) function. For append it is `'a'`.
  * > In your case:
    ```py
    df.to_csv('my_csv.csv', mode='a', header=False)
    ```
  * > The default mode is `'w'`.
  * > 【[:star:][`*`]】 If the file initially might be missing, you can make sure the header is printed at the first write using this variation:
    ```py
    output_path='my_csv.csv'
    df.to_csv(output_path, mode='a', header=not os.path.exists(output_path))
    ```
