if not set -q MY_ABBR_SET
    set -U MY_ABBR_SET true

    # (Un)mounting
    abbr mntd 'sudo mount /dev/sda1 /mnt/d'
    abbr umntd 'sudo umount /mnt/d'

    # Edit
    abbr eq 'z ~/qmk_firmware && zf -command search_edit'
    abbr emd 'z /mnt/d && zf -command search_edit'

    # Navigate
    abbr zq 'z ~/qmk_firmware && zf'

    # Java versions
    abbr j11 'sudo archlinux-java set java-11-openjdk'
    abbr j18 'sudo archlinux-java set java-18-openjdk'

    # Chat
    abbr we weechat
    abbr wh whatscli
    abbr s scli

    # QMK
    abbr qc 'qmk compile'
    abbr qf 'qmk flash'
    abbr qc2j 'qmk c2json -km jrmallorca -kb rgbkb/sol3 -o jrmallorca.json ~/qmk_firmware/keyboards/rgbkb/sol3/keymaps/jrmallorca/keymap.c'
    abbr qj2c 'qmk json2c -o ~/qmk_firmware/keyboards/rgbkb/sol3/keymaps/jrmallorca/keymap.c'
end
