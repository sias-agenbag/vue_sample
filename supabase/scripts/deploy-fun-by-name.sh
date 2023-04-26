echo "Function deploy helper\n" 
result=$(ls -a | grep ".env")
if [ -z "$result" ]; then
  echo "No .env file found"
  echo "Please run the script from the root of supabase folder"
  exit 1
fi
cp .env.local .env
while read -r line; do
  supabase secrets set "$line"
done <.env

## supabase functions deploy $ARG_FUNCTION_NAME

if [[ "$1" == "-a" ]]; then
  echo "Deploying function $2 with anonymous level authorization"
  supabase functions deploy $2 --no-verify-jwt
  echo "End deploying"
  
else
  echo "Deploying function $ARG_FUNCTION_NAME with authentication level authorization"
  supabase functions deploy $ARG_FUNCTION_NAME --no-verify-jwt --auth=authorization
fi

clear
