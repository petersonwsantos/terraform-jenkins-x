resource "null_resource" "jenkins-x_download_cloud-environments" {
  provisioner "local-exec" {
    command = "mkdir -p ~/.jx"
  }

  provisioner "local-exec" {
    command = "if cd ~/.jx/cloud-environments; then git pull; else git clone https://github.com/jenkins-x/cloud-environments.git ~/.jx/cloud-environments; fi "
  }

  provisioner "local-exec" {
    when        = "destroy"
    command     = "rm -rf ~/.jx/cloud-environments"
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "jenkins-x_download_draft" {
  provisioner "local-exec" {
    command = "mkdir -p ~/.jx"
  }

  provisioner "local-exec" {
    command = "if cd ~/.jx/draft; then git pull; else git clone https://github.com/jenkins-x/draft-packs.git ~/.jx/draft;fi"
  }

  provisioner "local-exec" {
    when        = "destroy"
    command     = "rm -rf ~/.jx/draft"
    interpreter = ["/bin/bash", "-c"]
  }
}

# jx install
resource "helm_repository" "jenkins-x_repo" {
  name       = "jenkins-x"
  url        = "http://chartmuseum.build.cd.jenkins-x.io"
  depends_on = [
    "null_resource.helm_init" ,
    "null_resource.helm_check",
    "null_resource.helm_repo_update"
  ]
}

resource "helm_release" "jenkins-x" {
  name       = "jenkins-x"
  chart      = "jenkins-x-platform"
  repository = "jenkins-x"
  namespace  = "jx"
  version    = "0.0.1193"
  timeout    = "6000"

  values = [
    "${file("${path.module}/conf/gitSecrets.yaml")}",
    "${file("${path.module}/conf/adminSecrets.yaml")}",
    "${file("${path.module}/conf/extraValues.yaml")}",
  ]

  depends_on = [
    "null_resource.helm_init",
    "helm_repository.jenkins-x_repo",
    "null_resource.jenkins-x_download_cloud-environments",
    "null_resource.jenkins-x_download_draft",
    "null_resource.extraValues_render",
    "null_resource.adminSecrets_render",
    "null_resource.gitSecrets_render",
    "null_resource.chartmuseumAuth_render"
  ]
}

resource "null_resource" "jenkins-x_delete" {
  # provisioner "local-exec" {  #   when    = "destroy"  #   command = "helm delete jenkins-x --purge; echo 0"  # }

  provisioner "local-exec" {
    when    = "destroy"
    command = "kubectl delete namespace jx; echo 0"
  }
  provisioner "local-exec" {
    when    = "destroy"
    command = "kubectl delete configmaps jenkins-x.v1 -n kube-system; echo 0"
  }

  provisioner "local-exec" {
    command     = "${file("${path.module}/scripts/waiter_delete_helm_jenkins-x.sh")}"
    when        = "destroy"
    interpreter = ["/bin/bash", "-c"]
  }
  depends_on = [
    "null_resource.helm_init",
  ]
}

# sudo apt-download install graphviz


# wait helm ready
