#!/bin/bash

DIRECTORIES=`ls -d */`

echo $DIRECTORIES | xargs -t -I {} -n1 git -C {} $@
