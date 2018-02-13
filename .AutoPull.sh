#! /bin/bash

FILES=/path/to/*

for repo in $FILES
do
	git -C $repo pull
done
