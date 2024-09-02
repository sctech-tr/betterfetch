SHELL = /bin/sh

INSTALL_DIR = /usr/bin/
IN_NAME = betterfetch.sh
OUT_NAME = betterfetch

help:
	@echo "make install      install betterfetch"
	@echo "make uninstall    remove betterfetch."
	@echo "make rmconfig     remove betterfetch configuration files."

install:
	cp ${IN_NAME} ${INSTALL_DIR}${OUT_NAME}
	[ -e /etc/zshrc ] || cp betterfetchrc /etc/betterfetchrc
	cp betterfetch-version /etc/betterfetch-version

uninstall:
	rm ${INSTALL_DIR}${OUT_NAME}

rmconfig:
	rm /etc/betterfetchrc
