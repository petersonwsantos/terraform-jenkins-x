echo -e "\033[1;36mWaiting Delete Helm jenkins-x..."
while  ! helm list jxing; do
  echo -e "\033[1;36mWaiting Delete Helm jenkins-x..."
  sleep 5
done
echo -e "\033[1;36mDelete Helm jenkins-x OK"
