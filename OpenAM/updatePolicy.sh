#!/bin/bash
#OpenAM scripts


source settings

echo -e "Enter the Admin uid:"
read  uid
echo -e "Enter the Admin password:"
read -s pass

echo -e "How many times should I run this update?"
read count

#Authenticate

URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/identity/authenticate"
DATA="username=$uid&password=$pass"

echo ""

#Get AuthN user token
TOKEN="$(curl -s --request POST --data $DATA $URL)"

# Check Entitlements
PRIV_URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/ws/1/entitlement/privilege/URLPolicy"
COOKIE="iPlanetDirectoryPro=${TOKEN:9}"

for ((c=1; c<=$count; c++))
do
  curl --request PUT --cookie "$COOKIE" --data-urlencode "privilege.json@update.json" "$PRIV_URL"
  echo "$c"
done
