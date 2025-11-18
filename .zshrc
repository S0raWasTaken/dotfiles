export EDITOR=micro
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export PATH="$PATH:/home/s0ra/.spicetify:\
/home/s0ra/.cargo/bin:\
/home/s0ra/.local/bin:\
/home/s0ra/.local/share/gem/ruby/3.4.0/bin"

source $HOME/.aliasrc
source $HOME/.themerc
source $HOME/.zsh_plugins/zsh-autosuggestions.zsh
source $HOME/.zsh_plugins/zsh-syntax-highlighting.zsh
source $HOME/.zsh_plugins/autopair.zsh && autopair-init

HISTFILE=$HOME/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

[ "$TERM" = "eterm-color" ] && bash
