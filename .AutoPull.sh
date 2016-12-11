#! /bin/bash

repos=( "/home/matho/Desktop/BCSgen" )

for repo in "${repos[@]}"
do
	git -C $repo pull
done
