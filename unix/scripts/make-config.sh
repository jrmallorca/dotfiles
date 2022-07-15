# Checks type of OS before making the appropriate configuration

#!/bin/bash
if command -v z &> /dev/null; then
    CD=z
else
    CD=cd
fi

echo $CD

case $OSTYPE in
    Linux)
        $CD ~/dotfiles && make arch
        ;;
    MacOS)
        $CD ~/dotfiles && make mac
        ;;
    WSL)
        $CD $USERPROFILE/dotfiles-work/ && make wsl-ubuntu
        ;;
    *)
        echo "Could not detect appropriate configuration for current OS"
        ;;
esac
