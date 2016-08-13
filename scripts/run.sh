#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR

chmod +x check-repo.sh

if [ -z "$1" ]; then
    if [ -f /etc/projects ]: then
        echo "--> Using /etc/projects"
        while read project; do
            ./check-repo.sh $project        
        done </etc/projects
    else
        echo "--> Could not find /etc/projects and no repository was given"
    fi
else
    echo "--> Using input repository $1"
    ./check-repo.sh $1
fi