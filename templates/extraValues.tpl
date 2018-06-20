expose:
  config:
    domain: ${ip_lb}
    exposer: Ingress
    http: "true"
    tlsacme: "false"
  Annotations:
    helm.sh/hook: post-install,post-upgrade
    helm.sh/hook-delete-policy: hook-succeeded
