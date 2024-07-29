# Instructions

## Add the following to your ~/.zshrc or wherever you set your env variables:

```
# Env variable used by the scripts
export CD_HISTORY_FILE_PATH="${HOME}/.cd_history"
```

## Create symlinks for the scripts into:

```
~/.local/bin/
```

### Ensure ~/.local/bin is added to the PATH in your configs (typically ~/.zshrc):

```
export PATH=$PATH:$HOME/.local/bin
```
