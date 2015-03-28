#!/bin/bash

directories=`ls -d */`
export arguments=$@

clearRepositoriesList() {
  touch .repositories
  rm .repositories
}

runCommand() {
  purple='\033[35m'
  nc='\033[0m'

  echo -e "${purple}$1${nc}"

  git -C $1 $arguments

  echo
  return 0
}

clone() {
  purple='\033[35m'
  nc='\033[0m'

  echo -e "${purple}$1${nc}"

  git clone $1

  echo
  return 0
}

writeRepositoryList() {
  git -C $1 config --get remote.origin.url >> .repositories
}

export -f clone
export -f writeRepositoryList
export -f runCommand


if [[ $1 == "clone" ]]; then
  cat .repositories | xargs -n1 -I {} bash -c 'clone {}'
else
  clearRepositoriesList

  echo $directories | xargs -n1 -I {} bash -c 'runCommand {}'
  echo $directories | xargs -n1 -I {} bash -c 'writeRepositoryList {}'
fi
