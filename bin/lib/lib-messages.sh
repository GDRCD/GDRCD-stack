#!/bin/bash

# Set Library Name
LIB_NAME="lib-messages.sh"

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
# Messages
# ---------------------------------------------------------------------

# Messages
MESSAGE_OPTIONS_ERROR="--error"
MESSAGE_OPTIONS_WARNING="--warning"
MESSAGE_OPTIONS_INFO="--info"
MESSAGE_OPTIONS_INFO_STATUS="--info-status"
MESSAGE_OPTIONS_SUCCESS="--success"
MESSAGE_OPTIONS=("$MESSAGE_OPTIONS_ERROR" "$MESSAGE_OPTIONS_WARNING" "$MESSAGE_OPTIONS_INFO" "$MESSAGE_OPTIONS_SUCCESS" "$MESSAGE_OPTIONS_INFO_STATUS")

# Errors
MESSAGE_OPTIONS_NOT_SET="Message is not set"
MESSAGE_NO_ARGUMENTS="No arguments passed!"

# ---------------------------------------------------------------------
# Utilities
# ---------------------------------------------------------------------

# Echo a message in a specific color
prompt()
{
  case "${1}" in
    "-s")
      echo -e "  ${c_green}${2}${c_default}" ;;       # print success message
    "-e")
      echo -e "  ${c_red}${2}${c_default}" ;;         # print error message
    "-w")
      echo -e "  ${c_yellow}${2}${c_default}" ;;      # print warning message
    "-i")
      echo -e "  ${c_cyan}${2}${c_default}" ;;        # print info message
    "-il")
      echo -e "  ${c_blue}${2}${c_default}" ;;        # print info low message
  esac
}

# Funzione per stampare un messaggio
message()
{
  # Check if message type is valid
  if [[ ! "${MESSAGE_OPTIONS[*]}" =~ $1 ]]; then
    message --error "Message type '${1}' is not valid"; exit 1
  fi

  # Check if message is set
  if [[ ! "${2}" ]]; then
    message --error "$MESSAGE_OPTIONS_NOT_SET"; exit 1
  fi

  # Print message
  case "${1}" in
    "${MESSAGE_OPTIONS_ERROR}")
      prompt "-e" "Error: ${2}" ;;
    "${MESSAGE_OPTIONS_WARNING}")
      prompt "-w" "${2}" ;;
    "${MESSAGE_OPTIONS_INFO}")
      prompt "-i" "${2}" ;;
    "${MESSAGE_OPTIONS_INFO_STATUS}")
      prompt "-il" "${2}" ;;
    "${MESSAGE_OPTIONS_SUCCESS}")
      prompt "-s" "${2}" ;;
  esac
}