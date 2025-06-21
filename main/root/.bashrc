# colors
darkgrey="$(tput bold; tput setaf 15)" # grey-white
white="$(tput bold; tput setaf 7)"
blue="$(tput bold; tput setaf 160)"
cyan="$(tput bold; tput setaf 160)"
nc="$(tput sgr0)"

# exports
export PATH="${HOME}/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/home/user0o1/go/bin:"
export PATH="${PATH}/usr/local/sbin:/opt/bin:/usr/bin/core_perl:/usr/games/bin:"
export PS1="\[$blue\][ \[$cyan\]\H \[$darkgrey\]\w\[$darkgrey\] \[$blue\]]\\[$darkgrey\]# \[$nc\]"
export LD_PRELOAD=""
export EDITOR="vim"

# alias
alias ls="ls --color"
alias vim=nvim
# alias vi=vim
alias shred="shred -zf"
#alias python="python2"
alias wget="wget -U 'noleak'"
alias curl="curl --user-agent 'noleak'"

# source files
[ -r /usr/share/bash-completion/completions ] &&
  . /usr/share/bash-completion/completions/*
