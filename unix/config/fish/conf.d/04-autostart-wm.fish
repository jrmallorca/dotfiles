if status is-login
    if [ -z "$DISPLAY" ] && [ (tty) = /dev/tty1 ]
        exec start-hyprland
    end
end
