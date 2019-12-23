#!/bin/bash
if (command -v adb) 2>/dev/null; then
    echo "adb installed"
    echo 'searching for sc-card path'
    #find sd-card path
    a="$(adb shell 'echo ${SECONDARY_STORAGE%%:*}')"
    a=$(echo "$a" | tr -d '\r')
    echo "sd-card path is: $a"
    b="/DCIM/Camera"
    c="$a$b"
    d=$(zenity  --file-selection --title="Choose a directory" --directory 2>/dev/null)
    if [ -z "$d" ]; then
        echo "user cancelled"
    else
        echo "selected folder: "$d""
        echo "pull from $c"
        echo 'copying ...'
        adb pull $c $d
        echo 'Finished!'
    fi
else
    echo "adb not installed, aborting!"
fi
