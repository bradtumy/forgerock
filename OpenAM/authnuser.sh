echo -e "Enter the subject's uid:"
read  uid
echo -e "Enter the subject's password:"
read -s pass
echo -e "Enter the OpenAM Server FQDN:"
read server

#Authenticate

url1="$server/identity/authenticate"
content="$(curl -s --request POST --data "username=$uid&password=$pass" $url1)"
echo $content
