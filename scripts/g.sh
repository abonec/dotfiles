#!/bin/sh

g () {
    # Usage
    if [ "$1" = "--help" -o "$1" = "-h" ]; then
        echo "Usage: g bookmark [value]"
        return
    fi

    # Make sure file exists
    local gfile="$HOME/.g"
    [ -f "$gfile" ] || touch "$gfile"

    # List all bookmarks
    if [ $# -eq 0 ]; then
        cat "$gfile" | column -t
        return
    fi

    # jump to a bookmark
    if [ $# -eq 1 ]; then
        dest=$(grep "^$1" "$gfile" | head -n 1 | cut -d " " -f 2-)
        if [ "$dest" != "" ]; then
            cd "$dest"
            return
        else
            echo "Unknown bookmark: $1"
            return
        fi
    fi

    # add or delete a bookmark
    if [ $# -gt 1 ]; then
        sed -i "/^$1[[:space:]]/d" "$gfile"
        [ $2 = "-" ] && return
        echo "$*" >> "$gfile"
        sort -o "$gfile" "$gfile"
    fi
}

# if [ -n "$ZSH_VERSION" ]; then
#     function g-compctl() { reply=(`g | awk '{print $1}'`) }
#     compctl -K g-compctl g
# fi
