
resource "helm_release" "ingress_init" {
  name      = "jxing"
  chart     = "stable/nginx-ingress"
  namespace = "jx"

  values = [
    "${file("${path.module}/templates/values_jxing.yaml")}",
  ]

  depends_on = [
    "null_resource.helm_repo_update",
    "null_resource.helm_init"
  ]
}

# "helm", "install", "--name", "jxing", "stable/nginx-ingress", "--namespace", ingressNamespace, "--set", "rbac.create=true"
resource "null_resource" "ingress_delete" {

  provisioner "local-exec" {
    command     = "${file("${path.module}/scripts/waiter_delete_helm_jxing.sh")}"
    when        = "destroy"
  }

  depends_on = [
    "null_resource.helm_init",
    "helm_release.ingress_init"
  ]
}
