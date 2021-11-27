export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="spaceship"
DISABLE_AUTO_UPDATE="true"
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-completions
)

source $ZSH/oh-my-zsh.sh

zshcache_time="$(date +%s%N)"

autoload -Uz add-zsh-hook

rehash_precmd() {
  if [[ -a /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}

add-zsh-hook -Uz precmd rehash_precmd

alias l='ls -lh'
alias ll='ls -lah'
alias la='ls -A'
alias lm='ls -m'
alias lr='ls -R'
alias lg='ls -l --group-directories-first'
alias lf='lfrun'
alias neo='neofetch'
alias pcc='sudo pacman -R $(pacman -Qqtd)'
alias p="pfetch | sed 's/Type1ProductConfigId//g' | sed 's/Archcraft/Arch/g'"
alias u='paru -Syu'
alias vim='lvim'
alias code='vscodium'
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias gtgr='git log --all --decorate --oneline --graph'
alias gtlg='git log'
alias gtst='git status'
alias dartfmt='dart format'

export _JAVA_AWT_WM_NONREPARENTING=1
export CHROME_EXECUTABLE=/usr/bin/chromium
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export ANDROID_HOME=$HOME/Android/Sdk
#export PATH=$PATH:$HOME/.emacs.d/bin:$HOME/.local/bin:$HOME/.pub-cache/bin:$HOME/Application/dart-sdk/bin:$HOME/Application/flutter/bin
export EDITOR="lvim"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
