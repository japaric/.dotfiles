# oh-my-zsh
ZSH=~/.dotfiles/oh-my-zsh

plugins=(
  colored-man
  extract
  git
  systemd
  tmux
  vi-mode
  zsh-syntax-highlighting
)

# cargo autocompletion
command -v multirust >/dev/null 2>&1 && \
  fpath=( $(rustc --print sysroot)/share/zsh/site-functions $fpath )

source $ZSH/oh-my-zsh.sh

# pure prompt
fpath=( "$HOME/.zfunctions" $fpath )
autoload -U promptinit && promptinit
prompt pure

# base16-shell
BASE16_SHELL="$HOME/.dotfiles/base16-shell/base16-chalk.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
unset $BASE16_SHELL

# "partial" history search
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

# stolen from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
    zle redisplay
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# aliases
alias df='df -h'
alias dmesg='dmesg -H'
command -v colordiff >/dev/null 2>&1 && alias diff='colordiff'

# env
EDITOR=vim

PATH="$PATH:$HOME/.dotfiles/scripts"
PATH="$PATH:$HOME/.dotfiles/shims"
PATH="$PATH:$(rustc --print sysroot)/cargo/bin"
PATH="$PATH:$HOME/.rbenv/bin"

if [ -d ~/openwrt/current ]; then
  toolchain=$(find ~/openwrt/current/ -maxdepth 1 -name 'toolchain*' -print -quit)
  if [ ! -z $toolchain ]; then
    PATH="$PATH:$toolchain/bin"
    export STAGING_DIR=~/openwrt/current
  fi
  unset toolchain
fi

command -v hub >/dev/null 2>&1 && eval "$(hub alias -s)"
command -v rbenv >/dev/null 2>&1 && eval "$(rbenv init -)"
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

true
