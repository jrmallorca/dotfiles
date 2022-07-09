# -----------------------------------------------------------------------------
# General Setup
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Dot Files
# -----------------------------------------------------------------------------

# Transfer config files.
arch: personal
	cd ./unix/os/linux/arch && make configuration

ubuntu: personal
	cd ./unix/os/linux/ubuntu-20.04 && make configuration

mac: personal
	cd ./unix/os/mac && make configuration

wsl-ubuntu: personal
	cd ./windows && make configuration
	cd ./unix/os/linux/ubuntu-20.04 && make configuration-wsl

# Helpers
# -----------------------------------------------------------------------------

# Use `test` instead of directly calling `$IS_PERSONAL` just in case the
# variable becomes malicious (e.g., `rm -rf /`).
personal:
	test "$$IS_PERSONAL" = 'true' && cp -a ./config-personal/. ~/.config/
