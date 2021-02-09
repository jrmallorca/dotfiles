# -----------------------------------------------------------------------------
# Arch Setup
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Dot Files
# -----------------------------------------------------------------------------

# Transfer config files.
config:
	cp -a config/. ~/.config
	cp .profile ~

# Transfer theme related files.
# NEED TO CHANGE TO NOT OVERWRITE EXISTING FILES/DIRECTORIES
theme:
	sudo cp -a ../backgrounds/ /usr/share/
	# sudo cp -a ../themes/ /usr/share/
	# sudo cp -a ../icons/ /usr/share/
	sudo cp -a ../fonts/ /usr/share/
	sudo cp bitlbee.conf /etc/bitlbee/

# -----------------------------------------------------------------------------
# Programs
# -----------------------------------------------------------------------------

# Think about moving to paru
# yay
yay:
	sudo pacman -S --needed git
	cd ~ && sudo git clone https://aur.archlinux.org/yay-git.git && \
	cd yay-git && makepkg -si

# Necessary
necessary:
	yay -S --needed grub base-devel reflector efibootmgr mtools dosfstools firefox \
		intel-ucode amd-ucode git neovim networkmanager network-manager-applet \
		xf86-video-amdgpu xf86-video-ati xf86-video-intel xf86-video-nouveau \
		xf86-video-vesa xdg-utils xdg-user-dirs openssh alacritty xorg-server \
		xorg-xinit i3-gaps i3status xss-lock dmenu fish curl wget daemon xclip xsel \
		xdotool fzf fd bat ripgrep xcape unclutter tlp feh mpv ffmpeg \
		youtube-dl googler alsa-utils zathura zathura-pdf-mupdf redshift nodejs \
		npm python python-pip autotiling dunst flameshot buku
	npm install -g neovim
	pip install pynvim
	# systemctl enable NetworkManager
	# systemctl enable tlp
	# systemctl --user enable redshift.service # Doesn't have sys tray icon
	# systemctl --user enable redshift-gtk.service # Has sys tray icon

mountd:
	yay -S --needed ntfs-3g
	mkdir -p /mnt/d
	echo "Copy this into etc/fstab: UUID=<uuid> /mnt/d ntfs uid=1000,gid=1000,umask=0022,sync,auto,rw 0 0"
	echo "Get UUID from lsblk -o NAME,FSTYPE,UUID" 
	echo "Do: sudo mount -av"

# Change to slick greeter? (webkit2 greeter slow but pretty)
greeter:
	yay -S --needed xorg-server xorg-xinit lightdm lightdm-webkit2-greeter lightdm-webkit-theme-sequoia-git
	systemctl enable lightdm

# Spotify TUI
spotify:
	yay -S --needed spotifyd spotify-tui
	echo "Make the .config/spotifyd/spotifyd.conf for the login"
	systemctl --user start spotifyd.service
	systemctl --user enable spotifyd.service

# For some reason CMake fails on the lib32-libjpeg
maya:
	yay -S --needed libjpeg lib32-libjpeg libjpeg6 openssl-1.0 openssl audiofile xorg-fonts-misc libxp \
		python2 python2-backports ld-lsb lsb-release cpio xorg-fonts-100dpi xorg-fonts-75dpi xorg-fonts \
		gsfonts adobe-source-code-pro-fonts xorg-xlsfonts xorg-fonts-type1 libtiff ruby libpng15

# Install Vim-Plug. NeoVim configs must be set up.
# UNTESTED but likely works
vim-plug:
	curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# UNTESTED and probably doesn't work with 2nd line due to fish
gitsshkeys:
	ssh-keygen -t ed25519 -C "isysrmallorca@gmail.com"
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_ed25519
	xclip -selection clipboard < ~/.ssh/id_ed25519.pub

# Stock watcher
ticker:
	curl -Ls https://api.github.com/repos/achannarasappa/ticker/releases/latest \
	| grep -wo "https.*linux-amd64*.tar.gz" \
	| wget -qi - \
	&& tar -xf ticker*.tar.gz \
	&& chmod +x ./ticker \
	&& sudo mv ticker /usr/local/bin/

ohmyfish:
	curl -L https://get.oh-my.fish | fish

# Doesn't work in Makefile
fisher:
	curl -sL https://git.io/fisher | . && fisher install jorgebucaran/fisher

fisherplugins:
	fisher install PatrickF1/fzf.fish

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

flutter:
	cd ~ && git clone https://github.com/flutter/flutter.git

# weechat (CLI messaging) and bitlbee (For facebook and other stuff)
# http://thedarnedestthing.com/weechat%20+%20bitlbee
# https://zanshin.net/2015/01/10/a-guide-for-setting-up-weechat-and-bitlbee/
# https://wiki.bitlbee.org/HowtoFacebookMQTT
# https://weechat.org/files/doc/stable/weechat_quickstart.en.html
weechat-bitlbee:
	yay -S --needed weechat bitlbee bitlbee-facebook aspell lua tcl ruby libotr
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

# Install picom (compositor)
picom:
	sudo apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev
	cd ~/gitapps/ && git clone git@github.com:yshui/picom.git && \
		cd picom/ && git submodule update --init --recursive && \
		sudo meson --buildtype=release . build && \
		sudo ninja -C build && \
		sudo ninja -C build install

# Install Go.
# UNTESTED
# CHECK VERSION BEFORE MAKING
go:
	wget https://dl.google.com/go/go1.15.3.linux-amd64.tar.gz
	sudo tar -C /usr/local -xzf go1.15.3.linux-amd64.tar.gz
	rm go1.15.3.linux-amd64.tar.gz

# Install propreitary software:
# Microsoft Teams
proprietary:
	yay -S teams
