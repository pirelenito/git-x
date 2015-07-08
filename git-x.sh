#!/bin/bash

directories=`find . -maxdepth 2 -name .git | sed 's/\/\.git//' | sed 's/\.\///'`
parentGitRepository=`find . -maxdepth 1 -name .git`
export arguments=$@

clearRepositoriesList() {
  touch .gitrepositories
  rm .gitrepositories
}

runCommand() {
  purple='\033[35m'
  nc='\033[0m'

  echo -e "${purple}${PWD##*/}/$1${nc}"

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
  if [[ $parentGitRepository == "./.git" ]]; then
    clearRepositoriesList
    echo $directories | xargs -n1 -I {} bash -c 'writeRepositoryList {}'

    # we want to run the git command locally after the repositories list was updated
    runCommand .
  fi

  echo $directories | xargs -n1 -I {} bash -c 'runCommand {}'
fi
