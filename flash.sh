#!/usr/bin/env bash
set -xeuo pipefail

flash_side() {
    watch -g lsblk
    sudo mount /dev/sda /mnt/
    lsblk
    sudo cp firmware/corne_$side\ nice_view_adapter\ nice_view-nice_nano_v2-zmk.uf2
    /mnt
    lsblk
    sudo umount /mnt
    lsblk
}

flash_side left
flash_side right
