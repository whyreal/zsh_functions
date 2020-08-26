# 环境变量 {{{1
# history
export HISTSIZE=5000
export HISTFILESIZE=50000
# WORDCHARS
export WORDCHARS='*?_-[]~=&;!#$%^(){}<>'
# editor
export EDITOR='nvim'
# pager
#export PAGER='bat'
# use vim as man pager
export MANPAGER="command vim -c 'MANPAGER' -c 'set fdm=indent ts=7 sw=7' -"

export LC_ALL="en_US.UTF-8"
#export LC_ALL="zh_CN.GB2312"
if [[ $LC_CTYPE = "zh_CN.eucCN" ]]; then
    export NLS_LANG=AMERICAN_AMERICA.ZHS16GBK
fi

# golang
export PATH=$PATH:$HOME/go/bin/
export GOPATH=/Users/Real/go
export GO111MODULE=on # Enable the go modules feature
export GOPROXY=https://goproxy.cn #Set the GOPROXY environment variable

# java
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_251.jdk/Contents/Home/
#export PATH=$JAVA_HOME/bin:$PATH
#export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
#export GRAALVM_HOME=/Library/Java/JavaVirtualMachines/graalvm-ce-1.0.0-rc14/Contents/Home

# Maven
export PATH=/usr/local/apache-maven-3.6.3/bin/:$PATH

export PATH=$PATH:$HOME/Documents/Note/scripts/
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/opt/mysql-client/bin
export PATH=$PATH:$HOME/.yarn/bin
export PATH=$PATH:$HOME/.config/yarn/global/node_modules/.bin
export PATH=$PATH:/Applications/instantclient_18_1

# Python
#export PATH=/Users/Real/Library/Python/3.7/bin:$PATH

# fzf
export FZF_DEFAULT_COMMAND='fd -i -H -L --type f'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# }}}
# Alias {{{1
# open
alias r='open -R'
#alias o='openfile'
alias o='open'
alias o.serverlist='open ~/Documents/zkzy/Implementation-doc/中科智云内部环境说明/虚拟机和宿主机分布情况说明.xlsx'
alias o.dblist='open ~/Documents/zkzy/Implementation-doc/中科智云内部环境说明/database_info.xlsx'
alias o.docs='cd ~/Documents/vim-workspace/docs/ && vim'
alias drawio='open -a draw.io.app'

alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'

alias z='_zlua -I'
alias pwgen='pwgen -r0oOiIlL'
alias grep='grep --color'
#alias tr='tmux -u attach'
alias s='sshrc'
alias ssh-with-password='ssh -F /dev/null -o "PreferredAuthentications=keyboard-interactive,password"'
alias vim='nvim'
alias mysql='mysql --default-auth=mysql_native_password'
alias mysql8='command mysql'
alias tl='python3 ~/code/translator/translator.py'
alias ldd='otool -L'
alias secp='copy_remote_screen_message_content_to_local_clipboard'

# }}}
# Functions {{{1
#openfile() {
     #file=$1
     #long_ext=`echo $file | awk -F\. '{print $(NF-1)"."$NF}'`
     #mime_type="${$(file --mime-type $file | awk '{print $2}')%/*}"

     #if [[ $mime_type = 'text' ]]; then
         ##vim $file
         #code $file
     #else
         #open $file
     #fi
#}
copy_remote_screen_exchange_content_to_local_clipboard(){ # {{{2
    ssh $1 cat /tmp/screen-exchange | pbcopy
}
# }}}
favorite.docs(){ # {{{2
    abs_path=`greadlink -f $1`
    cd ~/Documents/vim-workspace/docs/ && ln -s $abs_path ./$2
}
# }}}
vs(){ # {{{2
    mvim -n \
        -c "let w:remote_host=\"$1\"" \
        -c "let &titlestring=w:remote_host" \
        -c "Edit /root/" \
        -c "new" -c "ServerUpdateInfo"
    sshrc $1
}
# }}}
vpn.route.add.zkzy() { # {{{2
    sudo route -n add 192.168.80/24 -interface ppp0
}
# }}}
vpn.route.del.zkzy() { # {{{2
    sudo route -n delete 192.168.80/24 -interface ppp0
}
# }}}
safari.agent.ipad() { # {{{2
    defaults write com.apple.Safari CustomUserAgent "'Mozilla/5.0 (iPad; CPU OS 5_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9B176 Safari/7534.48.3'"
}
# }}}
safari.agent.default() { # {{{2
    defaults delete com.apple.Safari CustomUserAgent
}
# }}}
proxy.ss.active(){ # {{{2
    export http_proxy="http://127.0.0.1:1087"
    export https_proxy="http://127.0.0.1:1087"
}
# }}}
proxy.ss.deactive(){ # {{{2
    export http_proxy=""
    export https_proxy=""
}
# }}}
oracle.env.gb2312(){ # {{{2
	echo export NLS_LANG=AMERICAN_AMERICA.ZHS16GBK
}
# }}}
color.print(){    #{{{2
    for C in {40..47}; do
        echo -en "\e[${C}m$C "
    done

    # high intensity colors
    for C in {100..107}; do
        echo -en "\e[${C}m$C "
    done

    # 256 colors https://en.wikipedia.org/wiki/ANSI_escape_code#24-bit
    for C in {16..255}; do
        echo -en "\e[48;5;${C}m$C "
    done

    echo -e "\e(B\e[m"
}
#}}}
color.print.tput(){ #{{{2
    for C in {0..255}; do
        tput setab $C
        echo -n "$C "
    done
    tput sgr0
}
alias telnet='nc -vz -w 1'
#}}}
ssh.execute_local_script() { # {{{2
    if [[ $1 == "" ]]; then
        echo "$0 host script"
        return 1
    fi
    h=$1
    s=$2
    cat $2 | ssh -T $1
}
# }}}
# }}}

# vim: fdm=marker sw=4 ts=4 et ft=zsh
