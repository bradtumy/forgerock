#!/bin/bash
# This script will authenticate a user and then check their
# entitlements on a resource url that is provided to it.

#import settings
source settings

echo -e "Enter the UID of the subject to authenticate:"
read uid
echo -e "Enter the subject's password:"
read -s pass
echo -e "How many times should I check?"
read count

#Authenticate
URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/identity/authenticate"
DATA="username=$uid&password=$pass"
RESOURCE=$PROTECTED_RESOURCE

TOKEN="$(curl -s --request POST --data $DATA $URL)"
#echo $TOKEN

# Check to see if authn was successful, stop script if not
if [[ $TOKEN == t* ]];
then 
  echo -e "Authentication Successful"'\n'
  TOKEN1=${TOKEN:9} # Capture the substr after "tokenid="
  #echo -e "Token for authenticated user:"
  #echo -e $token'n' # for debugging, display the tokenid
  sleep 2
  echo -e "Checking Entitlements: "'\n'
  sleep 1
  url="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/identity/authorize?uri=$RESOURCE&action=GET&subjectid="
  myUrl=$url$TOKEN1
  echo -e "Here is the command I am going to run:\n"
  echo -e $myUrl'\n' # for debugging, show myUrl
  sleep 3
  for ((c=1; c<=$count; c++))
  do
	content="$(curl -s "$myUrl" )"
        echo "$content"
  done 
else
  echo -e "Authentication Failed"'\n'
  exit 0
fi

