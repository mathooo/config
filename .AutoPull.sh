#! /bin/bash

repos=( "/home/matho/Desktop/BCSgen" "/home/matho/Desktop/BCSLsemantics" )

for repo in "${repos[@]}"
do
	git -C $repo pull
done
