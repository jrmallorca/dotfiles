# ----------------------------------------------------------------------------
# MacOS Setup
# -----------------------------------------------------------------------------

.PHONY: all clean test init fisher

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
init: package-manager tools gitdiff shell fisher fisher-plugins fonts twm
	brew upgrade

package-manager:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

tools:
	brew upgrade && brew install gnupg wget fzf fd bat ripgrep jq \
		neovim zoxide diff-so-fancy lf gh trash-cli
	brew install --cask cursorcerer alacritty

gitdiff:
	git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
	git config --global interactive.diffFilter "diff-so-fancy --patch"

shell:
	brew install fish
	echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
	chsh -s /opt/homebrew/bin/fish

fisher: SHELL:=/opt/homebrew/bin/fish
fisher:
	curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

fisher-plugins: SHELL:=/opt/homebrew/bin/fish
fisher-plugins:
	fisher install jorgebucaran/nvm.fish
	nvm install lts

fonts:
	brew tap homebrew/cask-fonts
	brew upgrade && brew install --cask font-iosevka-nerd-font

# Tiling Window Manager (TWM)
twm:
	brew upgrade && brew install koekeishiya/formulae/yabai koekeishiya/formulae/skhd
	yabai --start-service
	skhd --start-service
	echo "Follow the instructions in the following link: https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)#configure-scripting-addition"

# Development
# -----------------------------------------------------------------------------

java:
	brew upgrade && brew install java maven
	git clone https://github.com/jenv/jenv.git ~/.jenv
	jenv enable-plugin export
	exec $$SHELL -l
	jenv add "$$(/usr/libexec/java_home)"
	sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk \
		 /Library/Java/JavaVirtualMachines/openjdk.jdk

#  gradle:
#  brew upgrade && brew install gradle
#  echo $"\nGRADLE_VERSION=$(echo $(arr=($(gradle --version | awk '{ print $2 }')) && echo ${arr[0]}))\n"

flutter: java
	# Android
	# Flutter
	brew upgrade && brew install --cask flutter

gitgpgkeys:
	gpg --full-generate-key
	GPGKEYID=$$(gpg --list-secret-keys --keyid-format=long | grep sec | head -1 | awk '{print $2}' | cut -d '/' -f 2); \
	gpg --armor --export $$GPGKEYID | pbcopy
	echo "Paste the secret key into GitHub"
