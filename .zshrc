export EDITOR=micro

source $HOME/.aliasrc
source $HOME/.themerc
source $HOME/zsh-plugins/zsh-autosuggestions.zsh
source $HOME/zsh-plugins/zsh-syntax-highlighting.zsh
source $HOME/zsh-plugins/autopair.zsh && autopair-init

HISTFILE=$HOME/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

eq $TTY "/dev/tty1" && startx
eq $TERM "eterm-color" && bash
