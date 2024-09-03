#!/bin/sh
# shellcheck source=/dev/null
# shellcheck disable=SC2059

# yes. no logos. because why not?

# source the config file
if [ "$colorsoff" = "" ]; then
	colorsoff=0
fi

[ -e /etc/betterfetchrc ] && . /etc/betterfetchrc 2> /dev/null
[ -e ~/.betterfetchrc ] && . ~/.betterfetchrc 2> /dev/null

CURRENT_VERSION_FILE="/etc/betterfetch-version"  # Path to the file containing the current version
REMOTE_VERSION_URL="https://raw.githubusercontent.com/sctech-tr/betterfetch/main/betterfetch-version"

# Fetch the remote version from the URL
REMOTE_VERSION=$(curl -s $REMOTE_VERSION_URL)

# Read the current version from the version file
if [ -f "$CURRENT_VERSION_FILE" ]; then
  CURRENT_VERSION=$(cat "$CURRENT_VERSION_FILE")
else
  echo "error: current version file not found."
  exit 1
fi

# Compare the remote version with the current version
if [ "$REMOTE_VERSION" != "$CURRENT_VERSION" ]; then
  echo "betterfetch $REMOTE_VERSION is available! you are currently on version $CURRENT_VERSION."
  exit 0
fi

# the meat and potatoes, actual fetch

# only set these if they are not already set by the config file
if [ -z "$os" ]; then
    . /etc/os-release 2>/dev/null
    os=$PRETTY_NAME  # Use PRETTY_NAME or NAME
fi
[ -z "$host" ] && host=$(cat /proc/sys/kernel/hostname)
[ -z "$kernel" ] && kernel=$(sed "s/version // ; s/ (.*//" /proc/version)
[ -z "$uptime" ] && uptime=$(uptime -p 2>/dev/null | sed "s/up //")
[ -z "$shell" ] && shell=$(printf "$SHELL" | sed "s/\/bin\///" | sed "s/\/usr//")
[ -z "$de" ] && de=$(echo $XDG_CURRENT_DESKTOP)
if [ -z "$terminal" ]; then
    terminals="konsole xterm gnome-terminal xfce4-terminal alacritty st urxvt terminator tilix kitty lxterminal yakuake"  # added yakuake
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


printf "$USER@$host\n"
printf "OS           ${nc} $os\n"
printf "Kernel       ${nc} $kernel\n"
printf "Uptime       ${nc} $uptime\n"
printf "Shell        ${nc} $shell\n"
printf "DE           ${nc} $de\n"
printf "Terminal     ${nc} $terminal\n"
if [ "$colorsoff" != 1 ]; then
	printf "${dslogo6}\033[0;31m● \033[0;32m● \033[0;33m● \033[0;34m● \033[0;35m● \033[0;36m● \033[0;37m●\033[0m\n"
fi
