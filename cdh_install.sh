#!/bin/bash

#TODO: MAYBE provide options for default locations, or an option to provide directory to symlink into
#TODO: Create options, and then replace installation/uninstallations/env script files all in one file by checking opts
#TODO: E.g, cdh --install, cdh --uninstall, cdh --env

RED='\033[0;31m'         # Red
GREEN='\033[0;32m'       # Green
COLOR_OFF='\033[0m'      # Text Reset
CHECKMARK="\xE2\x9C\x94" # Checkmark sign
X="\xE2\x9D\x8C"

GREEN_CHECK="${GREEN}${CHECKMARK}${COLOR_OFF}"
RED_CROSS="${RED}${X}${COLOR_OFF}"

# Checks if symbolic links to ${HOME}/.local/bin already exist, if not, creates them
checkSymLinks() {
	if [[ ! (-L "${HOME}/.local/bin/cd_history" && -L "$HOME/.local/bin/show_history" && -L "$HOME/.local/bin/cdh_env") ]]; then
		ln -s "$(pwd -P)/cd_history" "${HOME}/.local/bin" && ln -s "$(pwd -P)/show_history" "$HOME/.local/bin" && ln -s "$(pwd -P)/cdh_env" "$HOME/.local/bin"
		echo -e "\t${GREEN_CHECK} Creating symlinks in ${HOME}/.local/bin..."
	else
		echo -e "\n\t${RED_CROSS} There are already scripts in the ${HOME}/.local/bin folder with the same names:"
		echo -e "\t\t${RED}cd_history ${COLOR_OFF}and ${RED}show_history${COLOR_OFF}"
		echo -e "\tDue to this conflict, unable to proceed with install."
		echo -e "\tPlease rename/remove the mentioned existing files, then rerun this script.\n"

		return 1
	fi
}

# # Checks if ${HOME}/.local/bin already exists, if not, creates it
checkLocalBinDir() {
	if [ ! -d "${HOME}/.local/bin/" ]; then
		echo -e "\t${GREEN_CHECK} Creating ~/.local/bin directory..."
		mkdir "${HOME}/.local/bin"
	else
		echo -e "\t${GREEN_CHECK} Directory ${HOME}/.local/bin already exists, skipping..."
	fi
}
#
# Checks if ${HOME}/.local/bin is added to PATH, if not, adds it
checkPath() {
	if [[ ! ":${PATH}:" == *":${HOME}/.local/bin:"* ]]; then
		echo -e "\t${GREEN_CHECK} Adding ~/.local/bin to PATH..."
		export PATH=${PATH}:${HOME}/.local/bin
	else
		echo -e "\t${GREEN_CHECK} The path ~/.local/bin already exists in PATH, skipping..."
	fi
}

# Checks if ${HOME}/.cd_history file exists, if not, creates it
checkCdHistoryFile() {
	local CD_HISTORY_FILE_PATH="${HOME}/.cd_history"
	if [ ! -f "$CD_HISTORY_FILE_PATH" ]; then
		echo -e "\t${GREEN_CHECK} No ${HOME}/.cd_history file detected, creating one..."
		export CD_HISTORY_FILE_PATH="${HOME}/.cd_history"
		touch "${CD_HISTORY_FILE_PATH}"
		echo -e "\t${GREEN_CHECK} Created ${CD_HISTORY_FILE_PATH} file"
	else
		echo -e "\t${GREEN_CHECK} File ${HOME}/.cd_history file exists already, skipping..."
	fi
}

install() {
	cat <./logo.txt
	echo ""
	checkLocalBinDir
	checkSymLinks

	if [ $? -eq 1 ]; then
		return 1
	else
		checkPath
		checkCdHistoryFile
	fi

	echo -e "\n\tAdd the following into your ~/.zshrc or related config:"
	echo -e "\n\t\t${GREEN}source cdh_env${COLOR_OFF}"
}

install
