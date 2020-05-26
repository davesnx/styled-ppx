#!/bin/bash

function help() {
  echo "Usage: $(basename "$0") [<newversion> | major | minor | patch | premajor | preminor | prepatch | prerelease]"
}

if [ -z "$1" ] || [ "$1" = "help" ]; then
  help
  exit
fi

changes=$(git status --porcelain)
branch=$(git rev-parse --abbrev-ref HEAD)

if [ -n "${changes}" ]; then
  echo "Please commit staged files prior to bumping"
  exit 1
elif [ "${branch}" != "master" ]; then
  echo "Please run the release script on master"
  exit 1
else
  npm version "$1"
  git push origin --tags
fi
