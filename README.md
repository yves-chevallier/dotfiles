# dotfiles

Personal dotfiles for **Ubuntu / WSL**, managed with
[dotbot](https://github.com/anishathalye/dotbot) (symlinks) and a bootstrap
script that installs the tooling.

## Install on a fresh machine

```sh
git clone --recurse-submodules https://github.com/nowox/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup.sh
```

`setup.sh` does two things:

1. **`bootstrap.sh`** — installs the tools via `apt`, plus `starship` and
   `antidote`:
   `zsh tmux neovim git fzf ripgrep fd bat eza zoxide jq` … and sets zsh as the
   default shell.
2. **`./install`** — symlinks every dotfile into place (dotbot).

Then open a new terminal (or `exec zsh`).

You can also run the two steps separately (`./bootstrap.sh`, then `./install`).

## What's inside

| Area     | Choice                                                        |
| -------- | ------------------------------------------------------------ |
| Shell    | zsh + [antidote](https://github.com/mattmc3/antidote) plugins |
| Prompt   | [starship](https://starship.rs) (`config/starship.toml`)     |
| Editor   | Neovim + [lazy.nvim](https://github.com/folke/lazy.nvim) (`nvim/`) |
| Multiplex| tmux + [tpm](https://github.com/tmux-plugins/tpm)            |
| CLI tools| ripgrep, fd, bat, eza, zoxide, fzf                           |

zsh plugins live in [`zsh/zsh_plugins.txt`](zsh/zsh_plugins.txt) (antidote
manifest). Shared aliases are in [`aliases`](aliases) (sourced by both zsh and
bash).

## Private / machine-specific settings

Anything personal (work paths, private aliases) goes in `~/.zshrc.local`, which
is **not** version-controlled. A template is provided:

```sh
cp ~/.dotfiles/zshrc.local.example ~/.zshrc.local
cp ~/.dotfiles/gitconfig.local.example ~/.gitconfig.local   # credential helper, signing, Beyond Compare
```

`~/.gitconfig.local` is pulled in via `[include]` at the end of the versioned
`gitconfig`, so it overrides the shared defaults.

## tmux plugins

After first launch, install tmux plugins with `prefix + I` (tpm).

## Windows (host) apps

Installed on the Windows side with `winget`:

```powershell
winget install Git.Git Microsoft.VisualStudioCode Microsoft.WindowsTerminal Google.Chrome
```
