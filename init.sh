#!/usr/bin/bash

set -u

BASEDIR=$(dirname $0)
cd $BASEDIR

mkdir -p ~/.cache/weather \
      ~/.cache/vim/ \
      ~/.cache/vim/backup \
      ~/.cache/vim/swp \
      ~/.scripts

for f in .??*; do
  [ "$f" = ".git" ] && continue
  [ "$f" = ".gitconfig.local.template" ] && continue
  [ "$f" = ".gitmodules" ] && continue

  ln -sn ${PWD}/"$f" ~/
done

for f in ./scripts/*.sh; do
  [ "$f" = ".git" ] && continue
  [ "$f" = ".gitconfig.local.template" ] && continue
  [ "$f" = ".gitmodules" ] && continue

  ln -sn ${PWD}/"$f" ~/.scripts
done

for f in $(find ?*/ -name config -o -name dunstrc); do
  [ ! -d ${PWD}/$(dirname $f) ] && mkdir -p $(dirname $f)
  ln -sn ${PWD}/"$f" ~/.config/"$f"
done

