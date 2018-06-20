# RBAC for Helm
resource "null_resource" "helm_rbac" {
  # serviceaccount ---------------------------------------------
  provisioner "local-exec" {
    command     = "kubectl create serviceaccount --namespace kube-system tiller"
  }

  # delete
  provisioner "local-exec" {
    when        = "destroy"
    command     = "kubectl get serviceaccount --namespace kube-system tiller && kubectl delete serviceaccount tiller --namespace=kube-system ; echo 0"
  }

  # clusterrolebinding --------------------------------------------
  provisioner "local-exec" {
    command     = "kubectl create clusterrolebinding ${var.kubernetes_context}-cluster-admin-binding --clusterrole=cluster-admin --serviceaccount=kube-system:tiller"
  }

  # delete
  provisioner "local-exec" {
    when        = "destroy"
    command     = "kubectl get clusterrolebinding ${var.kubernetes_context}-cluster-admin-binding  && kubectl delete clusterrolebinding ${var.kubernetes_context}-cluster-admin-binding ; echo 0"
  }

  depends_on = ["null_resource.kubernetes_check"]
}

#  Helm install
resource "null_resource" "helm_init" {
  provisioner "local-exec" {
    command     = "helm init --service-account tiller --tiller-namespace kube-system"
  }

  provisioner "local-exec" {
    command     = "helm init --upgrade --service-account tiller --tiller-namespace kube-system"
  }

  # delete helm
  provisioner "local-exec" {
    when        = "destroy"
    #command     = "helm list && helm reset --force ; rm -rf ~/.helm ; echo 0"
    command     = "helm list && helm reset --force ; echo 0"

  }
  depends_on = ["null_resource.helm_rbac"]
}

# wait helm ready
resource "null_resource" "helm_check" {
  provisioner "local-exec" {
    command     = "${file("${path.module}/scripts/waiter_helm.sh")}"
    interpreter = ["/bin/bash", "-c"]
  }

  depends_on = [
    "null_resource.helm_init",
  ]
}

# helm update repos
resource "null_resource" "helm_repo_update" {
  provisioner "local-exec" {
    command     = "helm repo update"
    interpreter = ["/bin/bash", "-c"]
  }

  depends_on = ["null_resource.helm_check"]
}
