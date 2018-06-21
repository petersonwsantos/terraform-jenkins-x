JXBasicAuth: ${admin_password_jxbasicauth_values}

chartmuseum:
  env:
    secret:
      BASIC_AUTH_USER: ${admin_user}
      BASIC_AUTH_PASS: ${admin_password}

jenkins:
  Master:
    AdminUser: ${admin_user}
    AdminPassword: ${admin_password}
