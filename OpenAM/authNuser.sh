#!/bin/bash
#OpenAM REST Client
#Authenticate a user using username and password.

# Pull in settings file
source settings

echo -e "Enter the subject's uid:"
read  uid
echo -e "Enter the subject's password:"
read -s pass

URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/identity/json/authenticate"
DATA="username=$uid&password=$pass"

echo ""

TOKEN="$(curl -s --request POST --data $DATA $URL)"
echo $TOKEN
