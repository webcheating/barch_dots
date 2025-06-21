# ~/.bashrc
# colors
# to check all colors:
# for i in {0..255}; do echo -e "\e[38;5;${i}mColor ${i}\e[0m"; done
light_grey="$(tput bold; tput setaf 7)" # red 160 # grey-white 7 # white 15
white="$(tput bold; tput setaf 15)"
dark_red="$(tput bold; tput setaf 160)"
nc="$(tput sgr0)"


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH="$PATH:/home/user0o1/.local/share/gem/ruby/3.4.0/bin"
#alias startx='startx --'
PS1="\[$dark_red\][ \[$light_grey\]\u@**** \[$light_grey\]\w\[$light_grey\] \[$dark_red\]]\\[$light_grey\]$ \[$nc\]"

use() {
  if [ -n "$1" ]; then
    tmux new-session -s "$1"
  else
    if [ -n "$TMUX" ]; then
      tmux choose-tree -s
    else
      if tmux ls >/dev/null 2>&1; then
        tmux attach \; choose-tree -s
      else
        tmux
      fi
    fi
  fi
}

alias vim=nvim
alias vi=vim
alias svim='sudo nvim'
alias l='ls -la --color=auto'
alias ls='ls --color=auto'
alias sl='ls'
alias grep='grep --color=auto'

alias fix='stty raw -echo;fg'
alias work='cd ~/hack/web && ls'
alias htb='cd ~/hack/htb && ls'
alias thm='cd ~/hack/thm && ls'
alias ad='cd ~/tools/active_directory'
alias lin='cd ~/tools/lin'
alias web='cd ~/tools/web'
alias crack='cd ~/tools/cracking'

#PS1='[\u@\h \W]\$ '
#PS1="\[$blue\][ \[$cyan\]\H \[$darkgrey\]\w\[$darkgrey\] \[$blue\]]\\[$darkgrey\]$ \[$nc\]"
#PS1="root@jane:~# "

eval "$(direnv hook bash)"
# Created by `pipx` on 2025-01-08 19:43:03
#export PATH="$PATH:/home/user0o1/.local/bin:/home/user0o1/.local/share/gem/ruby/3.3.0/bin:/home/user0o1/go/bin"
#export PATH="$PATH:/home/user0o1/.cargo/bin:/home/user0o1/.local/bin:/home/user0o1/go/bin:/home/user0o1/.local/share/gem/ruby/3.4.0/bin"

#### PROXY SETTINGS ####

#export ALL_PROXY="socks5h://<login>:<pass>@<ip>:<port>"
#export http_proxy="socks5h://<login>:<pass>@<ip>:<port>"
#export https_proxy="socks5h://<login>:<pass>@<ip>:<port>"
#export ftp_proxy="socks5h://<login>:<pass>@<ip>:<port>"

#export ALL_PROXY="http://<login>:<pass>@<ip>:<port>"
#export http_proxy="http://<login>:<pass>@<ip>:<port>"
#export https_proxy="http://<login>:<pass>@<ip>:<port>"
#export ftp_proxy="http://<login>:<pass>@<ip>:<port>"
