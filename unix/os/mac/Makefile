# ----------------------------------------------------------------------------
# MacOS Setup
# -----------------------------------------------------------------------------

.PHONY: all clean test

# -----------------------------------------------------------------------------
# Dot Files
# -----------------------------------------------------------------------------

# Transfer config files.
configuration:
	cp -a ./../../config/. ~/.config/
	cp -a ./config/. ~/.config/

# -----------------------------------------------------------------------------
# Programs
# -----------------------------------------------------------------------------

# Base
# -----------------------------------------------------------------------------
# Install main programs.
init:
	SHELL:=/bin/bash
	package-manager
	brew upgrade
	tools
	shell
	fonts

package-manager:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

tools:
	brew install gnupg wget fzf fd bat ripgrep jq \
		neovim zoxide diff-so-fancy lf gh
	brew install --cask cursorcerer alacritty
	gitdiff

gitdiff:
	git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
	git config --global interactive.diffFilter "diff-so-fancy --patch"

shell:
	brew install fish
	echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
	chsh -s /opt/homebrew/bin/fish
	fisher

fisher:
	SHELL:=/opt/homebrew/bin/fish
	curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
	fisher-plugins

fisher-plugins:
	SHELL:=/opt/homebrew/bin/fish
	fisher install jorgebucaran/nvm.fish

fonts:
	brew tap homebrew/cask-fonts
	brew install --cask font-iosevka-ss14
