echo -e "\033[1;36mWaiting Helm ..."
while  ! helm list; do
  echo -e "\033[1;36mWaiting Helm ..."
  sleep 10
done
helm version
echo -e "\033[1;36mHelm OK"
