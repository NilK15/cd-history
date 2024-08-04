# IMPORTANT

This program replaces cd by overwriting it with an alias, if you are already
using cd as an alias, this will not work for you, unless you modify the
existing alias to something else.

## Instructions

### STEP 1: Ensure you are in the cd-history folder then run

```[BASH]

source ./cdh_install.sh

```

### STEP 2: Add the following to your configs (typically ```~/.zshrc```)

```[BASH]

# Env file containing variables used by the scripts
source cdh_env

```
