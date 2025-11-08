# betterfetch 📜
## What's betterfetch? 
betterfetch is a fetch script used to quickly show system information in terminal. it's a fork of <a href="https://github.com/emilydaemon/zfetch">zfetch</a>.
## What does it show? 
currently it shows these:
- a red text saying "YOU ARE ROOT!!!!" if you ran it as root
- your username and your machine name.
- your os.
- your kernel.
- machine uptime.
- terminal shell.
- desktop environment.
- terminal emulator.
- your cpu.
- your init. (e.g. systemd)
- local ip.
- 7 colored dots to identify terminal colors.
## How do I use it?
type ```betterfetch``` to run it

type ```betterfetchrc``` to edit the config file
## How do I install it?
### Linux
#### Distros that use RPM
##### recommended method:
```
sudo dnf install dnf-plugins-core
sudo dnf copr enable sctech/betterfetch
sudo dnf install betterfetch
```
##### manual method:
download the latest rpm package from the releases page.
#### Debian-based distros
download the latest deb package from the releases page.
#### Other distros
run this:
```
git clone https://codeberg.org/sctech/betterfetch.git 
cd betterfetch
sudo make install
```
### Windows
install wsl and run the command above.
## How do I update it?
### Linux
#### Distros that use RPM:
##### if you used the recommended method:
run this:
```
sudo dnf update betterfetch
```
##### if you used the manual method:
download the latest rpm package from the releases page.
#### Debian-based distros
download the latest deb package from the releases page.
#### Other distros
run this:
```
rm -rf ~/betterfetch && git clone https://github.com/sctech-tr/betterfetch.git && cd betterfetch && sudo make install
```
### Windows
in wsl, run the command above.
## Will you provide a screenshot?
yes

![screenshot of betterfetch](https://github.com/user-attachments/assets/d68e3062-090b-493a-aaeb-52fbc2530476)

## Why is there no logo?
whenever i added a new line, i had to improve the drawing. i don't like ascii drawing, so I removed it. if you still want a logo, use something else.
## Where are the files?
/etc/betterfetchrc - config file

/etc/betterfetch-version - version file - do not delete!!

/usr/bin/betterfetch - betterfetch itself

/usr/bin/betterfetchrc - script to edit betterfetch config file
