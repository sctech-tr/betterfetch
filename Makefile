SHELL = /bin/sh
help:
	@echo "make install      install betterfetch"
	@echo "make uninstall    remove betterfetch"

install:
	cp betterfetch.sh /usr/bin/betterfetch
	cp betterfetchrc.sh /usr/bin/betterfetchrc
	cp betterfetchrc /etc/betterfetchrc
	cp betterfetch-version /etc/betterfetch-version
	echo done!

uninstall:
	rm /usr/bin/betterfetch
	rm /usr/bin/betterfetchrc
	rm /etc/betterfetchrc
	rm /etc/betterfetch-version
	echo done!
