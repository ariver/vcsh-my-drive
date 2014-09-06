#! /bin/bash

MY_DRIVE_MODE="${1}"
MY_DRIVE_IMGP=my-drive.sparsebundle
MY_DRIVE_MNTP=my-drive

cd "${BASH_SOURCE%/*}"

{

    [[ -n "${MY_DRIVE_MODE}" || "${BASH_SOURCE##*/}" != *mount ]] \
        || MY_DRIVE_MODE="${BASH_SOURCE##*/}"

    case "${MY_DRIVE_MODE}" in

    ( "mount"* ) {

        printf '\n'
        hdiutil \
                attach \
                -stdinpass \
                ${MY_DRIVE_MNTP:+-mountpoint "${MY_DRIVE_MNTP}"} \
                ${MY_DRIVE_IMGP:+"${MY_DRIVE_IMGP}"}

        sleep 3

        my-drive/_my_d.bash mount

    };;

    ( "umount"* | "unmount"* ) {

        my-drive/_my_d.bash unmount

        sleep 3

        printf '\n'
        hdiutil \
                unmount \
                "${MY_DRIVE_MNTP}"

    };;

    ( * ) {

        printf "${BASH_SOURCE} %s" mount umount

    };;

    esac

} 1>&2
