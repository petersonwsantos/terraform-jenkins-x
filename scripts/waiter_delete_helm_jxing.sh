echo -e "\033[1;36mWaiting Delete Helm jxing..."
while  ! helm list jxing; do
  sleep 5
done
echo -e "\033[1;36mHelm Jenkins-X Ingress Delete"
