#TODO: MAYBE provide options for default locations, or an option to provide directory to symlink into

# Checks if cd_history and show_history already exist in $HOME/.local/bin
if [[ ! -f "$HOME/.local/bin/cd_history && $HOME/.local/bin/show_history" ]]; then
	ln -s cd_history . && ln -s show_history .

	# Checks if alias cd already exists, if not, creates it
	if [[ $(alias cd) == "source cd_history" ]]; then
		echo "alis cd is already set correctly, skipping..."
	elif alias cd; then
		echo "An alias is already defined for cd. Please remove that alias so this installation can redfine it to work
	with cd-history"
		return 1
	elif alias cd; then
		echo "Creating cd alias (alias cd='source cd_history'..."
		alias cd="source cd_history"
	fi

	# Checks if $HOME/.local/bin already exists, if not, creates it
	if [ ! -d "$HOME/.local/bin/" ]; then
		echo "Creating ~/.local/bin directory"
		mkdir "$HOME/.local/bin"
	else
		echo "Directory $HOME/.local/bin already exists, skipping..."
	fi

	# Checks if $HOME/.local/bin is added to PATH, if not, adds it
	if [[ ! "$PATH" == ?(*:)"$HOME/.local/bin"?(:*) ]]; then
		echo "Adding ~/.local/bin to PATH"
		export PATH=$PATH:/Users/sunil/.local/bin
	else
		echo "The ~/.local/bin path is already in PATH, skipping..."
	fi

	# Checks if CD_HISTORY_FILE_PATH env exists already, if not, creates it
	if printenv CD_HISTORY_FILE_PATH; then
		echo "CD_HISTORY_FILE_PATH already exists, skipping..."
	fi

	# Checks if $HOME/.cd_history file exists, if not, creates it
	if [ ! -f "$CD_HISTORY_FILE_PATH" ]; then
		echo "No $HOME/.cd_history file detected, creating one..."
		export CD_HISTORY_FILE_PATH="${HOME}/.cd_history"
		touch "${CD_HISTORY_FILE_PATH}"
		echo -e "\nCreated ${CD_HISTORY_FILE_PATH} file"
	fi

else
	echo -e "Seems there are already scripts in the $HOME/.local/bin folder with the same name, due to conflict, unable to install. \nPlease rename/remove the existing scripts in $HOME/.local/bin named cd_history and/or show_history, then rerun this script."
	return 1
fi
