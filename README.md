# Instructions

## Add the following to your ~/.zshenv or ~/.zshrc:

```
# Env variable used by the scripts
export CD_HISTORY_FILE_PATH="${HOME}/.cd_history"
```

## Create symlinks for the scripts into:

```
~/.local/bin/
```

### Ensure ~/.local/bin is added to the PATH. Paste this in your config (~/.zshrc typically):

```
export PATH=$PATH:$HOME/.local/bin
```
