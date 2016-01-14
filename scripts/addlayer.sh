#!/bin/bash
if [ "$1" = "-h" ] || [ $# -eq 0 ]; then
	echo "You should type $0 repo#version or type $0 -h to see this"
	exit 0
fi

repo=$1
cd layersbox
./layersbox install learning-layers/$repo
echo "Done with $repo"
exit 0
