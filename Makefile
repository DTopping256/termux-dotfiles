SHELL := bash
MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
PATH_DIR := $(dir $(MAKEFILE_PATH))
CWD := $$(expr substr $(PATH_DIR) 1 $$(expr $$(expr length $(PATH_DIR)) - 1))

.SILENT:

# ---------------

all: install-zsh install-omz install-openssh copy-dotfiles

install-curl:
	pkg install curl -y

# ---------------

install-zsh:
	pkg install zsh -y
	chsh -s "$$(which zsh)"

install-omz: install-curl
	rm -fr "${HOME}/.oh-my-zsh/"
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"  "" --unattended 2>&1 1>/dev/null
	cp -r "${CWD}/.oh-my-zsh/custom" "${HOME}/.oh-my-zsh/"  
	find "${HOME}/.oh-my-zsh/" -name .gitkeep -type f | xargs rm

install-openssh:
	pkg install openssh -y

copy-dotfiles:
	find ${CWD} -maxdepth 1 -name "\.*" -type f | grep -v '\.git' | xargs -I {} cp {} ${HOME}
