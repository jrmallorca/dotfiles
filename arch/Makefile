# -----------------------------------------------------------------------------
# Xubuntu Setup
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Dot Files
# -----------------------------------------------------------------------------

# Transfer config files.
config:
	cp -R .config ~

# Transfer theme related files.
# NEED TO CHANGE TO NOT OVERWIRTE EXISTING FILES/DIRECTORIES
theme:
	sudo cp -R backgrounds/ /usr/share/
	sudo cp -R themes/ /usr/share/
	sudo cp -R icons/ /usr/share/
	sudo cp -R fonts/ /usr/share/

# -----------------------------------------------------------------------------
# Programs
# -----------------------------------------------------------------------------

# yay
yay:
	sudo pacman -S git
	cd ~ && sudo git clone https://aur.archlinux.org/yay-git.git
	cd yay-git && makepkg -si

# Necessary
necessary:
	yay -S --needed grub base-devel reflector efibootmgr mtools dosfstools firefox \
		intel-ucode amd-ucode git neovim networkmanager network-manager-applet \
		xf86-video-amdgpu xf86-video-ati xf86-video-intel xf86-video-nouveau \
		xf86-video-vesa xdg-utils xdg-user-dirs openssh alacritty xorg-server \
		xorg-xinit i3-gaps i3status dmenu fish curl wget daemon xclip xsel \
		xdotool fzf fd bat ripgrep xcape unclutter tlp feh mpv ffmpeg \
		youtube-dl googler alsa-utils zathura zathura-pdf-mupdf redshift

# Install Vim-Plug. NeoVim configs must be set up.
# DOESN'T WORK IN MAKEFILE
vim-plug:
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

ticker:
	curl -Ls https://api.github.com/repos/achannarasappa/ticker/releases/latest \
	| grep -wo "https.*linux-amd64*.tar.gz" \
	| wget -qi - \
	&& tar -xf ticker*.tar.gz \
	&& chmod +x ./ticker \
	&& sudo mv ticker /usr/local/bin/

ohmyfish:
	curl -L https://get.oh-my.fish | fish

fisher:
	curl -sL https://git.io/fisher | . && fisher install jorgebucaran/fisher

fisherplugins:
	fisher install PatrickF1/fzf.fish

calcurse:
	sudo apt install libncurses5-dev
	wget https://calcurse.org/files/calcurse-4.7.0.tar.gz
	tar -xf calcurse-4.7.0.tar.gz
	cd calcurse-4.7.0/ && \
		.configure && make && sudo make install

pomo:
	curl -L -s https://kevinschoon.github.io/pomo/install.sh | bash /dev/stdin
	sudo mv pomo /usr/local/bin/

glow:
	wget https://github.com/charmbracelet/glow/releases/download/v1.3.0/glow_1.3.0_linux_amd64.deb
	sudo apt install ./glow_1.3.0_linux_amd64.deb
	rm glow_1.3.0_linux_amd64.deb

flutter:
	cd ~ && git clone https://github.com/flutter/flutter.git

# weechat (CLI messaging) and bitlbee (For facebook and other stuff)
# UNTESTED
# https://wiki.bitlbee.org/HowtoFacebookMQTT
# https://weechat.org/files/doc/stable/weechat_quickstart.en.html
weechat-bitlbee:
	sudo apt install weechat
	echo "deb http://download.opensuse.org/repositories/home:/jgeboski/xUbuntu_20.04 ./" > /etc/apt/sources.list.d/jgeboski.list
	wget -O- 'https://build.opensuse.org/projects/home:jgeboski/public_key' | sudo apt-key add -
	sudo apt update -y
	sudo apt install bitlbee-facebook

# Install terminal colour scheme changer
gogh:
	sudo apt install dconf-cli uuid-runtime
	bash -c "$(wget -qO- https://git.io/vQgMr)"

# Install autotiling for i3
autotiling:
	sudo apt install python3-pip git
	pip3 install i3ipc
	cd ~/gitapps/ && git clone git@github.com:olemartinorg/i3-alternating-layout.git

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
