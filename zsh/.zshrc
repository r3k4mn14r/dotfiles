# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
autoload -U compinit; compinit

# ZSH settings
autoload -U colors && colors # Load Colors.
unsetopt case_glob           # Use Case-Insensitve Globbing.
setopt globdots              # Glob Dotfiles As Well.
setopt extendedglob          # Use Extended Globbing.
setopt brace_ccl             # Allow Brace Character Class List Expansion.
setopt long_list_jobs        # List Jobs In The Long Format By Default.
setopt notify                # Report Status Of Background Jobs Immediately.
setopt auto_param_slash      # If Completed Parameter Is A Directory, Add A Trailing Slash.

# set zstyles options
zstyle ':completion:*' completer _extensions _complete _approximate # Define completers
zstyle ':completion:*' use-cache on # Use cache for commands using cache
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':completion:*' complete true # Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' menu select
zstyle ':completion:*' complete-options true
zstyle ':completion:*' file-sort modification
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*' group-name '' # Required for completion to be in good groups (named after the tags)
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' keep-prefix true

# vi mode with jk map
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode

# editor settings
export EDITOR="vim"
export VISUAL="nvim"

# aliases
alias e="${(z)VISUAL:-${(z)EDITOR}}"

# utilities
alias grep="grep --color=auto"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias ln="ln -i"
alias du="du -h"
# ls output
alias ls="ls --group-directories-first --color=auto"
alias l='ls -1A'  # one column, hidden files.
alias ll='ls -lh' # human readable sizes.
alias lr='ll -R'  # human readable sizes, recursively.
alias la='ll -A'  # human readable sizes, hidden files.
alias lar='la -R' # human readable sizes, recursively.
# git
alias gs='git status --short'
alias gS='git status'
alias ga='git add'
alias gcm='git commit --message'
alias gpu='git push -u'
alias gpuom='git push -u origin main'
alias gd='git diff --no-ext-diff'
alias gD='git diff --no-ext-diff --word-diff'
alias gco='git checkout'
alias gsw='git switch'
# tmux
alias tm="tmux new-session -s dev"
alias ktm="tmux kill-server"

# python environment
eval "$(pyenv init -)"
function poet() {
  POET_MANUAL=1
  if [[ -v VIRTUAL_ENV ]]; then
    deactivate
  else
    . "$(poetry env info --path)/bin/activate"
  fi
}

# rust environment
export PATH="$HOME/.cargo/bin:$PATH"  # rust binaries
if [[ -x "$(command -v rustc)" ]]; then
  export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/library
fi

export PATH="$HOME/.npm/bin:$PATH"

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
