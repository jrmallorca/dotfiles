# ----------------------------------------------------------------------------
# MacOS Setup
# -----------------------------------------------------------------------------

.PHONY: all clean test init

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
init: SHELL:=/bin/bash
init: package-manager tools shell fonts
	brew upgrade

package-manager:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

tools:
	brew upgrade && brew install gnupg wget fzf fd bat ripgrep jq \
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
	brew upgrade && brew install --cask font-iosevka-ss14

# Development
# -----------------------------------------------------------------------------

flutter:
	brew upgrade && brew install --cask flutter

gitgpgkeys:
	gpg --full-generate-key
	GPGKEYID=$$(gpg --list-secret-keys --keyid-format=long | grep sec | head -1 | awk '{print $2}' | cut -d '/' -f 2); \
	gpg --armor --export $$GPGKEYID | pbcopy
	echo "Paste the secret key into GitHub"
