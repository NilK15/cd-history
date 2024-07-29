# Instructions

## Add the following to your ~/.zshenv or ~/.zshrc

```
# This is to use the bash scripts located in ~/scripts/bash
export CD_HISTORY_FILE_PATH="${HOME}/.cd_history"
```

## Create symlinks for the scripts into

```
~/.local/bin/
```

### Ensure ~/.local/bin is added to the PATH

```
export PATH=$PATH:$HOME/.local/bin
```
