#!/bin/bash
# shellcheck source=/dev/null
# shellcheck disable=SC2059
# yes. no logos. because why not?
# source the config file
colorsoff=${colorsoff:-0}
nc="\033[0m"  # Define the 'nc' (no color) variable

[ -r /etc/betterfetchrc ] && . /etc/betterfetchrc 2> /dev/null
[ -r ~/.betterfetchrc ] && . ~/.betterfetchrc 2> /dev/null

CURRENT_VERSION_FILE="/etc/betterfetch-version"  # Path to the file containing the current version
REMOTE_VERSION_URL="https://raw.githubusercontent.com/sctech-tr/betterfetch/main/betterfetch-version"

# Fetch the remote version from the URL
if ! REMOTE_VERSION=$(curl -s "$REMOTE_VERSION_URL"); then
    echo "Error: Failed to fetch remote version."
    exit 1
fi

# Read the current version from the version file
if [ -f "$CURRENT_VERSION_FILE" ]; then
    CURRENT_VERSION=$(cat "$CURRENT_VERSION_FILE")
else
    echo "Error: Current version file not found."
    exit 1
fi

# Compare the remote version with the current version
if [ "$REMOTE_VERSION" != "$CURRENT_VERSION" ]; then
    echo "betterfetch $REMOTE_VERSION is available! You are currently on version $CURRENT_VERSION."
    exit 0
fi

if [ "$USER" = "root" ]; then
    echo -e "\033[31mYOU ARE ROOT!!!!\033[0m"
fi

# the meat and potatoes, actual fetch
# only set these if they are not already set by the config file
if [ -z "$os" ]; then
    . /etc/os-release 2>/dev/null
    os=$PRETTY_NAME  # Use PRETTY_NAME or NAME
fi
[ -z "$host" ] && host=$(cat /proc/sys/kernel/hostname)
[ -z "$kernel" ] && kernel=$(sed "s/version // ; s/ (.*//" /proc/version)
[ -z "$uptime" ] && uptime=$(uptime -p 2>/dev/null | sed "s/up //" || echo "Unknown")
[ -z "$shell" ] && shell=$(printf "%s" "$SHELL" | sed "s/\/bin\///" | sed "s/\/usr//")
[ -z "$de" ] && de=$XDG_CURRENT_DESKTOP
if [ -z "$terminal" ]; then
    terminals="konsole xterm gnome-terminal xfce4-terminal alacritty st urxvt terminator tilix kitty lxterminal yakuake"
    terminal="unknown"
    cur=$$
    while cur=$(ps -o ppid:1= -p "$cur") && ((cur)); do
        comm=$(<"/proc/$cur/comm")
        if [[ " $terminals " = *" $comm "* ]]; then
            terminal=$comm
            break
        fi
    done
fi
[ -z "$ip" ] && ip=$(ip -f inet a | awk '/inet / { print $2 }' | tail -n 1 | sed 's/\/.*//')
[ -z "$cpu" ] && cpu=$(grep "model name" /proc/cpuinfo | head -n 1 | cut -d ':' -f 2 | sed 's/^[ \t]*//')
if [ -z "$init" ]; then
    if [[ -f "/lib/systemd/systemd" ]]; then
        init="systemd"
    elif [[ -f "/sbin/openrc" ]]; then
        init="OpenRC"
    elif [[ -f "/usr/bin/runit" ]]; then
        init="runit"
    elif [[ -f "/usr/bin/s6-rc" ]]; then
        init="s6"
    elif [[ -f "/etc/systemd/user.conf" ]]; then
        init="systemd"
    else
        init="Unknown"
    fi
fi

printf "%s@%s\n" "$USER" "$host"
printf "OS           %s %s\n" "${nc}" "$os"
printf "Kernel       %s %s\n" "${nc}" "$kernel"
printf "Uptime       %s %s\n" "${nc}" "$uptime"
printf "Shell        %s %s\n" "${nc}" "$shell"
printf "DE           %s %s\n" "${nc}" "$de"
printf "Terminal     %s %s\n" "${nc}" "$terminal"
printf "CPU          %s %s\n" "${nc}" "$cpu"
printf "Init         %s %s\n" "${nc}" "$init"
printf "Local IP     %s %s\n" "${nc}" "$ip"

if [ "$colorsoff" != 1 ]; then
    printf "\033[0;31m● \033[0;32m● \033[0;33m● \033[0;34m● \033[0;35m● \033[0;36m● \033[0;37m●\033[0m\n"
fi
