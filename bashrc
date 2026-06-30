# ~/.bashrc — kept minimal. zsh is the primary shell; this covers bash sessions.

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Bash completion
[ -f /etc/bash_completion ] && . /etc/bash_completion

umask 022

# --- History -----------------------------------------------------------------
export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=100000
export HISTFILESIZE=200000
export HISTIGNORE='&:ls:ll:la:cd:exit:clear:history'

# --- Shell options -----------------------------------------------------------
shopt -s cdspell autocd dirspell globstar histappend checkwinsize cmdhist histreedit histverify

# --- Environment -------------------------------------------------------------
export PATH="$HOME/.local/bin:$HOME/bin:$HOME/.scripts:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LESS="-R"
export TIME_STYLE=long-iso

# --- Colors ------------------------------------------------------------------
[ -f "$HOME/.dircolors" ] && eval "$(dircolors "$HOME/.dircolors")"

# --- Prompt ------------------------------------------------------------------
# starship if available, else fall back to the legacy bash_prompt
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
elif [ -f ~/.bash_prompt ]; then
  source ~/.bash_prompt
fi

# --- Tools -------------------------------------------------------------------
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash)"
if command -v fzf >/dev/null 2>&1 && fzf --bash >/dev/null 2>&1; then
  eval "$(fzf --bash)"
fi

# --- Aliases (shared with zsh) -----------------------------------------------
[ -f ~/.aliases ] && source ~/.aliases

# --- Machine-specific overrides ----------------------------------------------
[ -f ~/.bashrc.local ] && source ~/.bashrc.local
