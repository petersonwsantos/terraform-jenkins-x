# provider "aws" {
#   access_key = "${file("/home/vagrant/.aws/credentials")}"
#   secret_key = "${file("/home/vagrant/.aws/credentials")}"
#   region     = "us-east-1"
# }

provider "helm" {
  service_account = "tiller"
  namespace       = "kube-system"

  kubernetes {
    config_context = "${var.kubernetes_context}"
  }
}

# # context
# provider "kubernetes" {
#   config_context_cluster = "${var.kubernetes_context}"
# }

# check kubernetes
resource "null_resource" "kubernetes_check" {
  provisioner "local-exec" {
    command     = "${file("${path.module}/scripts/waiter_kubernetes.sh")}"
    interpreter = ["/bin/bash", "-c"]
  }
}
