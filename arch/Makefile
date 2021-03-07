# -----------------------------------------------------------------------------
# Arch Setup
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Dot Files
# -----------------------------------------------------------------------------

# Transfer configuration files.
configuration:
	cp -a config/. ~/.config/
	cp .profile ~/
	cp .tmux.conf ~/

# Transfer theme related files.
theme:
	sudo cp -a ../backgrounds/ /usr/share/
	sudo cp -a ../themes/ /usr/share/
	sudo cp -a ../icons/ /usr/share/
	sudo cp -a ../fonts/ /usr/share/
	sudo cp bitlbee.conf /etc/bitlbee/
	sudo cp 40-libinput.conf /usr/share/X11/xorg.conf.d/
	sudo cp lightdm.conf /etc/lightdm/

# -----------------------------------------------------------------------------
# Programs
# -----------------------------------------------------------------------------

# Base
# -----------------------------------------------------------------------------

# paru (AUR Helper)
paru:
	sudo pacman -S --needed git base-devel
	cd ~ && sudo git clone https://aur.archlinux.org/paru.git && \
		cd paru && makepkg -si

# Necessary
necessary:
	paru -Syu --needed grub base-devel reflector efibootmgr mtools dosfstools firefox \
		intel-ucode amd-ucode git neovim networkmanager network-manager-applet \
		xf86-video-amdgpu xf86-video-ati xf86-video-intel xf86-video-nouveau \
		xf86-video-vesa xdg-utils xdg-user-dirs openssh alacritty xorg-server \
		xorg-xinit i3-gaps i3status i3lock perl-anyevent-i3 i3-resurrect xss-lock \
		dmenu fish curl wget daemon xclip xsel xdotool fzf fd bat ripgrep xcape \
		unclutter tlp feh mpv ffmpeg youtube-dl googler alsa-utils zathura \
		zathura-pdf-mupdf redshift nodejs npm python python-pip autotiling \
		dunst flameshot buku lxappearance-gtk3 gtk3 libinput xorg-xinput tmux
	npm install -g neovim
	pip install pynvim
	# systemctl enable NetworkManager
	# systemctl enable tlp
	# systemctl --user enable redshift.service # Doesn't have sys tray icon
	# systemctl --user enable redshift-gtk.service # Has sys tray icon

# Mount the D drive from Windows
mountd:
	paru -Syu --needed ntfs-3g
	mkdir -p /mnt/d
	echo "Copy this into etc/fstab: UUID=<uuid> /mnt/d ntfs uid=1000,gid=1000,umask=0022,sync,auto,rw 0 0"
	echo "Get UUID from the following command: lsblk -o NAME,FSTYPE,UUID" 
	echo "Do: sudo mount -av"

# Webkit2 greeter
greeter:
	paru -Syu --needed xorg-server xorg-xinit lightdm lightdm-webkit2-greeter \
		lightdm-webkit-theme-sequoia-git
	systemctl enable lightdm

# Install Vim-Plug. NeoVim configs must be set up.
# UNTESTED but likely works
vim-plug:
	curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# UNTESTED and probably doesn't work with 2nd line due to fish
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

ohmyfish:
	curl -L https://get.oh-my.fish | fish

# Doesn't work in Makefile
fisher:
	curl -sL https://git.io/fisher | . && fisher install jorgebucaran/fisher

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

# Programming
# -----------------------------------------------------------------------------

java:
	paru -Syu jre-openjdk jdk-openjdk #jdk8-openjdk

flutter:
	paru -Syu --needed jdk8-openjdk simple-mtpfs flutter android-sdk \
		android-sdk-platform-tools android-sdk-build-tools android-platform \
		scrcpy

# UNTESTED
# CHECK VERSION BEFORE MAKING
go:
	wget https://dl.google.com/go/go1.15.3.linux-amd64.tar.gz
	sudo tar -C /usr/local -xzf go1.15.3.linux-amd64.tar.gz
	rm go1.15.3.linux-amd64.tar.gz

latex:
	paru -Syu texlive-most

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

# CHANGE
# CHECK VERSION
calcurse:
	sudo apt install libncurses5-dev
	wget https://calcurse.org/files/calcurse-4.7.0.tar.gz
	tar -xf calcurse-4.7.0.tar.gz
	cd calcurse-4.7.0/ && \
		.configure && make && sudo make install

# CHANGE (or use another pomo)
pomo:
	curl -L -s https://kevinschoon.github.io/pomo/install.sh | bash /dev/stdin
	sudo mv pomo /usr/local/bin/
