#!/bin/bash

repositories=`ls -d */`
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

writeRepositoryList() {
  git -C $1 config --get remote.origin.url >> .repositories
}

export -f writeRepositoryList
export -f runCommand

clearRepositoriesList

echo $repositories | xargs -n1 -I {} bash -c 'runCommand {}'
echo $repositories | xargs -n1 -I {} bash -c 'writeRepositoryList {}'
