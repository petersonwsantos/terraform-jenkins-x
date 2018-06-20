echo -e "\033[1;36mWaiting kubernetes..."
while  ! kubectl get nodes; do
  echo -e "\033[1;36mWaiting kubernetes..."
  sleep 10
done
  echo -e "\033[1;36mkubernetes OK!"