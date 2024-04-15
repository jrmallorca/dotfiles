if not set -q MY_ABBR_SET
    set -U MY_ABBR_SET true
end

# (Un)mounting
abbr -a mntd 'sudo mount /dev/sda1 /mnt/d'
abbr -a umntd 'sudo umount /mnt/d'

# Edit
abbr -a eq 'z ~/qmk_firmware && zf -command search_edit'
abbr -a emd 'z /mnt/d && zf -command search_edit'
abbr -a evp 'z ~/personal-vault && zf -command search_edit'

# Navigate
abbr -a zq 'z ~/qmk_firmware && zf'
abbr -a zmd 'z /mnt/d && zf'
abbr -a zvp 'z ~/personal-vault && zf'

# Java versions
abbr -a j11 'sudo archlinux-java set java-11-openjdk'
abbr -a j18 'sudo archlinux-java set java-18-openjdk'

# QMK
abbr -a qc 'qmk compile'
abbr -a qca 'qmk clean -a'
abbr -a qf 'qmk flash'
