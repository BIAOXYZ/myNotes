
####################################################################################################
# setting
set nu

####################################################################################################
# alias
alias ..="cd .."

####################################################################################################
# export

## 将 `sh -x ${scriptname}`打印的+号增加行号，函数名等信息，从而方便调试shell脚本。
## 注意LINENO和FUNCNAME前的dollar符号，github显示不出来。我试试加斜杠转义下看看。
export PS4='+{$LINENO:${FUNCNAME[0]}} '

export PS4='+{\$LINENO:\${FUNCNAME[0]}} '

####################################################################################################
# git

## git branch color 1

function parse_git_branch_and_add_brackets {
git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \{\1\}/'
}
PS1="\u@\h:\033[1;33m\]\W\[\033[1;32m\]\$(parse_git_branch_and_add_brackets)\[\033[0m\]\> "

## git branch color 2

function git-branch-name {
  git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3
}
function git-branch-prompt {
  local branch=`git-branch-name`
  if [ $branch ]; then printf " [%s]" $branch; fi
}
PS1="\u@\h \[\033[0;36m\]\W\[\033[0m\]\[\033[0;32m\]\$(git-branch-prompt)\[\033[0m\] \$ "

## git branch color 3

parse_git_branch() {
git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}
export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

## git auto completion
source ~/.git-completion.bash
