
OrioleDB https://github.com/orioledb/orioledb
- > OrioleDB – building a modern cloud-native storage engine (... and solving some PostgreSQL wicked problems)

Postgres WASM https://github.com/snaplet/postgres-wasm
- > A PostgreSQL server instance running in a virtual machine running in the browser
- > **Quickstart**
  ```terminal
  cd packages/runtime && npx serve
  ```
  > Go to http://localhost:3000 and have fun!
- > **Acknowledgements**
  * > [v86](https://github.com/copy/v86) which is **the** emulator for running x86 operating systems in the browser, without it none of the following projects would be possible
  * > [crunchydata playground](https://www.crunchydata.com/developers/playground) for leading the way and showing the world that it was possible to run PostgreSQL in the browser
  * > [browser-shell](https://github.com/humphd/browser-shell) which was already way ahead of its time, especially on the filesystem part
  * > [browser-linux](https://github.com/Darin755/browser-linux) for showing us how we can make the pieces fit together
  * > [Websockets Proxy](https://github.com/benjamincburns/websockproxy) the ingenious workaround that opened up the world for **v86** emulators everywhere
