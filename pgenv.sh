
# 1. Write this command (alias pp='source $HOME/bin/pgenv.sh') into ~/.bashrc
# 2. Use "pp 10/11/20" and so on to change PG environment variables

if [ ${#} -ne 1 ]; then
  echo "${0} ver"
else

SVNHOST=10.189.14.144
PG6SRC=$HOME/packages/postgresql-9.6.0
GAUSSSRC=$HOME/packages/GaussDB/postgres


export LC_ALL="en_US.UTF-8"
export JAVA_HOME="${HOME}/bin/jdk1.7.0_17"
export PS1="[\u@\h:\[\033[01;32m\]\w\[\033[00m\]]<\[\033[01;31m\]CurDB-$1\[\033[00m\]>\$"

export PGDATA=${HOME}/app/data/pg_root${1}
export LANG=en_US.utf8
export PGHOME=${HOME}/app/pgsql${1}
export LD_LIBRARY_PATH=${PGHOME}/lib
export DATE=`date +"%Y%m%d%H%M"`
export PATH=${HOME}/bin/node-linux/bin:${HOME}/bin/mongodb-linux-x86_64-suse11-3.2.7/bin:${PGHOME}/bin:${HOME}/bin:${HOME}/bin/jdk1.7.0_17/bin:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/X11R6/bin:/usr/games:/usr/lib64/jvm/jre/bin:/usr/lib/mit/bin:/usr/lib/mit/sbin:.:.
#export MANPATH=${PGHOME}/share/man:${MANPATH}
export PGHOST=127.0.0.1
export PGUSER=${USER}
export PGPASSWORD=gaussdb@123
export PGDATABASE=postgres

export GAUSSDATA=${PGDATA}
export GAUSSHOME=${PGHOME}


alias svndownc20="svn co 'http://$SVNHOST:6801/svn/CRDU_GAUSSDB_V100R003_SVN/GAUSSDB_V100R003C20/CODE/trunk/GaussDB'"
alias gda="gdb attach "
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias cdgsrc="cd $GAUSSSRC"
alias cdpg6src="cd $PG6SRC"
alias cddata="cd $PGDATA"
alias reinitpgdata="rm -rf $PGDATA;gs_initdb"

alias psta="pg_ctl start"
alias gsta="gs_ctl start"
alias psto="pg_ctl stop"
alias gsto="gs_ctl stop"







extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}

mkdb () {
        if [ $1 = "pg9.6" ];then
                echo "Begin configure & make & make install PostgreSQL9.6..."
                current_dir=`pwd`
                cd $PG6SRC
                chmod u+x ./configure > ./mkdb.log
                ./configure --prefix=/home/gaomingjie/bin/pgsql$2 --without-zlib --enable-debug --enable-cassert --enable-thread-safety CFLAGS='-O0' --with-pgport=84$2 --enable-depend CPPFLAGS='
-DLOCK_DEBUG' >> ./mkdb.log
                make -sj8 >> ./mkdb.log
                make install >> ./mkdb.log
                cd $current_dir
                echo "DONE!"
        elif [ $1 = "c20" ];then
                echo "Begin configure & make & make install GaussdbV100R003C20..."
                current_dir=`pwd`
                cd $GAUSSSRC
                chmod u+x ./configure > ./mkdb.log
                ./configure --prefix=/home/gaomingjie/bin/pgsql$2 --without-zlib --enable-debug --enable-cassert --enable-thread-safety CFLAGS='-O0' --with-pgport=84$2 --enable-depend CPPFLAGS='
-DLOCK_DEBUG' >> ./mkdb.log
                make -sj8 >> ./mkdb.log
                make install >> ./mkdb.log
                cd $current_dir
                echo "DONE!"
        fi
}

fi

