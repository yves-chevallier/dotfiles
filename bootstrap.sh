#!/usr/bin/env bash
#
# bootstrap.sh — Install the tools the dotfiles rely on.
# Target: Ubuntu / WSL (apt). Idempotent: safe to re-run.
#
# Run this BEFORE ./install (or just run ./setup which does both).

set -euo pipefail

log()  { printf '\033[1;34m::\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!!\033[0m %s\n' "$*"; }

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

# --- 1. APT packages --------------------------------------------------------
# Names chosen for Ubuntu 24.04+/26.04. On Debian/Ubuntu the `fd` and `bat`
# binaries are installed as `fdfind` and `batcat` (see symlinks below).
APT_PACKAGES=(
  zsh tmux neovim git curl wget unzip
  build-essential
  ripgrep fd-find bat fzf jq
  zoxide eza
)

if command -v apt-get >/dev/null 2>&1; then
  log "Updating apt and installing packages…"
  sudo apt-get update -qq
  # Install whatever is available; never abort the whole run on one missing pkg.
  for pkg in "${APT_PACKAGES[@]}"; do
    if sudo apt-get install -y -qq "$pkg" >/dev/null 2>&1; then
      printf '   + %s\n' "$pkg"
    else
      warn "apt package '$pkg' unavailable on this release — skipping"
    fi
  done
else
  warn "apt-get not found — this bootstrap targets Ubuntu/WSL. Skipping packages."
fi

# --- 2. Debian binary-name shims (fd, bat) ----------------------------------
# Expose the upstream names so configs/aliases stay distro-agnostic.
[ -x /usr/bin/fdfind ] && ln -sf /usr/bin/fdfind "$BIN_DIR/fd"
[ -x /usr/bin/batcat ] && ln -sf /usr/bin/batcat "$BIN_DIR/bat"

# --- 3. starship (prompt) ---------------------------------------------------
if ! command -v starship >/dev/null 2>&1; then
  log "Installing starship → $BIN_DIR"
  curl -fsSL https://starship.rs/install/install.sh | sh -s -- --yes --bin-dir "$BIN_DIR"
else
  log "starship already installed"
fi

# --- 4. antidote (zsh plugin manager) ---------------------------------------
ANTIDOTE_DIR="$HOME/.antidote"
if [ ! -d "$ANTIDOTE_DIR" ]; then
  log "Cloning antidote → $ANTIDOTE_DIR"
  git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_DIR"
else
  log "antidote already present"
fi

# --- 5. Make zsh the default shell ------------------------------------------
if command -v zsh >/dev/null 2>&1; then
  ZSH_PATH="$(command -v zsh)"
  if [ "${SHELL:-}" != "$ZSH_PATH" ]; then
    log "Setting default shell to zsh (may prompt for password)"
    chsh -s "$ZSH_PATH" || warn "chsh failed — run 'chsh -s $ZSH_PATH' manually"
  fi
fi

log "Bootstrap complete. Next: ./install   (or it was already run by ./setup)"
