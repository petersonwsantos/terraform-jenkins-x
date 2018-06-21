variable "git_user" {
  description = "git username "
}

variable "git_token" {
  description = "token git"
}

variable "admin_user" {
  description = "Admin username for Jenkins-x"
}

variable "admin_password" {
  description = "Admin password for Jenkins-x"
}

variable "admin_password_jxbasicauth_values" {
   description = "output  htpasswd -nb admin myy_admin_password"
}

variable "admin_password_jxbasicauth" {
   description = "output  htpasswd -nb admin myy_admin_password"
}


variable "kubernetes_context" {
  description = "kubernetes context"
}
