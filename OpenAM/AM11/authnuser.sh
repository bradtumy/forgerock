#!/bin/bash
# OpenAM REST Client
# Authenticate a user using the new REST API

# Source the Settings file
source settings

# if the username & password are not provided
# as arguments then prompt the user for them

if [[ "$1" = "" ]]; then
  echo ""
  echo "You did not provide a username."
  echo ""
  echo -e "What is the username that I should authenticate?"
  read USER
else 
  USER=$1
fi

if [[ "$2" = "" ]]; then
  echo ""
  echo "You did not provide a password."
  echo ""
  echo -e "What is the password for this user?"
  read -s PASS
else
  PASS=$2
fi

URL=$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/json/authenticate?_prettyPrint=true
echo -e "Starting Authentication"

RESULT="$(curl -s --request POST --header "X-OpenAM-Username: $USER" --header "X-OpenAM-Password: $PASS" --header "Content-Type: application/json" --data "{}" $URL)"

clear
#echo -e $RESULT | $JQ_LOC .
#echo -e $RESULT

USER_AM_TOKEN=$(echo "$RESULT" | cut -d':' -f 2 | cut -d',' -f 1 | cut -d'"' -f 2)
echo -e "USER_AM_TOKEN: " $USER_AM_TOKEN

