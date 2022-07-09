# -----------------------------------------------------------------------------
# General Setup
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Dot Files
# -----------------------------------------------------------------------------

# Transfer config files.
windows:
	cd ./windows && make configuration

mac: unix personal
	cd ./unix/os/mac && make configuration

arch: unix personal
	cd ./unix/os/linux/arch && make configuration

ubuntu: unix personal
	cd ./unix/os/linux/ubuntu-20.04 && make configuration

wsl-ubuntu: windows ubuntu

wsl-arch: windows arch

# Helpers
# -----------------------------------------------------------------------------

# Use `test` instead of directly calling `$IS_PERSONAL` just in case the
# variable becomes malicious (e.g., `rm -rf /`).
personal:
	test "$$IS_PERSONAL" = 'true' && cp -a ./config-personal/. ~/.config/

unix:
	cp -a ./unix/config/. ~/.config/
