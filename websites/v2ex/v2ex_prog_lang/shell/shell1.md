
aa=$(echo a)， aa=`echo a` 有什么区别？ https://www.v2ex.com/t/799826
- > https://stackoverflow.com/questions/9449778/what-is-the-benefit-of-using-instead-of-backticks-in-shell-scripts
- > 我记得 shell check 里是推荐的用前一种代替后一种
- > 后者不能嵌套
- > 用 shellcheck 检查，会提示违背了哪种规范
- > 后者在某些环境上无法正常使用.
- > 不用管区别，只用前者
