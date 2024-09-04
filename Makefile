SHELL = /bin/sh
help:
	@echo "make install      install betterfetch"
	@echo "make uninstall    remove betterfetch"

install:
	chmod +x betterfetchrc.sh
	cp betterfetch.sh /usr/bin/betterfetch
	cp betterfetchrc.sh /usr/bin/betterfetchrc
	cp betterfetchrc /etc/betterfetchrc
	cp betterfetch-version /etc/betterfetch-version

uninstall:
	rm /usr/bin/betterfetch
	rm /usr/bin/betterfetchrc
	rm /etc/betterfetchrc
	rm /etc/betterfetch-version

