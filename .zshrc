# PLUGIN OH MY ZSH
plugins=(git vi-mode)

# ALIASES
# general aliases
alias zshconfig="nvim ~/.zshrc"
# eza aliases
alias ls="eza --icons"
alias ll="eza -l --icons --git"
alias la="eza -la --icons --git"
alias lt="eza --tree --level=2 --icons"
alias l="eza -lah --icons --git --group-directories-first"
# bat aliases
alias cat="bat"

# PART FOR ANDROID EMULATOR ON MAC
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin

# ACTIVATE FZF
source <(fzf --zsh)

# SYMFONY AUTOCOMPLETION?

