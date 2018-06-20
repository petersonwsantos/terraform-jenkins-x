servers:
- url: http://chartmuseum.jx.${ip_lb}
  users:
  - username: ${admin_user}
    apitoken: ""
    bearertoken: ""
    password: ${admin_password}
  name: chartmuseum.jx.${ip_lb}
  kind: ""
  currentuser: ""
defaultusername: ""
currentserver: http://chartmuseum.jx.${ip_lb}
