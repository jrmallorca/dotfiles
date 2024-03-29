# -----------------------------------------------------------------------------
# Arch Setup
# -----------------------------------------------------------------------------

.PHONY: all clean test init lockscreen

# Initialise setup
init: package-manager base nvidia-services tools development lsp gitdiff mime browser terminal shell fisher fisher-plugins file-manager window-manager lockscreen fonts configuration etc

init-wsl: package-manager base-wsl tools-wsl development editor lsp gitdiff terminal shell fisher fisher-plugins file-manager fonts configuration apy

# -----------------------------------------------------------------------------
# Dot Files
# -----------------------------------------------------------------------------

# Transfer config files.
configuration:
	cp -a ./config/. ~/.config/

etc:
	sudo cp -a ./modprobe.d/. /etc/modprobe.d/
	sudo cp -a ./pacman.d/. /etc/pacman.d/

getty:
	sudo cp -a ./systemd/. /etc/systemd/
	sudo systemctl enable getty@tty1

getty:
	sudo cp -a ./getty@tty1.service.d/. /etc/systemd/system/getty@tty1.service.d/

# Transfer cron jobs
cron:
	sudo cp mirrorlist /etc/cron.daily/

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

# Disable NVIDIA services
# https://askubuntu.com/a/1436921
nvidia-services:
	sudo systemctl disable nvidia-suspend nvidia-hibernate nvidia-resume

base:
	paru -Syu --needed grub base-devel reflector rustup \
		intel-ucode amd-ucode networkmanager network-manager-applet \
		xf86-video-amdgpu xf86-video-ati xf86-video-intel xf86-video-nouveau \
		xf86-video-vesa xdg-utils xdg-user-dirs nvidia-open-dkms
	rustup default stable
	sudo systemctl enable NetworkManager
	sudo systemctl enable reflector.service reflector.timer

tools:
	paru -Syu --needed unclutter tlp feh mpv ffmpeg zathura \
		zathura-pdf-mupdf nodejs npm python python-pip \
		dunst libinput zoxide trash-cli unzip \
		alsa-utils bluez bluez-utils blueman pulseaudio-bluetooth
	sudo systemctl enable tlp
	sudo systemctl enable bluetooth.service

development:
	paru -Syu --needed git github-cli \
		curl wget daemon wl-clipboard xsel xdotool fzf fd bat ripgrep man less neovim \
		openssh
	python3 -m venv .venv; . .venv/bin/activate; pip3 install pynvim; deactivate
	rm -r .venv

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
	paru -Syu --needed lf ueberzug chafa daemon
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

window-manager: hyprland

hyprland:
	paru -Syu --needed hyprland hyprpaper waybar fuzzel physlock qt6ct qt6-wayland libva
	hyprpm add https://github.com/Duckonaut/split-monitor-workspaces
	hyprpm enable split-monitor-workspaces
	hyprpm reload

lockscreen:
	paru -Syu --needed physlock

fonts:
	paru -Syu --needed ttf-iosevka-nerd noto-fonts-emoji

# LSPs, linters and formatters
lsp:
	paru -Syu --needed checkmake

# Base (WSL)
# -----------------------------------------------------------------------------

base-wsl:
	paru -Syu --needed grub base-devel reflector xdg-user-dirs

tools-wsl:
	paru -Syu --needed unclutter feh mpv ffmpeg youtube-dl zathura \
		zathura-pdf-mupdf nodejs npm python python-pip \
		zoxide trash-cli


# Other
# -----------------------------------------------------------------------------

# Mount the D drive from Windows
mountd:
	paru -Syu --needed ntfs-3g
	sudo mkdir -p /mnt/d
	echo "Copy this into etc/fstab: UUID=<uuid> /mnt/d ntfs uid=1000,gid=1000,umask=0022,sync,auto,rw 0 0"
	echo "Get UUID from the following command: lsblk -o NAME,FSTYPE,UUID"
	echo "Do: sudo mount -av"

signal:
	paru -Syu --needed signal-desktop

spotify-tui:
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

backlight:
	paru -Syu --needed clight clightd clight-gui-git
	sudo systemctl enable clightd.service

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
	wl-copy < ~/.ssh/id_ed25519.pub
	echo "Paste the secret key into GitHub"

gitgpgkeys:
	gpg --full-generate-key
	GPGKEYID=$$(gpg --list-secret-keys --keyid-format=long | grep sec | head -1 | awk '{print $2}' | cut -d '/' -f 2); \
	gpg --armor --export $$GPGKEYID | wl-copy
	echo "Paste the secret key into GitHub"

# Extra
# -----------------------------------------------------------------------------

# (Proprietary) Communication apps
coms:
	paru -Syu teams-for-linux discord

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
