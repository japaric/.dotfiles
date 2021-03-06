# oh-my-zsh
ZSH=~/.dotfiles/oh-my-zsh

plugins=(
  colored-man
  extract
  git
  rust
  systemd
  vi-mode
  zsh-syntax-highlighting
)

command -v tmux >/dev/null 2>&1 && \
  plugins+=( tmux )

# cargo autocompletion
PATH="$HOME/.cargo/bin:$PATH"
command -v rustup >/dev/null 2>&1 && \
  fpath=( $(rustc --print sysroot)/share/zsh/site-functions $fpath )

source $ZSH/oh-my-zsh.sh

# pure prompt
fpath=( "$HOME/.zfunctions" $fpath )
autoload -U promptinit && promptinit
prompt pure

# base16-shell
BASE16_SHELL=$HOME/.dotfiles/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

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
EDITOR=edit

PATH="$PATH:$HOME/.dotfiles/scripts"

# for racer
export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src
export CARGO_HOME=~/.cargo

# for Rust
export RUST_NEW_ERROR_FORMAT=true

command -v hub >/dev/null 2>&1 && eval "$(hub alias -s)"
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

true
