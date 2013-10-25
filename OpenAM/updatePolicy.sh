echo -e "Enter the Admin uid:"
read  uid
echo -e "Enter the Admin password:"
read -s pass
echo -e "Enter the OpenAM Server FQDN:"
read server

echo -e "How many times should I run this update?"
read count

#Authenticate

url1="$server/identity/authenticate"
content="$(curl -s --request POST --data "username=$uid&password=$pass" $url1)"
echo $content

for ((c=1; c<=$count; c++))
 do
 curl --request PUT --cookie "iPlanetDirectoryPro=AQIC5wM2LY4SfczwoxyyMIEL3e1Yby4lDijbq6t0A5VMhQ0.*AAJTSQACMDE.*" --data-urlencode "privilege.json@update.json" $server/ws/1/entitlement/privilege/URLPolicy
 done
