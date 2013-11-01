#!/bin/bash
# OpenAM REST Client
# Return List of Agents

# Pull in the settings file
source settings

echo -e "Enter the Admin password"
read -s pass

BASE_URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam"
FILTER="$FILTER"

#AUTHN the admin user

AUTH_URL="$BASE_URL/identity/authenticate"
AUTH_DATA="username=amadmin&password=$pass"
AUTH_TOKEN="$(curl -s --data $AUTH_DATA $AUTH_URL)"
AUTH_TOKEN2=${AUTH_TOKEN:9}
#echo "Auth Token: " $AUTH_TOKEN2

# SEARCH for the names of all agents, matching the filter

URL="$BASE_URL/json/agents?_queryID=$FILTER"
#URL="$BASE_URL/identity/search" ##legacy API
#echo "URL: " $URL
<<<<<<< HEAD
TOKEN="$(curl --header "iPlanetDirectoryPro: $AUTH_TOKEN2" --header "Content-Type: application/json" $URL)"
=======
TOKEN="$(curl -s --header "iPlanetDirectoryPro: $AUTH_TOKEN2" --header "Content-Type: application/json" $URL)"
>>>>>>> 1b260d6b0d9d3f4030bb136158dc825d34ec1bc4
echo $TOKEN
