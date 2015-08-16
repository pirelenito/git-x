#!/bin/bash

directories=($(find . -maxdepth 2 -type d -name .git ! -path ./.git | sed 's/\/\.git//' | sed 's/\.\///'))
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

  # ignores this directory since it is inside other git repository
  grep -q $1 .gitignore || echo $1 >> .gitignore
}

export -f clone
export -f writeRepositoryList
export -f runCommand

if [[ $1 == "clone" ]]; then
  cat .gitrepositories | xargs -n1 -I {} bash -c 'clone {}'
else
  if [[ $parentGitRepository == "./.git" ]]; then
    clearRepositoriesList
    for repository in ${directories[@]}; do writeRepositoryList $repository; done

    # we want to run the git command locally after the repositories list was updated
    runCommand .
  fi

  for repository in ${directories[@]}; do runCommand $repository; done
fi
