
# 源头

# 相关命令

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

# 个人实战

Encrypt files using AES with OPENSSL https://medium.com/@kekayan/encrypt-files-using-aes-with-openssl-dabb86d5b748
- > The list of supported ciphers can be viewed using following command: `openssl list-cipher-commands`
  >> //notes：但是从我机器上看，至少在2019.5.28这个版本，这个参数已经废弃了。不过直接用`openssl help`能看的比这个全。
  ```sh
  [root@oprinstall1-inf test]# openssl list-cipher-commands
  Invalid command 'list-cipher-commands'; type "help" for a list.
  [root@oprinstall1-inf test]#
  [root@oprinstall1-inf test]# openssl version
  OpenSSL 1.1.1c FIPS  28 May 2019
  [root@oprinstall1-inf test]#
  [root@oprinstall1-inf test]# openssl help
  Standard commands
  asn1parse         ca                ciphers           cms
  crl               crl2pkcs7         dgst              dhparam
  dsa               dsaparam          ec                ecparam
  enc               engine            errstr            gendsa
  genpkey           genrsa            help              list
  nseq              ocsp              passwd            pkcs12
  pkcs7             pkcs8             pkey              pkeyparam
  pkeyutl           prime             rand              rehash
  req               rsa               rsautl            s_client
  s_server          s_time            sess_id           smime
  speed             spkac             srp               storeutl
  ts                verify            version           x509

  Message Digest commands (see the `dgst' command for more details)
  blake2b512        blake2s256        gost              md2
  md4               md5               rmd160            sha1
  sha224            sha256            sha3-224          sha3-256
  sha3-384          sha3-512          sha384            sha512
  sha512-224        sha512-256        shake128          shake256
  sm3

  Cipher commands (see the `enc' command for more details)
  aes-128-cbc       aes-128-ecb       aes-192-cbc       aes-192-ecb
  aes-256-cbc       aes-256-ecb       aria-128-cbc      aria-128-cfb
  aria-128-cfb1     aria-128-cfb8     aria-128-ctr      aria-128-ecb
  aria-128-ofb      aria-192-cbc      aria-192-cfb      aria-192-cfb1
  aria-192-cfb8     aria-192-ctr      aria-192-ecb      aria-192-ofb
  aria-256-cbc      aria-256-cfb      aria-256-cfb1     aria-256-cfb8
  aria-256-ctr      aria-256-ecb      aria-256-ofb      base64
  bf                bf-cbc            bf-cfb            bf-ecb
  bf-ofb            camellia-128-cbc  camellia-128-ecb  camellia-192-cbc
  camellia-192-ecb  camellia-256-cbc  camellia-256-ecb  cast
  cast-cbc          cast5-cbc         cast5-cfb         cast5-ecb
  cast5-ofb         des               des-cbc           des-cfb
  des-ecb           des-ede           des-ede-cbc       des-ede-cfb
  des-ede-ofb       des-ede3          des-ede3-cbc      des-ede3-cfb
  des-ede3-ofb      des-ofb           des3              desx
  idea              idea-cbc          idea-cfb          idea-ecb
  idea-ofb          rc2               rc2-40-cbc        rc2-64-cbc
  rc2-cbc           rc2-cfb           rc2-ecb           rc2-ofb
  rc4               rc4-40            rc5               rc5-cbc
  rc5-cfb           rc5-ecb           rc5-ofb           seed
  seed-cbc          seed-cfb          seed-ecb          seed-ofb
  zlib

  [root@oprinstall1-inf test]#
  ```
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
