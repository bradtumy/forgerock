#!/bin/bash
# This script will authenticate a user and then check their
# entitlements on a resource url that is provided to it.

echo -e "Enter the UID of the subject to authenticate:"
read uid
echo -e "Enter the subject's password:"
read -s pass
echo -e "Enter the OpenAM's Server FQDN incl the OpenAM Context:"
read server
echo -e "Enter the protected resource URL:"
read resource
echo -e "How many times should I check?"
read count

#Authenticate
url1="$server/identity/authenticate"
content="$(curl -s --request POST --data "username=$uid&password=$pass" $url1)"
#echo $content

# Check to see if authn was successful, stop script if not
if [[ $content == t* ]];
then 
  echo -e "Authentication Successful"'\n'
  token=${content:9} # Capture the substr after "tokenid="
  #echo -e "Token for authenticated user:"
  #echo -e $token'n' # for debugging, display the tokenid
  sleep 2
  echo -e "Checking Entitlements: "'\n'
  sleep 1
  url="$server/identity/authorize?uri=$resource&action=GET&subjectid="
  myUrl=$url$token
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

