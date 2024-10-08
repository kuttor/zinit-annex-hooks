#!/usr/bin/env zsh

#rufio - an auto at{loader, initer, puller, and cloner} ICE MODIFIER for Zinit and Zsh
#
#How? Rufio simply checks for files in a set folder via $RUFIO_HOOK_HOME 
#
#All that is required is to create the hook or hooks and store in that folder location
#using the following file naming convention: <repo-name>.<load, init, pull and/or clone>
#After that the you just configure that hook as you desire and boom, donzo.

# Example: touch $RUFIO_HOOK_HOME/repo.load # for a config file used with the atload ice.


# none of this is tailored for this project
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# Set up strict error handling
emulate -L zsh -o errexit -o pipefail -o nounset -o extendedglob -o warncreateglobal -o typesetsilent

# Define default hook directory if not set
: ${RUFIO_HOOK_HOME:="${XDG_CONFIG_HOME:-$HOME/.config}/rufio/hooks"}

# Function to process hooks
__rufio_process_hooks() {
    local repo_name="$1"
    local hook_type="$2"
    local hook_file="${RUFIO_HOOK_HOME}/${repo_name}.${hook_type}"

    if [[ -f "$hook_file" ]]; then
        print -P "%F{green}Rufio:%f Processing ${hook_type} hook for ${repo_name}"
        source "$hook_file"
    fi
}

# Main Rufio function
__rufio_atclone_hook() {
    local repo_dir="$1"
    local repo_name="${repo_dir:t}"

    __rufio_process_hooks "$repo_name" "clone"
}

__rufio_atpull_hook() {
    local repo_dir="$1"
    local repo_name="${repo_dir:t}"

    __rufio_process_hooks "$repo_name" "pull"
}

__rufio_atload_hook() {
    local repo_dir="$1"
    local repo_name="${repo_dir:t}"

    __rufio_process_hooks "$repo_name" "load"
}

__rufio_atinit_hook() {
    local repo_dir="$1"
    local repo_name="${repo_dir:t}"

    __rufio_process_hooks "$repo_name" "init"
}

# Define the rufio'' ice
__rufio_ice_init() {
    # This function initializes the ice modifier
    ZINIT_ICE[$1]="$2"
}

# Register the annex
zinit-annex-rufio() {
    # Register our ice modifier
    zinit-register-annex "rufio" \
        hook:atclone-50 \
        __rufio_atclone_hook \
        __rufio_ice_init \
        "rufio''" # The name of our ice

    # Register additional hooks
    zinit-register-hook "atpull" __rufio_atpull_hook
    zinit-register-hook "atload" __rufio_atload_hook
    zinit-register-hook "atinit" __rufio_atinit_hook
}

# Run the annex registration
zinit-annex-rufio

# Optionally, you can add an alias for easier usage
alias rufio="zinit ice rufio''"
