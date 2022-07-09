# ----------------------------------------------------------------------------
# General Setup
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Dot Files
# -----------------------------------------------------------------------------

# Transfer config files.
arch:
	cd ./unix/os/linux/arch && make configuration

ubuntu:
	cd ./unix/os/linux/ubuntu-20.04 && make configuration

mac:
	cd ./unix/os/mac && make configuration

wsl-ubuntu:
	cd ./windows && make configuration
	cd ./unix/os/linux/ubuntu-20.04 && make configuration-wsl
