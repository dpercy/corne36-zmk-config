#!/usr/bin/env bash
set -xeuo pipefail

wait_until_sda_present() {
    while ! lsblk | grep -q sda
    do
        sleep 0.5
    done
}

wait_until_sda_absent() {
    while lsblk | grep -q sda
    do
        sleep 0.5
    done
}

flash_side() {
    side=$1

    lsblk
    wait_until_sda_present
    sudo mount /dev/sda /mnt/
    lsblk
    sudo cp firmware/corne_$side\ nice_view_adapter\ nice_view-nice_nano_v2-zmk.uf2 /mnt
    lsblk
    sudo umount /mnt
    wait_until_sda_absent
    lsblk
}

flash_side left
flash_side right
