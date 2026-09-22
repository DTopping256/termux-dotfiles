#!/usr/env/bin bash

set -euo pipefail

pkg install git -y
pkg install make -y

git clone --depth=1 https://github.com/DTopping256/termux-dotfiles "${TMPDIR}/dotfiles"
make -f "${TMPDIR}/dotfiles/Makefile"
