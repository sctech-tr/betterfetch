#!/bin/bash
# shellcheck source=/dev/null
# shellcheck disable=SC2059

# Source the config file
colorsoff=${colorsoff:-0}
[ -r /etc/betterfetchrc ] && . /etc/betterfetchrc 2>/dev/null
[ -r "${HOME}/.betterfetchrc" ] && . "${HOME}/.betterfetchrc" 2>/dev/null

CURRENT_VERSION_FILE="/etc/betterfetch-version"
REMOTE_VERSION_URL="https://raw.githubusercontent.com/sctech-tr/betterfetch/main/betterfetch-version"

# Fetch the remote version from the URL
if ! REMOTE_VERSION=$(curl -s "$REMOTE_VERSION_URL"); then
    echo "Error: Failed to fetch remote version." >&2
    exit 1
fi

# Read the current version from the version file
if [ -f "$CURRENT_VERSION_FILE" ]; then
    CURRENT_VERSION=$(cat "$CURRENT_VERSION_FILE")
else
    echo "Error: Current version file not found." >&2
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

# The meat and potatoes, actual fetch
# Only set these if they are not already set by the config file
if [ -z "$os" ]; then
    . /etc/os-release 2>/dev/null
    os=${PRETTY_NAME:-$NAME}
fi

host=${host:-$(cat /proc/sys/kernel/hostname)}
kernel=${kernel:-$(uname -r)}
uptime=${uptime:-$(uptime -p 2>/dev/null | sed "s/up //" || echo "Unknown")}
shell=${shell:-$(basename "$SHELL")}
de=${de:-$XDG_CURRENT_DESKTOP}

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

ip=${ip:-$(ip -4 addr show scope global | awk '/inet/ {print $2}' | cut -d/ -f1 | head -n1)}
cpu=${cpu:-$(grep "model name" /proc/cpuinfo | head -n 1 | cut -d ':' -f 2 | sed 's/^[ \t]*//')}

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
printf "OS           %s\n" "$os"
printf "Kernel       %s\n" "$kernel"
printf "Uptime       %s\n" "$uptime"
printf "Shell        %s\n" "$shell"
printf "DE           %s\n" "$de"
printf "Terminal     %s\n" "$terminal"
printf "CPU          %s\n" "$cpu"
printf "Init         %s\n" "$init"
printf "Local IP     %s\n" "$ip"

if [ "$colorsoff" != 1 ]; then
    printf "\033[0;31m● \033[0;32m● \033[0;33m● \033[0;34m● \033[0;35m● \033[0;36m● \033[0;37m●\033[0m\n"
fi
