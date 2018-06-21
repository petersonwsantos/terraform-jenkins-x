variable "provider" {
  default = "Cloud provider"
}

variable "git_provider_url" {
  default = "https://github.com"
}

variable "git_owner" {
  default = ""
}

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


variable "kubernetes_context" {
  description = "kubernetes context"
}

variable "environments" {
  default = "1-development"
  #default = "1-development 2-staging 3-production"
}
