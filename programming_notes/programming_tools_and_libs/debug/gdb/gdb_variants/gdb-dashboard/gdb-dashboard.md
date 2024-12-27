
# 官方

GDB dashboard https://github.com/cyrus-and/gdb-dashboard
- > Just place `.gdbinit` in your home directory, for example with:
  ```sh
  wget -P ~ https://github.com/cyrus-and/gdb-dashboard/raw/master/.gdbinit
  ```
- > Optionally install `Pygments` to enable syntax highlighting:
  ```sh
  pip install pygments
  ```
- > Then debug as usual, the dashboard will appear automatically every time the inferior program stops.
- > Keep in mind that no GDB command has been redefined, instead all the features are available via the main `dashboard` command (see ***`help dashboard`***).

# 其他

https://x.com/dstreetdogg/status/1871937037143793916
```
A colorful and information loaded GDB dashboard for the terminal. This one tool really put the terminal based debugging to the next level for me. 
```
