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
- 7 colored dots to identify terminal colors.
## How do I use it?
type ```betterfetch``` to run it

type ```betterfetchrc``` to edit the config file
## How do I install it?
### Linux
run this:
```
git clone https://github.com/sctech-tr/betterfetch.git && cd betterfetch && sudo make install
```
### Windows
install wsl and run the command above.
## How do I update it?
### Linux
run this:
```
rm -rf ~/betterfetch && git clone https://github.com/sctech-tr/betterfetch.git && cd betterfetch && sudo make install
```
### Windows
in wsl, run the command above.
## Will you provide a screenshot?
yes

![screenshot](https://github.com/user-attachments/assets/2ae9c117-38d0-4365-b5a4-585f18d455e9)
## Why is there no logo?
whenever i added a new line, i had to improve the drawing. i don't like ascii drawing, so I removed it. if you still want a logo, use something else.
## Where are the files?
/etc/betterfetchrc - config file

/usr/bin/betterfetch - betterfetch itself

/usr/bin/betterfetchrc - script to edit betterfetch config file
