# Dotfiles

This repo stores personal config files (currently Neovim and tmux).

## Clone on a new computer

```bash
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles
```

## Prerequisites (Homebrew)

Install required packages:

```bash
brew install neovim tmux fzf ripgrep
```

## Neovim: point to this repo with XDG mapping

Neovim reads config from `$XDG_CONFIG_HOME/nvim`.
Since this repo has `nvim/`, you can run Neovim with:

```bash
XDG_CONFIG_HOME="$HOME/.dotfiles" nvim
```

Optional alias (add to your shell config):

```bash
alias nvim='XDG_CONFIG_HOME="$HOME/.dotfiles" nvim'
```

## tmux: use config from this repo

tmux config is in:

```text
~/.dotfiles/tmux/tmux.conf
```

Option 1: start tmux with this config directly:

```bash
tmux -f "$HOME/.dotfiles/tmux/tmux.conf"
```

Optional alias:

```bash
alias tmux='tmux -f "$HOME/.dotfiles/tmux/tmux.conf"'
```

Option 2: use tmux's config path under `~/.config`:

```bash
mkdir -p "$HOME/.config"
ln -s "$HOME/.dotfiles/tmux" "$HOME/.config/tmux"
```

Then start tmux normally:

```bash
tmux
```

## tmux-sessionizer: local copy + tmux binding

This repo vendors [ThePrimeagen/tmux-sessionizer](https://github.com/ThePrimeagen/tmux-sessionizer)
as a local copy at:

```text
~/.dotfiles/tmux/tmux-sessionizer
```

The tmux config binds `prefix + f` to launch sessionizer using this local script path.
After edits, reload tmux config with:

```bash
tmux source-file "$HOME/.dotfiles/tmux/tmux.conf"
```
