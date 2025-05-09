# zsh config

# Enable colors
autoload -U colors && colors
export CLICOLOR=1

# Set history size and file
export SAVEHIST=1000000000
export HISTSIZE=1000000000
export HISTFILE=~/.cache/zsh/history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY

if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Basic auto/tab complete:
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)

# Load pyenv
eval "$(pyenv init -)"

# Edit line in vim with ctrl-e:
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# begin of line
bindkey -e

# Load aliases file
[ -f "$HOME/.config/zsh/aliasrc" ] && source "$HOME/.config/zsh/aliasrc"

# Load fzf
source <(fzf --zsh)

# Allow for autocomplete to be case insensitive
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Initialize the autocompletion
autoload -Uz compinit && compinit -i

# Initialize direnv
eval "$(direnv hook zsh)"

# Set key bindings for sshw
bindkey -s J "sshw\n"

# Vi mode in ZSH
# bindkey -v

# Set key bindings for telescop
bindkey -s F "nvim -c 'lua require(\"telescope.builtin\").find_files { search_dirs = { \"~/work/\", \"~/dotfiles/\", \"~/workspace\" },hidden = true, file_ignore_patterns = { \".git/\" } }'\n"

# fzf catppuccin mocha
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

# Allow comments even in interactive shells.
set -k

# Load zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load zsh-syntax-highlighting theme
source ${HOME}/.config/plugins/zsh/catppuccin-zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh

# Load zsh-syntax-highlighting; should be last.
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"
