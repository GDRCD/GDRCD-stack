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

getVersion() {
  cat "${STACK_DIR}/version" | tr -d 'v'
}

checkVersion() {
  # Get the version from version file
  local version
  version=$(cat "${STACK_DIR}/version" | tr -d 'v')

  # Check if the version is the latest check last release on github
  local latest_version
  latest_version=$(curl -s "https://github.com/GDRCD/GDRCD-stack/releases" | grep -o "v[0-9]*\.[0-9]*\.[0-9]*" | head -n 1 | tr -d 'v')

  # Remove the point from the version and compare the two versions
  if [[ "${version//./}" -lt "${latest_version//./}" ]]; then
    prompt -w "Warning! A new version is available. Please update the stack."
    prompt -w "Current version: ${version} - Latest version: ${latest_version}"
  fi
}

# ---------------------------------------------------------------------
# Imports Methods
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

importEnv() {
  # Check if env file exists
  if [[ ! -f "${STACK_DIR}/.env" ]]; then
    prompt -e "Error! '.env' file is not found. Please create it first."
    exit 1
  fi

  # shellcheck source=.env
  source "${STACK_DIR}/.env"
}

