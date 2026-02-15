#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/tmux-sessionizer"

ln -sfn "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

if [[ -f "$DOTFILES_DIR/tmux/tmux.conf.local" ]]; then
    ln -sfn "$DOTFILES_DIR/tmux/tmux.conf.local" "$HOME/.tmux.conf.local"
fi

if [[ -L "$HOME/.config/tmux" || ! -e "$HOME/.config/tmux" ]]; then
    ln -sfn "$DOTFILES_DIR/tmux" "$HOME/.config/tmux"
else
    ln -sfn "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
    if [[ -f "$DOTFILES_DIR/tmux/tmux.conf.local" ]]; then
        ln -sfn "$DOTFILES_DIR/tmux/tmux.conf.local" "$HOME/.config/tmux/tmux.conf.local"
    fi
fi

ln -sfn "$DOTFILES_DIR/tmux-sessionizer/tmux-sessionizer.conf" "$HOME/.config/tmux-sessionizer/tmux-sessionizer.conf"

chmod +x "$DOTFILES_DIR/tmux-sessionizer/tmux-sessionizer"

echo "Dotfiles setup complete."
echo "Reload tmux with: tmux source-file '$HOME/.tmux.conf'"
