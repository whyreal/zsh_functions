# 环境变量 {{{1
# history
export HISTSIZE=5000
export HISTFILESIZE=50000
# WORDCHARS
#export WORDCHARS='-*?_[]~=&;!#$%^(){}'
# editor
export EDITOR='code'
# pager
#export PAGER='bat'
# use vim as man pager
export MANPAGER="vim -c 'MANPAGER' -c 'set fdm=indent ts=7 sw=7' -"

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

export PATH=$PATH:/Users/Real/Documents/Note/scripts/
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/opt/mysql-client/bin
export PATH=$PATH:$HOME/.yarn/bin
export PATH=$PATH:$HOME/.config/yarn/global/node_modules/.bin
export PATH=$PATH:/Applications/instantclient_18_1

# Python
export PATH=/Users/Real/Library/Python/3.7/bin:$PATH
# }}}
# Alias {{{1
alias z='_zlua -I'
alias pwgen='pwgen -r0oOiIlL'
alias grep='grep --color'
alias tr='tmux -u attach'
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'
alias s='sshrc'
alias r='open -R'
alias vim='nvim'
alias vi='nvim -u /dev/null'
alias o='openfile'
alias secp='copy_remote_screen_message_content_to_local_clipboard'
# }}}
# Functions {{{1

copy_remote_screen_exchange_content_to_local_clipboard(){ # {{{2
    ssh $1 cat /tmp/screen-exchange | pbcopy
}
# }}}
favorite.docs(){ # {{{2
    abs_path=`greadlink -f $1`
    cd ~/Documents/vim-workspace/docs/ && ln -s $abs_path ./$2
}
# }}}
openfile(){ # {{{2

    file=$1
    mime_type="${$(file --mime-type $file | awk '{print $2}')%/*}"

    if [[ $mime_type = 'text' ]]; then
        #vim $file
        $EDITOR $file
    else
        open $file
    fi
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
update.all() { # {{{2

    echo "-------- update antigen--------"
    antigen update

    echo "-------- update tmux--------"
    /Users/Real/.tmux/plugins/tpm/bin/update_plugins all

    echo "-------- update homebrew--------"
    brew upgrade
    brew cleanup

    echo "-------- update Coc--------"
    vim -c 'PlugUpdate | CocUpdateSync | qall'
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
ssh.excute_local_script() { # {{{2
    h=$1
    s=$2
    cat $2 | ssh -T $1
}
# }}}
# }}}

# vim: fdm=marker sw=4 ts=4 et ft=zsh
