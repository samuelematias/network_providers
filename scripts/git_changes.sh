#!/usr/bin/env bash

# checks if any code changes have occurred in CI.
if [[ -z $(git status --porcelain) ]]; then
    echo "Its is clean"
else
    echo "Run ./flutter_packages first because has changes in git"
    exit 1
fi
