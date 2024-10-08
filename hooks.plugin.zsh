#!/usr/bin/env zsh

# Define the main function for the annex
zinit-annex-hooks() {
    # Register the new ICE modifier
    zinit-register-annex "hooks" \
        hook:atclone-50 \
        __HOOKS_ATCLONE_HANDLER \
        __HOOKS_ICE_INIT \
        "hooks''" # The name of your new ICE

    # Register additional hooks if needed
    zinit-register-hook "atpull" __HOOKS_ATPULL_HANDLER
    zinit-register-hook "atload" __HOOKS_ATLOAD_HANDLER
    zinit-register-hook "atinit" __HOOKS_ATINIT_HANDLER
}

# Function to initialize the ICE
__HOOKS_ICE_INIT() {
    # This function initializes the ice modifier
    ZINIT_ICE[$1]="$2"
}

# Define handlers for each hook type
__HOOKS_ATCLONE_HANDLER() {
    local REPO_DIR="$1"
    local REPO_NAME="${REPO_DIR:t}"

    # Process the clone hook
    __HOOKS_PROCESS_HOOKS "$REPO_NAME" "clone"
}

__HOOKS_ATPULL_HANDLER() {
    local REPO_DIR="$1"
    local REPO_NAME="${REPO_DIR:t}"

    # Process the pull hook
    __HOOKS_PROCESS_HOOKS "$REPO_NAME" "pull"
}

__HOOKS_ATLOAD_HANDLER() {
    local REPO_DIR="$1"
    local REPO_NAME="${REPO_DIR:t}"

    # Process the load hook
    __HOOKS_PROCESS_HOOKS "$REPO_NAME" "load"
}

__HOOKS_ATINIT_HANDLER() {
    local REPO_DIR="$1"
    local REPO_NAME="${REPO_DIR:t}"

    # Process the init hook
    __HOOKS_PROCESS_HOOKS "$REPO_NAME" "init"
}

# Function to process hooks
__HOOKS_PROCESS_HOOKS() {
    local REPO_NAME="$1"
    local HOOK_TYPE="$2"
    local HOOK_FILE="${RUFIO_HOOK_HOME}/${REPO_NAME}.${HOOK_TYPE}"

    if [[ -f "$HOOK_FILE" ]]; then
        print -P "%F{green}Hooks:%f Processing ${HOOK_TYPE} hook for ${REPO_NAME}"
        source "$HOOK_FILE"
    fi
}

# Run the annex registration
zinit-annex-hooks

# Optionally, you can add an alias for easier usage
alias hooks="zinit ice hooks''"