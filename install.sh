#! /usr/bin/env bash

function ask_Yn() {
	read -p "$1 (Y/n) " resp
	if [ -z "${resp}" ]; then
		resp_lc="y"
	else
		resp_lc=$(echo "${resp}" | tr '[:upper:]' '[:lower:]')
	fi

	test "${resp_lc}" = "y"
}


cat <<EOF
Welcome to eirikff's nvim installer.

This script has three install steps:
1. Install the latest version of nvim from the unstable PPA
2. Install all dependencies for the nvim plugins
3. Install the nvim config from Github (assuming SSH access)
EOF

if ! ask_Yn "Do you want to continue installation?"; then
	echo "Aborting..."
	exit 0
fi

#### INSTALL NVIM FROM PPA ####
ppa="ppa:neovim-ppa/unstable"
sudo add-apt-repository ${ppa} --yes --no-update
sudo apt update


#### INSTALL DEPENDENCIES ####
sudo apt install neovim -yqq \
	build-essential \
	npm


#### INSTALL CONFIG REPO ####
repo="git@github.com:eirikff/nvim.git"
target="~/.config/nvim"

mkdir $(dirname ${target})
if [ -d ${target} ]; then
	mv ${target} ${target}.bak
	echo "Made old nvim config folder to ${target}.bak"
fi
git clone ${repo} ${target}


#### DONE ####
echo -e "\n\nInstallation done!\n\n"
exit 0

