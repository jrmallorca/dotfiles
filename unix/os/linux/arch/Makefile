# -----------------------------------------------------------------------------
# Arch Setup
# -----------------------------------------------------------------------------

.PHONY: all clean test init lockscreen

# Initialise setup
init-nvidia: etc package-manager base nvidia tools development lsp gitdiff mime browser terminal shell fisher fisher-plugins file-manager window-manager lockscreen fonts config

init-amd: etc package-manager base nvidia tools development lsp gitdiff mime browser terminal shell fisher fisher-plugins file-manager window-manager lockscreen fonts config

init-wsl: etc package-manager base-wsl tools-wsl development editor lsp gitdiff terminal shell fisher fisher-plugins file-manager fonts apy config

init-archinstall-nvidia: etc package-manager nvidia tools development lsp gitdiff mime browser terminal shell fisher fisher-plugins file-manager window-manager lockscreen fonts config

init-archinstall-amd: etc package-manager tools development lsp gitdiff mime browser terminal shell fisher fisher-plugins file-manager window-manager lockscreen fonts config notes

# -----------------------------------------------------------------------------
# Dot Files
# -----------------------------------------------------------------------------

etc:
	sudo cp -a ./../etc/. /etc/

getty: etc
	sudo systemctl enable getty@tty1

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
	sudo pacman -S --needed git base-devel rustup
	rustup default stable
	cd ~ && git clone https://aur.archlinux.org/paru.git && \
		cd paru && makepkg -si
	sudo rm -rf ~/paru/

# Disable NVIDIA services
# https://askubuntu.com/a/1436921
nvidia:
	sudo systemctl disable nvidia-suspend nvidia-hibernate nvidia-resume
	sudo cp -a ./nvidia/modprobe.d/. /etc/modprobe.d/
	sudo cp -a ./nvidia/pacman.d/. /etc/pacman.d/

base:
	paru -Syu --needed grub base-devel reflector \
		intel-ucode amd-ucode networkmanager network-manager-applet \
		xf86-video-amdgpu xf86-video-ati xf86-video-intel xf86-video-nouveau \
		xf86-video-vesa xdg-utils xdg-user-dirs nvidia-open-dkms
	sudo systemctl enable NetworkManager
	sudo systemctl enable reflector.service reflector.timer

tools:
	paru -Syu --needed unclutter tlp feh mpv ffmpeg zathura zathura-pdf-mupdf \
		nodejs npm python python-pip networkmanager network-manager-applet
		brightnessctl dunst libinput zoxide trash-cli unzip jq kopia \
		alsa-utils bluez bluez-utils blueman \
		imagemagick tectonic ghostscript # Render images with snacks.nvim
	sudo systemctl enable NetworkManager
	sudo systemctl enable tlp
	sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
	sudo systemctl enable bluetooth.service

development:
	paru -Syu --needed git github-cli \
		curl wget daemon wl-clipboard xsel xdotool fzf fd bat ripgrep man less neovim \
		openssh tree-sitter-cli
	python3 -m venv .venv; . .venv/bin/activate; pip3 install pynvim; deactivate
	rm -r .venv
	git config --global user.email "48072014+jrmallorca@users.noreply.github.com"
	git config --global user.name "Jonquil Isys Mallorca"

# LSPs, linters and formatters
lsp:
	paru -Syu --needed checkmake

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
	paru -Syu --needed zen-browser-bin

terminal:
	paru -Syu --needed ghostty

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
	paru -Syu --needed lf ueberzug chafa daemon ctpv
	mkdir -p ~/git-installs
	cd ~/git-installs && \
		git clone https://github.com/exiftool/exiftool.git
	cd ~/git-installs/exiftool && \
		perl Makefile.PL && \
		make && \
		make test && \
		sudo make install

window-manager: hyprland

hyprland:
	paru -Syu --needed hyprwayland-scanner hyprland hyprpaper waybar fuzzel qt6ct qt6-wayland libva cpio cmake meson
	hyprpm update
	hyprpm add https://github.com/shezdy/hyprsplit
	hyprpm enable hyprsplit
	hyprpm reload

lockscreen: etc
	paru -Syu --needed --noconfirm physlock
	sudo systemctl enable lockscreen.service

fonts:
	paru -Syu --needed ttf-iosevka-nerd noto-fonts-emoji

snapper:
	paru -Syu --needed --noconfirm snapper snapper-rollback snap-pac

# Base (WSL)
# -----------------------------------------------------------------------------

base-wsl:
	paru -Syu --needed grub base-devel reflector xdg-user-dirs

tools-wsl:
	paru -Syu --needed unclutter feh mpv ffmpeg youtube-dl zathura \
		zathura-pdf-mupdf nodejs npm python python-pip \
		zoxide trash-cli

config:
	set IS_PERSONAL true
	cd ../../../.. && \
		make arch

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

# Install Waydroid: https://forum.garudalinux.org/t/ultimate-guide-to-install-waydroid-in-any-arch-based-distro-especially-garuda/15902
# Share personal-vaults folder: https://docs.waydro.id/faq/setting-up-a-shared-folder
# Fix /dev/anbox-binder not found issue: https://bbs.archlinux.org/viewtopic.php?id=286306 / https://github.com/waydroid/waydroid/issues/801
# Resizing hack: https://github.com/waydroid/waydroid/issues/70#issuecomment-927144567
waydroid:
	paru -Syu --needed --noconfirm linux-headers linux-lts-headers binder_linux-dkms waydroid
	printf "Add 'binder_linux' as a kernel in /etc/mkinitcpio.conf"
	printf "Then follow the rest of the instructions in https://forum.garudalinux.org/t/ultimate-guide-to-install-waydroid-in-any-arch-based-distro-especially-garuda/15902"
	printf "Afterwards, execute \
		sudo mkdir ~/.local/share/waydroid/data/media/0/personal-vault \
		sudo mount --bind ~/personal-vault/ ~/.local/share/waydroid/data/media/0/personal-vault \
		sudo waydroid shell appops set com.flyersoft.moonreader MANAGE_EXTERNAL_STORAGE allow \
		waydroid prop set persist.waydroid.multi_windows true \
		"

# P2P syncing
notes:
	paru -Syu syncthing obsidian anki
	sudo systemctl enable syncthing@$$USER

# Programming
# -----------------------------------------------------------------------------

mise:
	paru -Syu --needed mise usage

java: mise
	paru -Syu --needed maven
	mise use -g java@24

csharp: mise
	paru -Syu --needed omnisharp-roslyn
	mise use -g dotnet

postgres: docker
	paru -Syu --needed postgres
	# Initialise database through the postgres user created with the above command
	sudo -u postgres initdb -D /var/lib/postgres/data
	sudo systemctl start postgresql
	sudo systemctl enable postgresql
	# https://stackoverflow.com/questions/27107557/what-is-the-default-password-for-postgres
	# Have a look at the above to access postgres user and set its password
	# sudo -iu postgres
	# psql
	# ALTER USER postgres PASSWORD 'mynewpassword';
	# \q
	# exit

# https://ashpex.net/2021/06/how-to-install-flutter-on-arch-linux/
flutter:
	paru -Syu --needed jdk8-openjdk simple-mtpfs android-sdk \
		android-sdk-platform-tools android-sdk-build-tools android-platform \
		android-sdk-cmdline-tools-latest scrcpy
	git clone git@github.com:flutter/flutter.git ~/development/flutter
	curl https://github.com/qiuxiang/flutter-fish-completions/releases/latest/download/flutter.fish -Lo ~/.config/fish/completions/flutter.fish
	sudo groupadd android-sdk
	sudo gpasswd -a $$USER android-sdk
	sudo setfacl -R -m g:android-sdk:rwx /opt/android-sdk
	sudo setfacl -d -m g:android-sdk:rwX /opt/android-sdk
	# https://stackoverflow.com/questions/70173390/flutter-some-android-licenses-not-accepted-cannot-accept-licenses#70173740
	echo "Use root to execute 'sdkmanager --licenses'"

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
	paru -Syu --needed --noconfirm docker docker-desktop
	- sudo groupadd docker && usermod -aG docker $$USER && newgrp docker
	sudo systemctl enable docker.service

dockerosx: docker
	sudo systemctl enable containerd.service
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
