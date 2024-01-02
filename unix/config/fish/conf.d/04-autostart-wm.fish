if status is-login
    if [ -z "$DISPLAY" ] && [ (tty) = /dev/tty1 ]
        exec Hyprland
    end
end
