# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:*:*:default' menu yes select

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
export PATH="$HOME/.poetry/bin:$PATH"  # poetry
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

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
