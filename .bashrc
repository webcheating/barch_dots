# ~/.bashrc
# colors
darkgrey="$(tput bold; tput setaf 7)" # red 160 # grey-white 7 # white 15
white="$(tput bold; tput setaf 15)"
blue="$(tput bold; tput setaf 160)"
cyan="$(tput bold; tput setaf 7)"
nc="$(tput sgr0)"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#alias startx='startx --'

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
alias htb='cd ~/vpn/hackthebox && ls'
alias ad='cd ~/tools/active_directory'
alias lin='cd ~/tools/lin'
alias web='cd ~/tools/web'
alias crack='cd ~/tools/cracking'
alias work='cd ~/hacking/hackthebox'
alias l='ls -la --color=auto'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
#PS1='[\u@\h \W]\$ '
#PS1="\[$blue\][ \[$cyan\]\H \[$darkgrey\]\w\[$darkgrey\] \[$blue\]]\\[$darkgrey\]$ \[$nc\]"
PS1="\[$blue\][ \[$cyan\]\u@**** \[$darkgrey\]\w\[$darkgrey\] \[$blue\]]\\[$darkgrey\]$ \[$nc\]"

eval "$(direnv hook bash)"
# Created by `pipx` on 2025-01-08 19:43:03
#export PATH="$PATH:/home/user0o1/.local/bin:/home/user0o1/.local/share/gem/ruby/3.3.0/bin:/home/user0o1/go/bin"
export PATH="$PATH:/home/user0o1/.cargo/bin:/home/user0o1/.local/bin:/home/user0o1/go/bin"

alias vim=nvim
alias vi=vim

#### PROXY SETTINGS ####

#export ALL_PROXY="socks5h://JCu4VK7S:FEQheq6h@212.193.168.98:63165"
#export http_proxy="socks5h://JCu4VK7S:FEQheq6h@212.193.168.98:63165"
#export https_proxy="socks5h://JCu4VK7S:FEQheq6h@212.193.168.98:63165"
#export ftp_proxy="socks5h://JCu4VK7S:FEQheq6h@212.193.168.98:63165"

#export ALL_PROXY="http://JCu4VK7S:FEQheq6h@212.193.168.98:63164"
#export http_proxy="http://JCu4VK7S:FEQheq6h@212.193.168.98:63164"
#export https_proxy="http://JCu4VK7S:FEQheq6h@212.193.168.98:63164"
#export ftp_proxy="http://JCu4VK7S:FEQheq6h@212.193.168.98:63164"
