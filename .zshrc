export EDITOR=micro

source $HOME/.aliasrc
source ~/.cache/wal/colors-tty.sh
source ~/.themerc
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/s0ra/.zshrc'
zstyle ':completion:*' menu select
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")';

autoload -Uz compinit
compinit
# End of lines added by compinstall
