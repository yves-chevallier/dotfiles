#!/usr/bin/env bash
#
# setup.sh — One-shot entrypoint for a fresh machine.
#   1. bootstrap.sh : install tools (zsh, nvim, ripgrep, fd, starship, antidote…)
#   2. ./install    : symlink the dotfiles into place (dotbot)
#
# Usage:  ./setup.sh
set -euo pipefail
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$BASEDIR/bootstrap.sh"
"$BASEDIR/install"

printf '\n\033[1;32mDone.\033[0m Open a new terminal (or run: exec zsh) to start using the new setup.\n'
