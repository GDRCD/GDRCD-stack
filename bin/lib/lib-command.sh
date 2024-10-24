#!/bin/bash

# Set Library Name
LIB_NAME="lib-command.sh"

# Check if STACK_DIR is set
if [[ ! "${STACK_DIR}" ]]; then
  echo "Please define 'STACK_DIR' variable"; exit 1
fi

# Check if lib-core.sh is already imported
if [[ "${PROCESS_SOURCE[*]}" =~ $LIB_NAME ]]; then
  echo "Warning! '${LIB_NAME}' is already imported"; exit 1
fi

# Add lib-core.sh to the list of imported files
PROCESS_SOURCE=("$LIB_NAME")


# ---------------------------------------------------------------------
# Commands
# ---------------------------------------------------------------------

# check if is a command
isCommand() {
  case "${1}" in
    "--abs-path")
      ([[ -f "$2" ]] && command -v "$2") >/dev/null 2>&1;;
    *)
      ([[ -f "${COMMANDS_DIR}/$1" ]] && command -v "${COMMANDS_DIR}/$1") >/dev/null 2>&1;;
  esac
}

# check if is a service command
isServiceCommand() {
  # check if is a valid service
  if [[ ! "${SERVICES_VARIANTS[*]}" =~ $1 ]]; then
    return 1
  fi

  # check if exist directory
  if [[ ! -d "${COMMANDS_DIR}/$1" ]]; then
    return 1
  fi

  # check if directory contains at least one command
  if ! hasCommands "${COMMANDS_DIR}/$1"; then
    return 1
  fi

  return 0
}

# check if a directory contains at least one command
hasCommands() {
  for file in "${1}/"*; do
    if [[ -f "${file}" ]] && command -v "${file}" >/dev/null 2>&1; then
      return 0
    fi
  done
  return 1
}

# ---------------------------------------------------------------------
# Usage
# ---------------------------------------------------------------------

# Show commands
usageCommands () {
  helpify_subtitle "COMMANDS:";

  # scan bin directory for commands
  for command in "${COMMANDS_DIR}"/*; do
    # skip non-executable files
    if [[ ! -x "${command}" ]]; then
      continue
    fi

    # skip directories
    if [[ -d "${command}" ]]; then
      continue
    fi

    # check if is a command
    if ! isCommand --abs-path "${command}"; then
      continue
    fi

    # execute command to get usage
    # shellcheck disable=SC1090
    source "${command}"
  done
}

# Show commands for services
usageServicesCommands () {
  # scan bin sub-directories for commands
  for serviceDir in "${COMMANDS_DIR}"/*; do
    # get directory name
    service="$(basename "${serviceDir}")"
    # do usageServiceCommands, but if it fails, continue
    usageServiceCommands "${service}" || continue
  done
}

usageServiceCommands () {
  # get service name and directory
  local service="${1}"
  local serviceDir="${COMMANDS_DIR}/${service}"


  # skip non-directories
  if [[ ! -d "${serviceDir}" ]]; then
    return 1;
  fi

  # check if directory containains at least one command
  if ! hasCommands "${serviceDir}"; then
    return 1;
  fi

  # show title
  echo; helpify_subcommand_title "gdrcd-stack ${service}" "" "[OPTIONS...] COMMAND [OPTIONS...]";

  # scan bin sub-directories for commands
  for command in "${serviceDir}"/*; do
    # skip non-executable files
    if [[ ! -x "${command}" ]]; then
      return 1;
    fi

    # skip directories
    if [[ -d "${command}" ]]; then
      return 1;
    fi

    # check if is a command
    if ! isCommand --abs-path "${command}"; then
      return 1;
    fi

    # execute command to get usage
    # shellcheck disable=SC1090
    source "${command}"
  done
}

messageUnknownCommand () {
  # show error
  prompt -e "Unknown argument: $2";
  prompt -i "Try './gdrcd-stack $1 --help' for more information.";
}

# ---------------------------------------------------------------------
# Misc
# ---------------------------------------------------------------------

# TODO: rewrite this function to use a better approach
finalize_argument_parsing() {
  # if has_any_error is true, exit with error code
  if [[ "${has_any_error}" == "true" ]]; then
    prompt -i "Try './gdrcd-stack --help' for more information."; exit 1
  fi

  if [[ "${need_help}" == "true" ]]; then
    # Force to stop the script
    forceStop="true"

    # HELP > gdrcd-stack
    if [[ "${need_usage4help}" == "true" && "${1}" != "gdrcd-stack" ]]; then
      usage4help;
      # Continue the script execution
      forceStop="false"
    # HELP > gdrcd-stack > Command
    else
      usage;
    fi

    # if has_any_error is true, exit with error code
    if [[ "${has_any_error}" == "true" ]]; then
      exit 1
    fi
    # if forceStop is true, exit with success code
    if [[ "${forceStop}" == "true" ]]; then
      exit 0;
    fi
  fi
}