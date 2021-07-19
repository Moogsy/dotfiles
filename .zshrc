# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Vars
export FONTCONFIG_PATH=/etc/fonts
export EDITOR='/usr/bin/nvim'

# Created by newuser for 5.8
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export TERM=alacritty

#################
# GENERAL STUFF #
#################

# Speedy connect to stuff
alias wifi='iwctl station wlan0'
alias bt='bluetoothctl'

# Speed exit
alias q='exit'
alias cls='clear'

# Haha yes
alias zshrc='nvim ~/.zshrc; source ~/.zshrc'
alias nvimrc='nvim ~/.config/nvim/init.vim'
alias vimrc='vim ~/.vimrc'
alias ls='lsd'

###############
# SSH IS NICE #
###############

#############
# UTILITIES #
#############
alias feh='feh .; q'

#######################
# PROGRAMMING IS COOL #
#######################

# Speed editors
alias nv='nvim'
alias vscode='code .; q'

# Snakes
alias py='python'
alias ipy='ipython'

# Rust is fast
alias cdoc='cargo doc --open --package'
alias c='cargo'
