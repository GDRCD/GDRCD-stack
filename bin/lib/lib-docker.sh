#!/bin/bash

# Set Library Name
LIB_NAME="lib-docker.sh"

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
# Utilities
# ---------------------------------------------------------------------

# Check if docker is installed
isDockerInstalled() {
  if ! command -v docker &> /dev/null; then
    prompt -e "Error! Docker is not installed. Please install it first."
    exit 1
  fi
}

# Check if docker-compose is installed
isDockerComposeInstalled() {
  if ! command -v docker compose &> /dev/null; then
    prompt -e "Error! Docker Compose is not installed. Please install it first."
    exit 1
  fi
}

# Check if docker is running
isDockerRunning() {
  if ! docker info &> /dev/null; then
    prompt -e "Error! Docker is not running. Please start it first."
    exit 1
  fi
}

isContainerExist() {
  # if container name is passed as argument, check if it exists
  if [[ "$1" ]]; then
    if [[ ! "$(docker ps -aq -f name="${PROJECT}_$1")" ]] && [[ ! "$(docker ps -aq -f name="${PROJECT}_$1")" ]]; then
      prompt -e "Error! Container '${PROJECT}_$1' is not found."
      exit 1
    fi
    return 0;
  fi
  # otherwise, check if all containers exist
  for service in "${SERVICES_VARIANTS[@]}"; do
    # database
    if [[ "$service" == "database" ]]; then
      if [[ ! "$(docker ps -aq -f name="${PROJECT}_$service")" ]]; then
        prompt -e "Error! Container '${PROJECT}_$service' is not found."
        exit 1
      fi
      continue
    fi

    # other services
    if [[ ! "$(docker ps -aq -f name="${PROJECT}_$service")" ]]; then
      prompt -e "Error! Container '${PROJECT}_$service' is not found."
      exit 1
    fi
  done
}

isContainerRunning() {
  # if container name is passed as argument, i check if it's running
  if [[ "$1" ]]; then
    if [[ ! "$(docker ps -q -f name="${PROJECT}_$1")" ]] && [[ ! "$(docker ps -q -f name="${PROJECT}_$1")" ]]; then
      prompt -e "Error! Container '${PROJECT}_$1' is not running."
      exit 1
    fi
    return 0;
  fi

  # otherwise, i check if all containers are running
  for service in "${SERVICES_VARIANTS[@]}"; do
    # database
    if [[ "$service" == "database" ]]; then
      if [[ ! "$(docker ps -q -f name="${PROJECT}_$service")" ]]; then
        prompt -e "Error! Container '${PROJECT}_$service' is not running."
        exit 1
      fi
      continue
    fi
    # other services
    if [[ ! "$(docker ps -q -f name="${PROJECT}_$service")" ]]; then
      prompt -e "Error! Container '${PROJECT}_$service' is not running."
      exit 1
    fi
  done
}

# ---------------------------------------------------------------------
# Commands
# ---------------------------------------------------------------------

dockerCompose() {
  # Check if docker compose is installed
  isDockerComposeInstalled
  # Check if docker is running
  isDockerRunning

  export \
    STACK_DIR ;
  docker compose -p "${PROJECT}" -f "$DOCKER_DIR/compose.yml" --env-file "$STACK_DIR/.env" "$@"
}