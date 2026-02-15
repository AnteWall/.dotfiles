# Dotfiles

This repo stores personal config files (currently Neovim and tmux).

## Clone on a new computer

```bash
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles
./setup.sh
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

`./setup.sh` links these files:

```text
~/.tmux.conf -> ~/.dotfiles/tmux/tmux.conf
~/.tmux.conf.local -> ~/.dotfiles/tmux/tmux.conf.local
~/.config/tmux/tmux.conf -> ~/.dotfiles/tmux/tmux.conf
~/.config/tmux/tmux.conf.local -> ~/.dotfiles/tmux/tmux.conf.local
```

Then start tmux normally:

```bash
tmux
```

## tmux-sessionizer: local copy + tmux binding

This repo vendors [ThePrimeagen/tmux-sessionizer](https://github.com/ThePrimeagen/tmux-sessionizer)
as a local copy at:

```text
~/.dotfiles/tmux-sessionizer/tmux-sessionizer
```

`./setup.sh` also links:

```text
~/.config/tmux-sessionizer/tmux-sessionizer.conf -> ~/.dotfiles/tmux-sessionizer/tmux-sessionizer.conf
```

The tmux config binds `prefix + f` (`Ctrl-b f`) to launch sessionizer using this local script path.
After edits, reload tmux config with:

```bash
tmux source-file "$HOME/.dotfiles/tmux/tmux.conf"
```
