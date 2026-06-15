#!/usr/bin/env bash
set -xeuo pipefail

disk=/dev/disk/by-label/NICENANO

wait_until_disk_present() (
    set +x
    while [ ! -b $disk ]
    do
        sleep 0.5
    done
)

wait_until_disk_absent() (
    set +x
    while [ -b $disk ]
    do
        sleep 0.5
    done
)

flash_side() {
    side=$1

    lsblk
    wait_until_disk_present
    sudo mount $disk /mnt/
    lsblk
    sudo cp firmware/corne_$side\ nice_view_adapter\ nice_view-nice_nano_v2-zmk.uf2 /mnt
    lsblk
    sudo umount /mnt
    wait_until_disk_absent
    lsblk
}

flash_side left
flash_side right
