#!/usr/bin/bash

set -u

BASEDIR=$(dirname $0)
cd $BASEDIR

for f in .??*; do
  [ "$f" = ".git" ] && continue
  [ "$f" = ".gitconfig.local.template" ] && continue
  [ "$f" = ".gitmodules" ] && continue

  ln -s ${PWD}/"$f" ~/
done

for f in $(find ?*/ -name config); do
  [ ! -d ${PWD}/$(dirname $f) ] && mkdir $(dirname $f)
  
  ln -s ${PWD}/"$f" ~/.config/"$f"
done
  
