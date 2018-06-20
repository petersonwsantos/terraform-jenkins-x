echo -e "\033[1;36mWaiting deploy nginx-ingress..."
while  ! kubectl get services -n jx -o wide; do
  echo -e "\033[1;36mWaiting deploy nginx-ingress..."
  sleep 5
done
echo -e "\033[1;36mDeploy nginx-ingress OK"

echo -e "\033[1;36mWaiting for resolv DNS LB..."
while  ! host `kubectl get services -n jx -o wide | grep ^jxing-nginx-ingress-controller | awk  '{print $4}'`; do
  echo -e "\033[1;36mWaiting for resolv DNS LB..."
  sleep 10
done
echo -e "\033[1;36mDNS LB OK"

export LB_IP="$(dig +short `kubectl get services -n jx -o wide | grep ^jxing-nginx-ingress-controller | awk  '{print $4}'| sed -n '1p'`)"

if  [[ "$LB_IP" == "" ]]
then
  export LB_IP="$(kubectl get services -n jx -o wide | grep ^jxing-nginx-ingress-controller | awk  '{print $4}'| sed -n '1p')"
fi  

export LB_DOMAIN=".nip.io"
mkdir -p ~/.jx
echo "${LB_IP}${LB_DOMAIN}" > ~/.jx/ip_lb.txt
