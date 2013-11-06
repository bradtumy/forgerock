#!/bin/bash
# OpenAM REST Client
# Authenticate a user using the new REST API

# Source the Settings file
source settings

clear # clear the screen to clean up any previous runs
echo -e "What is the user to authenticate?"
read USER

echo -e "What is the password?"
read -s PASS

URL=$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/json/authenticate?_prettyPrint=true
echo -e "Starting Authentication"

RESULT="$(curl -s --request POST --header "X-OpenAM-Username: $USER" --header "X-OpenAM-Password: $PASS" --header "Content-Type: application/json" --data "{}" $URL)"

clear
#echo -e $RESULT | $JQ_LOC .
#echo -e $RESULT

USER_AM_TOKEN=$(echo "$RESULT" | cut -d':' -f 2 | cut -d',' -f 1 | cut -d'"' -f 2)
echo -e "USER_AM_TOKEN: " $USER_AM_TOKEN

