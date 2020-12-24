# -----------------------------------------------------------------------------
# Xubuntu Setup
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Dot Files
# -----------------------------------------------------------------------------
# Transfer config files.
config:
	cp -R dotfiles/.config ~

# Transfer bash config.
bash:
	cp dotfiles/.bashrc ~

# Transfer theme related files.
themes:
	cp -R dotfiles/.themes ~
	cp -R dotfiles/.icons ~

# -----------------------------------------------------------------------------
# Programs
# -----------------------------------------------------------------------------

# Install main programs.
general:
	sudo add-apt-repository ppa:kgilmer/speed-ricer
	sudo snap install --beta nvim --classic
	sudo apt-get install -y git cmake meson i3-gaps curl feh npm

# Install picom (compositor)
picom:
	sudo apt-get install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev
	cd ~
	git clone https://github.com/yshui/picom.git
	cd picom/
	git submodule update --init --recursive
	sudo meson --buildtype=release . build
	sudo ninja -C build
	sudo ninja -C build install

# Install propreitary software:
# Microsoft Teams
propreitary:
	sudo snap install teams
	# spotify

# Install Spotify Terminal UI.
spt:
	sudo snap install spt
	xdg-open https://developer.spotify.com/dashboard/login

# Install Spotifyd.
spotifyd:
	sudo apt install -y libasound2-dev libssl-dev libpulse-dev libdbus-1-dev
	git clone https://github.com/Spotifyd/spotifyd.git
	cd spotifyd && cargo build --release --no-default-features \
		--features pulseaudio_backend,dbus_mpris && \
		cp ../dotfiles/Cargo.toml . && \
		cargo install --path . --locked
	rm -Rf spotifyd

# Install Vim-Plug. NeoVim configs must be set up.
vim-plug:
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install Go.
go:
	wget https://dl.google.com/go/go1.15.3.linux-amd64.tar.gz
	sudo tar -C /usr/local -xzf go1.15.3.linux-amd64.tar.gz
	rm go1.15.3.linux-amd64.tar.gz

# Install Android Studios
android-studios:
	sudo snap install android-studio
