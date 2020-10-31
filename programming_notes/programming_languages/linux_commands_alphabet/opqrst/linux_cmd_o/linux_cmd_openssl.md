
# 源头

# 相关命令

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

# 个人实战

Encrypt files using AES with OPENSSL https://medium.com/@kekayan/encrypt-files-using-aes-with-openssl-dabb86d5b748
- > **Now is the time to encrypt our image**
  >> `openssl enc -aes-256-cbc -pass pass:kekayan -p -in image.png -out file.enc`
- >
  ```console
  -aes-256-cbc  ——  the cipher name( symmetric cipher : AES ;block to stream conversion : CBC(cipher block chaining))
  -pass pass:<password>  ——  to specify the password (here password is kekayan)
  -P  ——  Print out the salt, key and IV used.
  -in file  ——  input file /input file absolute path(here image.png)
  -out file  ——  output file /output file absolute path(here file.enc)
  ```
  ```sh
  [root@oprinstall1-inf test]# openssl enc -aes-256-cbc -pass pass:kekayan -p -in image.png -out file.enc
  *** WARNING : deprecated key derivation used.
  Using -iter or -pbkdf2 would be better.
  salt=02E6736FDAD2CAC5
  key=B55FB392901358B2BD65C61236DF3F0D21AAA08C1CDC1CE7024BADDF2C56E203
  iv =B00097F383609E73EF2C5F9376ACD4ED
  [root@oprinstall1-inf test]#
  ```
- > **Let’s Decrypt the encrypted image**
  >> `openssl enc -aes-256-cbc -pass pass:kekayan -d -in file.enc -out img_new.png -P`
  >>> //notes：这里还真就是大写的P，前面也确实是小写的p，看来大小写一样。后来`openssl help enc`查了下，基本差不多。大写P是print完exit。
  ```sh
  [root@oprinstall1-inf test]# openssl enc -aes-256-cbc -pass pass:kekayan -d -in file.enc -out img_new.png -P
  *** WARNING : deprecated key derivation used.
  Using -iter or -pbkdf2 would be better.
  salt=02E6736FDAD2CAC5
  key=B55FB392901358B2BD65C61236DF3F0D21AAA08C1CDC1CE7024BADDF2C56E203
  iv =B00097F383609E73EF2C5F9376ACD4ED
  [root@oprinstall1-inf test]#
  ```
- > While working with AES encryption I encountered the situation where the encoder sometimes produces base 64 encoded data with or without line breaks.To solve this simply add `-A`
  >> `openssl enc -aes-256-cbc -pass pass:kekayan -d -A -in file.enc -out img_new.png -p`
- > **Let’s do without specify password flag**
  >> //notes：这种情况会弹出提示（说白了就是非交互式变交互式）让你输入一个encryption password，不再贴了。
- > 
