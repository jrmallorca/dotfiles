# -----------------------------------------------------------------------------
# General Setup
# -----------------------------------------------------------------------------

.PHONY: all clean test

# -----------------------------------------------------------------------------
# Dot Files
# -----------------------------------------------------------------------------

# Transfer config files.
.PHONY: windows
windows:
	cd ./windows && make configuration

mac: unix is-personal
	cd ./unix/os/mac && make configuration

.PHONY: arch
arch: unix linux-gui is-personal

ubuntu: unix linux-gui is-personal
	cd ./unix/os/linux/ubuntu-20.04 && make configuration

termux: unix
	cd ./unix/os/linux/termux && make configuration

# Helpers
# -----------------------------------------------------------------------------

# Use `test` instead of directly calling `$IS_PERSONAL` just in case the
# variable becomes malicious (e.g., `rm -rf /`).
is-personal:
	- test "$$IS_PERSONAL" = 'true' && cp -a ./unix/config-personal/. ~/.config/

# Make should never assume that unix (the directory) is up to date
.PHONY: unix
unix:
	cp -a ./unix/config/. ~/.config/
	cp -a ./unix/scripts/. ~/bin/

linux-gui:
	cp -a ./unix/os/linux/config/. ~/.config/
