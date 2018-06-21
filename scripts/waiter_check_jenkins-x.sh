echo -e "\033[1;36m Waiting Jenkins-x check..."
while  ! jx status; do
  sleep 5
done
while  ! jx version --no-version-check=true; do
  sleep 5
done
echo -e "\033[1;36m Jenkins-X check OK "
