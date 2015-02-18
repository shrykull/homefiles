##
# Autoload
##
autoload -Uz compinit colors vcs_info
compinit
colors

##
# VCS info
##
zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn

##
# Run before each prompt
##
precmd () {
  vcs_info
  # Show pwd in title
  tab_label=${PWD/${HOME}/\~} # use 'relative' path
  echo -ne "\e]2;${tab_label}\a" # set window title to full string
  echo -ne "\e]1;${tab_label: -24}\a" # set tab title to rightmost 24 characters
}

##
# Prompt
##
setopt prompt_subst

fg[lightgreen]=$'\e[1;32m'
fg[lightblue]=$'\e[1;34m'
PROMPT="%{$fg[lightgreen]%}%n@%m %{$fg[lightblue]%}%~ %{$reset_color%}"$'\n'"%# "
RPROMPT='${vcs_info_msg_0_}'

##
# Key Bindings
##
#bindkey -v                                # vim keybindings
bindkey '\e[1;5C' forward-word            # C-Right
bindkey '\e[1;5D' backward-word           # C-Left
bindkey '\e[3~'   delete-char             # Del
bindkey '^[[H'    beginning-of-line       # Pos1
bindkey '^[[F'    end-of-line             # End
bindkey '^R' history-incremental-search-backward

##
# Completion
##
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/gsteinmetz/.zshrc'

# setopt menucomplete # show completion on first tab

##
# History
##
HISTFILE=~/.histfile            # where to store zsh config
HISTSIZE=1000                   # Should be enough
SAVEHIST=1000                   # Should be enough
setopt hist_ignore_all_dups     # no duplicate
setopt append_history           # append
unsetopt hist_ignore_space      # ignore space prefixed commands
setopt hist_reduce_blanks       # trim blanks
setopt inc_append_history       # add commands as they are typed, don't wait until shell exit
setopt share_history            # share hist between sessions

##
# Aliases
##
if [ -f "${HOME}/.aliases" ]; then
  source "${HOME}/.aliases"
fi