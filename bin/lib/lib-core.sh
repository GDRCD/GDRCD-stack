#!/bin/bash

# Set Library Name
LIB_NAME="lib-core.sh"

set -Eeo pipefail

# Check if STACK_DIR is set
if [[ ! "${STACK_DIR}" ]]; then
  echo "Please define 'STACK_DIR' variable"
  exit 1
fi

# Check if lib-core.sh is already imported
if [[ "${PROCESS_SOURCE[*]}" =~ $LIB_NAME ]]; then
  echo "Warning! '${LIB_NAME}' is already imported"
  exit 1
fi

# Add lib-core.sh to the list of imported files
PROCESS_SOURCE=("$LIB_NAME")

# ---------------------------------------------------------------------
# Variables
# ---------------------------------------------------------------------

#------------Directories--------------#
BIN_DIR="${STACK_DIR}/bin"
LIB_DIR="${STACK_DIR}/bin/lib"
COMMANDS_DIR="${STACK_DIR}/bin/commands"
DOCKER_DIR="${STACK_DIR}/.docker"

#------------Decoration-----------#
export c_default="\033[0m"
export c_blue="\033[1;34m"
export c_magenta="\033[1;35m"
export c_cyan="\033[1;36m"
export c_green="\033[1;32m"
export c_red="\033[1;31m"
export c_yellow="\033[1;33m"

#------------Trigger-----------#
need_help="false"
need_usage4help="false"
has_any_error="false"

# ------------Services--------------#
SERVICES_VARIANTS=("webserver" "database" "phpmyadmin" "mailhog")

# ---------------------------------------------------------------------
# Utilities
# ---------------------------------------------------------------------

# Check if env file exists
importEnv() {
  if [[ ! -f "${STACK_DIR}/.env" ]]; then
    prompt -e "Error! '.env' file is not found. Please create it first."
    exit 1
  fi

  # shellcheck source=.env
  source "${STACK_DIR}/.env"
}

# ---------------------------------------------------------------------
# Import Libraries
# ---------------------------------------------------------------------

importLib() {
  # Check if library exists
  if [[ ! -f "${BIN_DIR}/${1}" ]]; then
    prompt -e "Error! '${1}' is not found."
    exit 1
  fi

  # Check if library is already imported, if not import it
  if [[ ! "${PROCESS_SOURCE[*]}" =~ ${1} ]]; then
    # shellcheck source=bin/lib/lib-core.sh
    source "${BIN_DIR}/${1}"
    PROCESS_SOURCE+=("${1}")
  fi
}



