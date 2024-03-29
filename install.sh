#!/usr/bin/env bash

function green() {
	local string="$@"
	echo -e "\e[32m${string}\e[0m"
}

function ask_Yn() {
	if [ "${always_yes}" = "true" ]; then
		return 0
	fi 

	local prompt="$1 (Y/n) "
	read -p "$(green "${prompt}")" resp
	if [ -z "${resp}" ]; then
		resp_lc="y"
	else
		resp_lc=$(echo "${resp}" | tr '[:upper:]' '[:lower:]')
	fi

	[ "${resp_lc}" = "y" ]
}

function usage() {
	cat <<EOF
Usage:
	$0 [--start]

Arguments:
	--start: start install immediately
EOF
}

start_immediately=false
while [ "$#" -gt 0 ]; do
	case "$1" in
		--start)
			start_immediately=true
			;;
		*)
			echo "Unknown argument: $1"
			usage
			exit 1
			;;
	esac
	shift
done

cat <<EOF
Welcome to eirikff's nvim installer.

This script has three install steps:
1. Install the latest version of nvim from the unstable PPA
2. Install all dependencies for the nvim plugins
3. Install the nvim config from Github
EOF

if [ "${start_immediately}" = "false" ] && \
   ! ask_Yn "Do you want to continue installation?"; then
	echo $(green "Aborting...")
	exit 0
fi

#### INSTALL NVIM FROM PPA ####
ppa="ppa:neovim-ppa/unstable"
sudo add-apt-repository --yes --no-update ${ppa}
sudo apt update -yqq


#### INSTALL DEPENDENCIES ####
# We need nodejs and npm for Mason and several LSPs. However, the nodejs
# version in apt can be very old, install latest LTS repo first
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y neovim \
	build-essential \
	nodejs \
	ripgrep


#### INSTALL CONFIG REPO ####
if ask_Yn "Use SSH repo link?"; then
	repo="git@github.com:eirikff/nvim.git"
else 
	repo="https://github.com/eirikff/nvim.git"
fi
echo $(green "Using repo link: ${repo}")
target="$HOME/.config/nvim"

mkdir -p $(dirname ${target})  # mkdir parent
if [ -d ${target} ]; then
	pushd "${target}" &>/dev/null
	if git remote get-url $(git remote) | grep -e 'eirik-ff/nvim' &>/dev/null
	then
		git pull && git checkout main && \
			echo "$(green "Pulled latest changes from remote")"
	else
		mv ${target} ${target}.bak
		echo "$(green "Made old nvim config folder to ${target}.bak")"
		git clone ${repo} ${target}
	fi
else
	git clone ${repo} ${target}
	echo "$(green "Cloned repo from ${repo}")"
fi


#### DONE ####
echo -e "$(green "\n\nInstallation done!\n\n")"
exit 0

