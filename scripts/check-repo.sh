#!/bin/sh

PROJECT_NAME=$(echo $1 | rev | cut -d'/' -f1 | rev)
echo "--> Project: $PROJECT_NAME"

# Check remote
echo "--> Checking remote repository"
COMMIT_ID=$(echo $(git ls-remote $1 deploy) |cut -d' ' -f1)
echo "---> Commit: $COMMIT_ID"

# Check currently running
echo "--> Checking local repository"
if [ ! -f /opt/$PROJECT_NAME.current_build ]; then
    echo "---> No local repository exists. Creating.."
    LOCAL_COMMIT=""
else
    LOCAL_COMMIT=$(cat /opt/$PROJECT_NAME.current_build)
    echo "---> Local commit: $LOCAL_COMMIT"
fi

if [ "$LOCAL_COMMIT" != "$COMMIT_ID" ]; then
    echo "--> Not in sync, will clone"
    if [ "$LOCAL_COMMIT" != "" ]; then
        echo "--> Deleting old files"
        rm -r /opt/$PROJECT_NAME
    fi

    echo "--> Cloning new files"
    git clone -b deploy $1 /opt/$PROJECT_NAME

    echo "--> Updating current_build"
    echo $COMMIT_ID > /opt/$PROJECT_NAME.current_build

    cd /opt/$PROJECT_NAME/
    if [ -f /opt/$PROJECT_NAME/setup.sh ]; then
        chmod +x setup.sh
        ./setup.sh
    fi

   # Dont automate running, before we have a way of shutting down existing
   # if [ -f /opt/$PROJECT_NAME/run.sh ]; then
   #     chmod +x run.sh
   #     ./run.sh &
   # fi
fi