# -----------------------------------------------------------------------------
# Arch Setup
# -----------------------------------------------------------------------------

.PHONY: all clean test init lockscreen

# Initialise setup
init: package-manager base nvidia-services tools development editor null-ls telekasten gitdiff mime browser terminal shell fisher fisher-plugins file-manager window-manager display-manager compositor lockscreen theme fonts configuration xorg modprobe.d

init-wsl: package-manager base-wsl tools-wsl development editor null-ls telekasten gitdiff terminal shell fisher fisher-plugins file-manager fonts configuration apy

# -----------------------------------------------------------------------------
# Dot Files
# -----------------------------------------------------------------------------

# Transfer config files.
configuration:
	cp -a ./config/. ~/.config/
	cp .xinitrc ~/

xorg:
	sudo cp -a ./xorg.conf.d/. /etc/X11/xorg.conf.d/

modprobe.d:
	sudo cp nobeep.conf /etc/modprobe.d/
	sudo cp -a ./pacman.d/. /etc/modprobe.d/

# Transfer cron jobs
cron:
	sudo cp mirrorlist /etc/cron.daily/

# Transfer theme related files.
#  theme:
#  sudo cp -a ../backgrounds/ /usr/share/
#  sudo cp -a ../themes/ /usr/share/
#  sudo cp -a ../icons/ /usr/share/
#  sudo cp -a ../fonts/ /usr/share/
#  sudo cp bitlbee.conf /etc/bitlbee/
#  sudo cp lightdm.conf /etc/lightdm/

# -----------------------------------------------------------------------------
# Programs
# -----------------------------------------------------------------------------

# Base
# -----------------------------------------------------------------------------

# paru (AUR Helper)
package-manager:
	sudo pacman -S --needed git base-devel
	cd ~ && git clone https://aur.archlinux.org/paru.git && \
		cd paru && makepkg -si
	sudo rm -rf ~/paru/

nvidia-services:
	sudo systemctl enable nvidia-suspend.service
	sudo systemctl enable nvidia-hibernate.service
	sudo systemctl enable nvidia-resume.service

base:
	paru -Syu --needed grub base-devel reflector \
		intel-ucode amd-ucode networkmanager network-manager-applet \
		xf86-video-amdgpu xf86-video-ati xf86-video-intel xf86-video-nouveau \
		xf86-video-vesa xdg-utils xdg-user-dirs nvidia-open \
		xorg-xinit xorg-server xorg-xinput
	sudo systemctl enable NetworkManager
	sudo systemctl enable reflector.service
	sudo systemctl enable reflector.timer

base-wsl:
	paru -Syu --needed grub base-devel reflector xdg-user-dirs

tools:
	paru -Syu --needed unclutter tlp feh mpv ffmpeg youtube-dl zathura \
		zathura-pdf-mupdf nodejs npm python python-pip \
		dunst flameshot libinput zoxide trash-cli \
		alsa-utils bluez bluez-utils blueman pulseaudio-bluetooth
	sudo systemctl enable tlp
	sudo systemctl enable bluetooth.service

backlight:
	paru -Syu --needed clight clightd clight-gui-git
	sudo systemctl enable clightd.service

tools-wsl:
	paru -Syu --needed unclutter feh mpv ffmpeg youtube-dl zathura \
		zathura-pdf-mupdf nodejs npm python python-pip \
		zoxide trash-cli

development:
	paru -Syu --needed git github-cli tmux \
		curl wget daemon xclip xsel xdotool fzf fd bat ripgrep xcape \
		openssh
	python3 -m venv .venv; . .venv/bin/activate; pip3 install pynvim; deactivate
	rm -r .venv

editor:
	paru -Syu --needed neovim

gitdiff:
	paru -Syu --needed diff-so-fancy
	# Use diff-so-fancy for all diff output
	git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
	git config --global interactive.diffFilter "diff-so-fancy --patch"
	# Use better colors for diff output
	git config --global color.ui true
	git config --global color.diff-highlight.oldNormal    "red bold"
	git config --global color.diff-highlight.oldHighlight "red bold 52"
	git config --global color.diff-highlight.newNormal    "green bold"
	git config --global color.diff-highlight.newHighlight "green bold 22"
	git config --global color.diff.meta       "11"
	git config --global color.diff.frag       "magenta bold"
	git config --global color.diff.func       "146 bold"
	git config --global color.diff.commit     "yellow bold"
	git config --global color.diff.old        "red bold"
	git config --global color.diff.new        "green bold"
	git config --global color.diff.whitespace "red reverse"

# Configures mimes for xdg-open
mime:
	xdg-mime default org.pwmt.zathura.desktop application/pdf

browser:
	paru -Syu --needed firefox

terminal:
	paru -Syu --needed alacritty

shell:
	paru -Syu --needed fish
	echo /usr/bin/fish | sudo tee -a /etc/shells
	chsh -s /usr/bin/fish

fisher: SHELL:=/usr/bin/fish
fisher:
	curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

fisher-plugins: SHELL:=/usr/bin/fish
fisher-plugins:
	fisher install jorgebucaran/nvm.fish
	nvm install lts

file-manager: lf

lf:
	paru -Syu --needed lf ueberzug chafa daemon devour
	mkdir -p ~/git-installs
	cd ~/git-installs && \
		git clone https://github.com/Naheel-Azawy/stpv.git && \
		git clone https://github.com/exiftool/exiftool.git
	cd ~/git-installs/stpv && \
		sudo make install
	cd ~/git-installs/exiftool && \
		perl Makefile.PL && \
		make && \
		make test && \
		sudo make install

window-manager: awesome
	# i3

i3:
	paru -Syu --needed i3-gaps i3status i3lock perl-anyevent-i3 i3-resurrect \
		dmenu xss-lock

awesome:
	paru -Syu --needed awesome

display-manager: ly
	# lightdm

# Webkit2 greeter
lightdm:
	paru -Syu --needed xorg-server xorg-xinit lightdm lightdm-webkit2-greeter \
		lightdm-webkit-theme-sequoia-git
	systemctl enable lightdm

# Ly display manager
ly:
	paru -Syu --needed ly
	sudo systemctl enable ly.service
	sudo systemctl disable getty@tty2.service
	cd ~/ && chmod +x .xinitrc

lockscreen: betterlockscreen

betterlockscreen:
	paru -Syu --needed betterlockscreen
	betterlockscreen -u ~/dotfiles/backgrounds/
	sudo systemctl enable betterlockscreen@$USER

compositor:
	paru -Syu --needed picom

theme:
	paru -Syu --needed lxappearance-gtk3 gtk3

fonts:
	paru -Syu --needed ttf-iosevka-nerd noto-fonts-emoji

# LSPs, linters and formatters
null-ls:
	paru -Syu --needed checkmake

# Zettelkasten plugin in Neovim
telekasten:
	paru -Syu --needed xclip

# Other
# -----------------------------------------------------------------------------

# Mount the D drive from Windows
mountd:
	paru -Syu --needed ntfs-3g
	sudo mkdir -p /mnt/d
	echo "Copy this into etc/fstab: UUID=<uuid> /mnt/d ntfs uid=1000,gid=1000,umask=0022,sync,auto,rw 0 0"
	echo "Get UUID from the following command: lsblk -o NAME,FSTYPE,UUID"
	echo "Do: sudo mount -av"

# Signal
signal:
	gpg --keyserver keyserver.ubuntu.com --recv-key FA10826A74907F9EC6BBB7FC2BA2CD21B5B09570
	paru -Syu --needed jdk-openjdk rustup
	# paru -Syu --needed jdk11-openjdk rustup
	sudo archlinux-java set java-16-openjdk
	# sudo archlinux-java set java-11-openjdk
	# rustup install stable
	# rustup default stable
	paru -Syu --needed signal-cli
	pip install urwid
	cd ~ && git clone https://github.com/isamert/scli.git

# weechat (CLI messaging) and bitlbee (For facebook and other stuff)
# http://thedarnedestthing.com/weechat%20+%20bitlbee
# https://zanshin.net/2015/01/10/a-guide-for-setting-up-weechat-and-bitlbee/
# https://wiki.bitlbee.org/HowtoFacebookMQTT
# https://weechat.org/files/doc/stable/weechat_quickstart.en.html
weechat-bitlbee:
	paru -Syu --needed weechat bitlbee bitlbee-facebook aspell lua tcl ruby libotr
	sudo cp ../bitlbee.conf /etc/bitlbee
	systemctl enable bitlbee --now
	printf "Start weechat and do the following:\n
	/server add im localhost/6667 -autoconnect\n
	/connect im\n
	In the bitlbee channel:\n
	register <password>\n
	In the weechat channel:\n
	/set irc.server.im.command \"/msg &bitlbee identify <password>\"\n
	Now generate an app password on facebook for bitlbee
	In the bitlbee channel:\n
	account add facebook <email> <app_password>\n
	account facebook on\n"

# Spotify TUI
spotify:
	paru -Syu --needed spotifyd spotify-tui
	echo "Make the .config/spotifyd/spotifyd.conf for the login"
	sudo systemctl --user start spotifyd.service
	sudo systemctl --user enable spotifyd.service

vm:
	paru -Syu --needed virtualbox virtualbox-guest-iso virtualbox-ext-oracle
	sudo modprobe vboxdrv
	sudo gpasswd -aG vboxusers $$USER

torrent:
	paru -Syu --needed qbittorrent

# Programming
# -----------------------------------------------------------------------------

java:
	paru -Syu jre-openjdk maven

flutter:
	paru -Syu --needed jdk8-openjdk simple-mtpfs flutter android-sdk \
		android-sdk-platform-tools android-sdk-build-tools android-platform \
		android-sdk-cmdline-tools-latest scrcpy
	sudo groupadd flutterusers
	sudo gpasswd -a $$USER flutterusers
	sudo chown -R :flutterusers /opt/flutter
	sudo chmod -R g+w /opt/flutter/
	sudo groupadd android-sdk
	sudo gpasswd -a $$USER android-sdk
	sudo setfacl -R -m g:android-sdk:rwx /opt/android-sdk
	sudo setfacl -d -m g:android-sdk:rwX /opt/android-sdk

# P2P syncing
syncthing:
	paru -Syu syncthing
	sudo systemctl enable syncthing@$$USER

# Git
# -----------------------------------------------------------------------------

gitsshkeys:
	ssh-keygen -t ed25519 -C "48072014+jrmallorca@users.noreply.github.com"
	eval "$$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519
	xclip -selection clipboard < ~/.ssh/id_ed25519.pub
	echo "Paste the secret key into GitHub"

# INCOMPLETE and doesn't do the last 2 lines in git docs
gitgpgkeys:
	gpg --full-generate-key
	GPGKEYID=$$(gpg --list-secret-keys --keyid-format=long | grep sec | head -1 | awk '{print $2}' | cut -d '/' -f 2); \
	gpg --armor --export $$GPGKEYID | xclip -selection clipboard
	echo "Paste the secret key into GitHub"

# Extra
# -----------------------------------------------------------------------------

# (Proprietary) Communication apps
coms:
	paru -Syu teams-for-linux discord

# (Proprietary) Note-taking application
obsidian:
	paru -Syu obsidian

apy:
	paru -Syu python-pipx
	pipx install git+https://github.com/lervag/apy

# -----------------------------------------------------------------------------
# Programs
# -----------------------------------------------------------------------------

docker:
	paru -Syu --needed --noconfirm docker
	- sudo groupadd docker && usermod -aG docker $$USER && newgrp docker
	docker run hello-world
	sudo systemctl enable docker.service
	sudo systemctl enable containerd.service

dockerosx: docker
	paru -Syu --needed --noconfirm qemu libvirt dnsmasq virt-manager bridge-utils flex bison iptables-nft edk2-ovmf
	sudo systemctl enable --now libvirtd
	sudo systemctl enable --now virtlogd
	sudo modprobe kvm

# QMK Firmware for keyboards
qmk:
	paru -Syu --needed --noconfirm git python-pip libffi
	python3 -m pip install --user qmk
	cd ~ && git clone --recurse-submodules git@github.com:jrmallorca/qmk_firmware.git

# Enable stenography in OS
steno:
	pip install rtf-tokenize
	paru -Syu --needed --noconfirm plover-git plover_plugins_manager
	sudo usermod -aG uucp $$USER
