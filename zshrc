# ~/.zshrc — interactive zsh configuration (WSL/Linux)
# Bootstrapped by ./bootstrap.sh: starship + antidote + modern CLI tools.

# --- PATH --------------------------------------------------------------------
export PATH="$HOME/.local/bin:$HOME/bin:$HOME/.scripts:$PATH"
[ -d "$HOME/.config/composer/vendor/bin" ] && export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# --- Environment -------------------------------------------------------------
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LESS="-R"

# --- History -----------------------------------------------------------------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history hist_expire_dups_first hist_ignore_dups hist_ignore_space
setopt hist_verify inc_append_history share_history

# --- Colors ------------------------------------------------------------------
[ -f "$HOME/.dircolors" ] && eval "$(dircolors "$HOME/.dircolors")"

# --- Plugins (antidote) ------------------------------------------------------
ANTIDOTE_DIR="${ANTIDOTE_DIR:-$HOME/.antidote}"
if [[ -e $ANTIDOTE_DIR/antidote.zsh ]]; then
  source "$ANTIDOTE_DIR/antidote.zsh"
  zsh_plugins="${ZDOTDIR:-$HOME}/.zsh_plugins"
  # Regenerate the static bundle only when the manifest changed.
  if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
    antidote bundle <"${zsh_plugins}.txt" >"${zsh_plugins}.zsh"
  fi
  source "${zsh_plugins}.zsh"
fi

# --- Completion --------------------------------------------------------------
autoload -Uz compinit && compinit -u
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' menu select

# --- Prompt (starship) -------------------------------------------------------
command -v starship >/dev/null && eval "$(starship init zsh)"

# --- Smarter cd (zoxide) -----------------------------------------------------
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# --- Fuzzy finder (fzf) ------------------------------------------------------
if command -v fzf >/dev/null; then
  if fzf --zsh >/dev/null 2>&1; then
    eval "$(fzf --zsh)"                                  # fzf >= 0.48
  else
    [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
    [ -f /usr/share/doc/fzf/examples/completion.zsh ]   && source /usr/share/doc/fzf/examples/completion.zsh
  fi
fi
# Use fd/ripgrep for fzf when available
command -v fd >/dev/null && export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# --- Aliases -----------------------------------------------------------------
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

# --- AI completion (zsh-codex) bound to Ctrl-X -------------------------------
(( $+functions[create_completion] )) && bindkey '^X' create_completion

# --- Machine-specific / private overrides (not version-controlled) -----------
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
