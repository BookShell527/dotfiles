#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias dartfmt='dart format'
PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"
