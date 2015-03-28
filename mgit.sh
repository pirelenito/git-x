#!/bin/bash

repositories=`ls -d */`
export arguments=$@

runCommand() {
  purple='\033[35m'
  nc='\033[0m'

  echo -e "${purple}$1${nc}"

  git -C $1 $arguments

  echo
  return 0
}

export -f runCommand

echo $repositories | xargs -n1 -I {} bash -c 'runCommand {}'
