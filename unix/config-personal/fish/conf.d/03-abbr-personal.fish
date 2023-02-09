if not set -q MY_ABBR_SET
    set -U MY_ABBR_SET true
end

# (Un)mounting
abbr mntd 'sudo mount /dev/sda1 /mnt/d'
abbr umntd 'sudo umount /mnt/d'

# Edit
abbr eq 'z ~/qmk_firmware && zf -command search_edit'
abbr emd 'z /mnt/d && zf -command search_edit'
abbr evp 'z ~/Documents/personal-vault && zf -command search_edit'

# Navigate
abbr zq 'z ~/qmk_firmware && zf'
abbr zmd 'z /mnt/d && zf'
abbr zvp 'z ~/Documents/personal-vault && zf'

# Java versions
abbr j11 'sudo archlinux-java set java-11-openjdk'
abbr j18 'sudo archlinux-java set java-18-openjdk'

# Chat
abbr we weechat
abbr wh whatscli
abbr s scli

# QMK
abbr qc 'qmk compile'
abbr qca 'qmk clean -a'
abbr qf 'qmk flash'
