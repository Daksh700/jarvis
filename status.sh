#!/bin/sh

cd ~/Desktop/vionaut 

echo "Branch:"
git branch --show-current

echo "Uncommited file count:"
git status --short | wc -l

echo "Last 5 commits:"
git log -5
