helm list || jx init --provider=aws --skip-ingress
helm list jxing  &&  helm delete jxing --purge
helm list jenkins-x  && helm delete jenkins-x --purge
helm list && helm reset --force
kubectl get namespace jx && kubectl delete namespace jx
ls ~/.jx && rm ~/.jx -rf
ls ~/.helm && rm ~/.helm -rf
