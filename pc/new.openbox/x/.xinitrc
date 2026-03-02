#!/bin/sh

# load resources
for file in "/etc/X11/Xresources" "$HOME/.Xresources"; do
    if [ -f "$file" ]; then
        echo "[*] loading resource: $file"
        xrdb -nocpp -merge "$file"
    fi
done

# Load keymaps
for file in "/etc/X11/Xkbmap" "$HOME/.Xkbmap"; do
    if [ -f "$file" ]; then
        echo "[*] loading keymap: $file"
        setxkbmap `cat "$file"`
        XKB_IN_USE=yes
    fi
done

# Load xmodmap if not using XKB
if [ -z "$XKB_IN_USE" ]; then
    for file in "/etc/X11/Xmodmap" "/etc/X11/xinit/.Xmodmap" "$HOME/.Xmodmap"; do
        if [ -f "$file" ]; then
           echo "[*] loading modmap: $file"
           xmodmap "$file"
        fi
    done
fi

unset XKB_IN_USE

# start some nice programs
xinitdir="/etc/X11/xinit/xinitrc.d"
if [ -d "$xinitdir" ]; then
    for script in $xinitdir/*; do
        echo "[*] loading xinit script $script"
        if [ -x "$script" -a ! -d "$script" ]; then
            . "$script"
        fi
    done
fi

### blackarch ###
if dmesg | grep -qi virtualbox; then
    for arg in --checkhostversion --seamless --clipboard --vmsvga; do
        if command -v VBoxClient >/dev/null 2>&1; then
            /usr/bin/VBoxClient "$arg"
        fi
    done
fi

# importing xprofile
#[ -f /etc/xprofile ] && . /etc/xprofile
#[ -f ~/.xprofile ] && . ~/.xprofile
for file in "/etc/profile" "$HOME/.profile" "/etc/xprofile" "$HOME/.xprofile"; do
    if [ -f "$file" ]; then
        echo "[*] loading profile from $file";
        . "$file"
    fi
done

exec openbox-session
