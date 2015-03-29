#!/bin/bash

directories=`find . -depth 2 -name .git | sed 's/\/\.git//' | sed 's/\.\///'`
export arguments=$@

clearRepositoriesList() {
  touch .gitrepositories
  rm .gitrepositories
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
  git -C $1 config --get remote.origin.url >> .gitrepositories
}

export -f clone
export -f writeRepositoryList
export -f runCommand


if [[ $1 == "clone" ]]; then
  cat .gitrepositories | xargs -n1 -I {} bash -c 'clone {}'
else
  clearRepositoriesList

  runCommand .
  echo $directories | xargs -n1 -I {} bash -c 'runCommand {}'
  echo $directories | xargs -n1 -I {} bash -c 'writeRepositoryList {}'
fi
