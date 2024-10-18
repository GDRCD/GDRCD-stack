#!/usr/bin/env bash

# ---------------------------------------------------------------------
# Variables
# ---------------------------------------------------------------------

# Get current file name
CURRENT_FILE_NAME="$(basename "${BASH_SOURCE[0]}")"

# Save command name
args=("$@")
COMMAND_NAME="${args[0]}"

# ---------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------

# Function for showing usage of this command
usage() {
  helpify_title "test"
  helpify_subtitle "test"; echo;
  helpify_subtitle "OPTIONS:"
  helpify "-h, --help"          "Show this help"
}

# Function for showing usage of this command for help
usage4help() {
  helpify "test"       "test"
}

# ---------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------

#---------------------------PARSE ARGUMENTS-------------------------------#

# Parse arguments
while [[ $# -gt 0 ]]; do
  # if the argument is the command name, skip it
  if [[ "$1" == "${COMMAND_NAME}" ]]; then
    shift; continue
  fi

  #
  case "$1" in
    -h|--help)
      need_help="true"; shift ;;
    *)
      messageUnknownCommand "$COMMAND_NAME" "$1"; exit 1;;
  esac
done

# Execute post argument parsing checks
finalize_argument_parsing

#---------------------------RUN COMMAND-------------------------------#

test() {
  echo "Test"
}

# Run command if this file is the command file
if [[ "${COMMAND_NAME}" == "${CURRENT_FILE_NAME}" ]]; then
  tests
fi