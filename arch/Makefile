# -----------------------------------------------------------------------------
# Arch Setup
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Dot Files
# -----------------------------------------------------------------------------

# Transfer configuration files.
configuration:
	rm ~/.config/fish/fish_variables
	cp -a config/. ~/.config/
	cp .tmux.conf .xinitrc ~/

input:
	sudo cp 40-libinput.conf /usr/share/X11/xorg.conf.d/

# Transfer cron jobs
cron:
	sudo cp mirrorlist /etc/cron.daily/

# Transfer theme related files.
theme:
	sudo cp -a ../backgrounds/ /usr/share/
	sudo cp -a ../themes/ /usr/share/
	sudo cp -a ../icons/ /usr/share/
	sudo cp -a ../fonts/ /usr/share/
	sudo cp bitlbee.conf /etc/bitlbee/
	sudo cp lightdm.conf /etc/lightdm/

# -----------------------------------------------------------------------------
# Programs
# -----------------------------------------------------------------------------

# Base
# -----------------------------------------------------------------------------

# paru (AUR Helper)
paru:
	sudo pacman -S --needed git base-devel
	cd ~ && git clone https://aur.archlinux.org/paru.git && \
		cd paru && makepkg -si
	sudo rm -rf ~/paru/

# Necessary
necessary:
	paru -Syu --needed grub base-devel reflector firefox \
		intel-ucode amd-ucode git neovim networkmanager network-manager-applet \
		xf86-video-amdgpu xf86-video-ati xf86-video-intel xf86-video-nouveau \
		xf86-video-vesa xdg-utils xdg-user-dirs openssh alacritty xorg-server \
		xorg-xinit i3-gaps i3status i3lock perl-anyevent-i3 i3-resurrect xss-lock \
		dmenu fish curl wget daemon xclip xsel xdotool fzf fd bat ripgrep xcape \
		unclutter tlp feh mpv ffmpeg youtube-dl googler alsa-utils zathura \
		zathura-pdf-mupdf clight nodejs npm python python-pip autotiling \
		dunst flameshot buku lxappearance-gtk3 gtk3 libinput xorg-xinput tmux \
		github-cli bluez bluez-utils blueman lf devour zoxide ttc-iosevka-aile \
		ttc-iosevka-ss14
	npm install -g neovim
	pip install pynvim
	# systemctl enable NetworkManager
	# systemctl enable tlp
	# systemctl enable clightd.service
	# systemctl enable bluetooth.service
	# systemctl enable reflector.service
	# systemctl enable reflector.timer

necessary-paru:
	paru -Syu daemon clight lf devour zoxide

# Mount the D drive from Windows
mountd:
	paru -Syu --needed ntfs-3g
	sudo mkdir -p /mnt/d
	echo "Copy this into etc/fstab: UUID=<uuid> /mnt/d ntfs uid=1000,gid=1000,umask=0022,sync,auto,rw 0 0"
	echo "Get UUID from the following command: lsblk -o NAME,FSTYPE,UUID" 
	echo "Do: sudo mount -av"

# Webkit2 greeter
lightdm:
	paru -Syu --needed xorg-server xorg-xinit lightdm lightdm-webkit2-greeter \
		lightdm-webkit-theme-sequoia-git
	systemctl enable lightdm

ly:
	paru -Syu --needed ly
	sudo ssystemctl enable ly.service
	sudo systemctl disable getty@tty2.service
	cd ~/ && chmod +x .xinitrc

betterlockscreen:
	paru -Syu --needed betterlockscreen
	betterlockscreen -u "~/dotfiles/backgrounds/"

# Install Vim-Plug. NeoVim configs must be set up.
vim-plug:
	curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

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

# UNTESTED and probably doesn't work with 2nd line due to fish
# Should probably make it a script?
# Should check if there's no existing SSH key
gitsshkeys:
	ssh-keygen -t ed25519 -C "48072014+jrmallorca@users.noreply.github.com"
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_ed25519
	xclip -selection clipboard < ~/.ssh/id_ed25519.pub

# INCOMPLETE and doesn't do the last 2 lines in git docs
gitgpgkeys:
	git config --global gpg.program gpg2
	gpg2 --full-generate-key
	gpg2 --list-secret-keys --keyid-format LONG

# Doesn't work in Makefile
fisher:
	curl -sL https://git.io/fisher | . && fisher install jorgebucaran/fisher

spacefish:
	paru -Syu --needed powerline-fonts
	fisher install matchai/spacefish

fisherplugins:
	fisher install PatrickF1/fzf.fish

# Install picom (compositor)
picom:
	paru -Syu picom

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
	systemctl --user start spotifyd.service
	systemctl --user enable spotifyd.service

vm:
	paru -Syu --needed virtualbox virtualbox-guest-iso virtualbox-ext-oracle
	sudo modprobe vboxdrv
	sudo gpasswd -aG vboxusers $USER

torrent:
	paru -Syu  qbittorrent

# Programming
# -----------------------------------------------------------------------------

java:
	paru -Syu jre-openjdk jdk-openjdk #jdk8-openjdk

flutter:
	paru -Syu --needed jdk8-openjdk simple-mtpfs flutter android-sdk \
		android-sdk-platform-tools android-sdk-build-tools android-platform \
		scrcpy
	sudo groupadd flutterusers
	sudo gpasswd -a $USER flutterusers
	sudo chown -R :flutterusers /opt/flutter
	sudo chmod -R g+w /opt/flutter/
	sudo groupadd android-sdk
	sudo gpasswd -a $USER android-sdk
	sudo setfacl -R -m g:android-sdk:rwx /opt/android-sdk
	sudo setfacl -d -m g:android-sdk:rwX /opt/android-sdk

lsp:
	curl -fsSL https://deno.land/x/install/install.sh | sh

# Extra
# -----------------------------------------------------------------------------

# Microsoft Teams
teams:
	paru -Syu teams

# Stock watcher
ticker:
	curl -Ls https://api.github.com/repos/achannarasappa/ticker/releases/latest \
	| grep -wo "https.*linux-amd64*.tar.gz" \
	| wget -qi - \
	&& tar -xf ticker*.tar.gz \
	&& chmod +x ./ticker \
	&& sudo mv ticker /usr/local/bin/

# -----------------------------------------------------------------------------
# Programs
# -----------------------------------------------------------------------------

# Virtual MacOS
maccat:
	VBoxManage modifyvm "maccat" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
	VBoxManage setextradata "maccat" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac19,1"
	VBoxManage setextradata "maccat" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
	VBoxManage setextradata "maccat" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Mac-AA95B1DDAB278B95"
	VBoxManage setextradata "maccat" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
	VBoxManage setextradata "maccat" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1
	VBoxManage setextradata "maccat" VBoxInternal2/EfiGraphicsResolution 1920x1080
