#!/bin/bash
# OpenAM REST Client
# Return List of Agents

# Pull in the settings file
source settings

echo -e "Enter the Admin password"
read -s pass

BASE_URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam"
FILTER="agent*"

#AUTHN the admin user

AUTH_URL="$BASE_URL/identity/authenticate"
AUTH_DATA="username=amadmin&password=$pass"
AUTH_TOKEN="$(curl -s --request POST --data $AUTH_DATA $AUTH_URL)"
AUTH_TOKEN2=${AUTH_TOKEN:9}
echo "Auth Token: " $AUTH_TOKEN2

# SEARCH for the names of all agents, matching the filter

#URL="$BASE_URL/json/agents"
URL="$BASE_URL/identity/search"
DATA="filter=$FILTER&attributes_names=objecttype&attributes_values_objecttype=agent&admin=$AUTH_TOKEN2"
echo "URL: " $URL
echo "DATA: " $DATA

TOKEN="$(curl -s --request POST --data $DATA $URL)"
echo $TOKEN
